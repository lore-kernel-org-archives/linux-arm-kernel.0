Return-Path: <SRS0=x1Tr=QU=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA199C282C2
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 07:56:00 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 884A6222BA
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 07:56:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Rqy6/w76"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 884A6222BA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Date:To:From:Subject:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=KDxdVjRqQYsMCCI/flNoTY0AcJJyF2+cXOQZMBrRvuQ=; b=Rqy6/w76AcCqnu
	0yCpzk4oIqpoxFaSTNVosATxvWeftsqFHAKbOZ6wCUgGdPYldRi1YP+omX7P7nxBC/++FW4LbbMtA
	GSYw56zyor/8BzwRpqAKuJJcV6H7R8enuftlNa9aBetI4N5krjPiGtN+p/09MOrachterptwuXwkJ
	hCuv/J8Vk36Y0SryMv2XnFEZK9FQZ8CCT6uOXgWYp2i+m3jbOwLB8qfkf19W313Hls+gCspboBpoE
	fUUIohtPSG3KRT8oZfSJgztN+OMccIrp7ApUHtPY81sS/MrV9QUxiuyx5ZWiub67fPdChZ8oAHKRK
	eNfqteZgYpmRddFMMkTw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gtpOg-0005G7-C3; Wed, 13 Feb 2019 07:55:58 +0000
Received: from mailgw01.mediatek.com ([216.200.240.184])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gtpOc-0005Ej-Ie; Wed, 13 Feb 2019 07:55:56 +0000
X-UUID: d153ef9b8a5f455780ae2e4ac9ac0430-20190212
X-UUID: d153ef9b8a5f455780ae2e4ac9ac0430-20190212
Received: from mtkcas67.mediatek.inc [(172.29.193.45)] by mailgw01.mediatek.com
 (envelope-from <chaotian.jing@mediatek.com>)
 (musrelay.mediatek.com ESMTP with TLS)
 with ESMTP id 1266948473; Tue, 12 Feb 2019 23:55:44 -0800
Received: from mtkmbs03n2.mediatek.inc (172.21.101.182) by
 MTKMBS62DR.mediatek.inc (172.29.94.18) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Tue, 12 Feb 2019 23:55:42 -0800
Received: from MTKCAS36.mediatek.inc (172.27.4.186) by mtkmbs03n2.mediatek.inc
 (172.21.101.182) with Microsoft SMTP Server (TLS) id 15.0.1395.4;
 Wed, 13 Feb 2019 15:55:41 +0800
Received: from [10.17.3.153] (10.17.3.153) by MTKCAS36.mediatek.inc
 (172.27.4.170) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Wed, 13 Feb 2019 15:55:40 +0800
Message-ID: <1550044540.16070.23.camel@mhfsdcap03>
Subject: Re: [PATCH] mmc: mmc: Fix HS setting in mmc_hs400_to_hs200()
From: Chaotian Jing <chaotian.jing@mediatek.com>
To: Ulf Hansson <ulf.hansson@linaro.org>
Date: Wed, 13 Feb 2019 15:55:40 +0800
In-Reply-To: <CAPDyKFpL9DT_JUgWe9ZeOSro9vQ-xh9TnpP3zkRxJ8pb=0jyXg@mail.gmail.com>
References: <1548921212-5219-1-git-send-email-chaotian.jing@mediatek.com>
 <CAPDyKFruCCs_un1oR-gd1P=ZGryyHwKuY0SkvLO2=Jm1bGV6sQ@mail.gmail.com>
 <1548985091.10251.26.camel@mhfsdcap03>
 <CAPDyKFqHJn9uVkd5z4D5JvNKOtbn3E3SwL_WSgLb1=Lw1SgyUg@mail.gmail.com>
 <0e95e1a1-843e-38ea-c4bb-e6c48432ea7c@intel.com>
 <CAPDyKFrvSgK0Om7GUJ143j=U2xDG4n6z6Ym-1znbtMbaw==HkQ@mail.gmail.com>
 <c9120e57-ad7c-174d-c155-0186e0b9c359@intel.com>
 <CAPDyKFotLzLxW=Wq6hCPFmwTQ=T43rJV9h=+p5jfgrMBe=d8BA@mail.gmail.com>
 <4c8a616f-f424-fd58-43c5-d6042665bc58@intel.com>
 <1549937058.16070.5.camel@mhfsdcap03>
 <566c0c11-be9c-73a3-d7ff-34aed3ad7db0@intel.com>
 <1550019275.16070.6.camel@mhfsdcap03>
 <1550027594.16070.15.camel@mhfsdcap03>
 <CAPDyKFpL9DT_JUgWe9ZeOSro9vQ-xh9TnpP3zkRxJ8pb=0jyXg@mail.gmail.com>
X-Mailer: Evolution 3.2.3-0ubuntu6 
MIME-Version: 1.0
X-TM-SNTS-SMTP: 99A27629A2BEEA9277B8AA1095200A09CAF1D3BD5014ABC6C900AF5A433CA4E52000:8
X-MTK: N
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190212_235554_645789_15EF2535 
X-CRM114-Status: GOOD (  47.54  )
X-BeenThere: linux-arm-kernel@lists.infradead.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <linux-arm-kernel.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>, 
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>, 
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: srv_heupstream <srv_heupstream@mediatek.com>,
 Shawn Lin <shawn.lin@rock-chips.com>,
 "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
 Adrian Hunter <adrian.hunter@intel.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 linux-mediatek@lists.infradead.org,
 Harish Jenny K N <harish_kandiga@mentor.com>,
 Hongjie Fang <hongjiefang@asrmicro.com>,
 Matthias Brugger <matthias.bgg@gmail.com>, Simon
 Horman <horms+renesas@verge.net.au>, Kyle Roeschley <kyle.roeschley@ni.com>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Wed, 2019-02-13 at 08:24 +0100, Ulf Hansson wrote:
> On Wed, 13 Feb 2019 at 04:13, Chaotian Jing <chaotian.jing@mediatek.com> wrote:
> >
> > On Wed, 2019-02-13 at 08:54 +0800, Chaotian Jing wrote:
> > > On Tue, 2019-02-12 at 10:04 +0200, Adrian Hunter wrote:
> > > > On 12/02/19 4:04 AM, Chaotian Jing wrote:
> > > > > On Tue, 2019-02-05 at 15:42 +0200, Adrian Hunter wrote:
> > > > >> On 5/02/19 3:06 PM, Ulf Hansson wrote:
> > > > >>> On Mon, 4 Feb 2019 at 14:42, Adrian Hunter <adrian.hunter@intel.com> wrote:
> > > > >>>>
> > > > >>>> On 4/02/19 12:54 PM, Ulf Hansson wrote:
> > > > >>>>> On Mon, 4 Feb 2019 at 10:58, Adrian Hunter <adrian.hunter@intel.com> wrote:
> > > > >>>>>>
> > > > >>>>>> On 1/02/19 10:10 AM, Ulf Hansson wrote:
> > > > >>>>>>> On Fri, 1 Feb 2019 at 02:38, Chaotian Jing <chaotian.jing@mediatek.com> wrote:
> > > > >>>>>>>>
> > > > >>>>>>>> On Thu, 2019-01-31 at 16:58 +0100, Ulf Hansson wrote:
> > > > >>>>>>>>> On Thu, 31 Jan 2019 at 08:53, Chaotian Jing <chaotian.jing@mediatek.com> wrote:
> > > > >>>>>>>>>>
> > > > >>>>>>>>>> mmc_hs400_to_hs200() begins with the card and host in HS400 mode.
> > > > >>>>>>>>>> Therefore, any commands sent to the card should use HS400 timing.
> > > > >>>>>>>>>> It is incorrect to reduce frequency to 50Mhz before sending the switch
> > > > >>>>>>>>>> command, in this case, only reduce clock frequency to 50Mhz but without
> > > > >>>>>>>>>> host timming change, host is still in hs400 mode but clock changed from
> > > > >>>>>>>>>> 200Mhz to 50Mhz, which makes the tuning result unsuitable and cause
> > > > >>>>>>>>>> the switch command gets response CRC error.
> > > > >>>>>>>>>
> > > > >>>>>>>>> According the eMMC spec there is no violation by decreasing the clock
> > > > >>>>>>>>> frequency like this. We can use whatever value <=200MHz.
> > > > >>>>>>>>>
> > > > >>>>>>>>> However, perhaps in practice this becomes an issue, due to the tuning
> > > > >>>>>>>>> for HS400 has been done on the "current" frequency.
> > > > >>>>>>>>>
> > > > >>>>>>>>> As as start, I think you need to clarify this in the changelog.
> > > > >>>>>>>>>
> > > > >>>>>>>> Yes, reduce clock frequency to 50Mhz is no Spec violation, but it may
> > > > >>>>>>>> cause __mmc_switch() gets response CRC error, decreasing the clock but
> > > > >>>>>>>> without HOST mode change, on the host side, host driver do not know
> > > > >>>>>>>> what's operation the core layer want to do and can only set current bus
> > > > >>>>>>>> clock to 50Mhz, without tuning parameter change, it has a chance lead to
> > > > >>>>>>>> response CRC error. even lower clock frequency, but with the wrong
> > > > >>>>>>>> tuning parameter setting(the setting is of hs400 tuning @200Mhz).
> > > > >>>>>>>
> > > > >>>>>>> Right, makes sense.
> > > > >>>>>>>
> > > > >>>>>>>>>>
> > > > >>>>>>>>>> this patch refers to mmc_select_hs400(), make the reduce clock frequency
> > > > >>>>>>>>>> after card timing change.
> > > > >>>>>>>>>>
> > > > >>>>>>>>>> Signed-off-by: Chaotian Jing <chaotian.jing@mediatek.com>
> > > > >>>>>>>>>> ---
> > > > >>>>>>>>>>  drivers/mmc/core/mmc.c | 8 ++++----
> > > > >>>>>>>>>>  1 file changed, 4 insertions(+), 4 deletions(-)
> > > > >>>>>>>>>>
> > > > >>>>>>>>>> diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
> > > > >>>>>>>>>> index da892a5..21b811e 100644
> > > > >>>>>>>>>> --- a/drivers/mmc/core/mmc.c
> > > > >>>>>>>>>> +++ b/drivers/mmc/core/mmc.c
> > > > >>>>>>>>>> @@ -1239,10 +1239,6 @@ int mmc_hs400_to_hs200(struct mmc_card *card)
> > > > >>>>>>>>>>         int err;
> > > > >>>>>>>>>>         u8 val;
> > > > >>>>>>>>>>
> > > > >>>>>>>>>> -       /* Reduce frequency to HS */
> > > > >>>>>>>>>> -       max_dtr = card->ext_csd.hs_max_dtr;
> > > > >>>>>>>>>> -       mmc_set_clock(host, max_dtr);
> > > > >>>>>>>>>> -
> > > > >>>>>>>>>
> > > > >>>>>>>>> As far as I can tell, the reason to why we change the clock frequency
> > > > >>>>>>>>> *before* the call to __mmc_switch() below, is probably to try to be on
> > > > >>>>>>>>> the safe side and conform to the spec.
> > > > >>>>>>>>>
> > > > >>>>>>>> Agree, it Must be more safe with lower clock frequency, but the
> > > > >>>>>>>> precondition is to make the host side recognize current timing is not
> > > > >>>>>>>> HS400 mode. it has no method to find a safe setting to ensure no
> > > > >>>>>>>> response CRC error when reduce clock from 200Mhz to 50Mhz.
> > > > >>>>>>>>> However, I think you have a point, as the call to __mmc_switch(),
> > > > >>>>>>>>> passes the "send_status" parameter as false, no other command than the
> > > > >>>>>>>>> CMD6 is sent to the card.
> > > > >>>>>>>>>
> > > > >>>>>>>> yes, the send status command was sent only after __mmc_switch() done.
> > > > >>>>>>>>>>         /* Switch HS400 to HS DDR */
> > > > >>>>>>>>>>         val = EXT_CSD_TIMING_HS;
> > > > >>>>>>>>>>         err = __mmc_switch(card, EXT_CSD_CMD_SET_NORMAL, EXT_CSD_HS_TIMING,
> > > > >>>>>>>>>> @@ -1253,6 +1249,10 @@ int mmc_hs400_to_hs200(struct mmc_card *card)
> > > > >>>>>>>>>>
> > > > >>>>>>>>>>         mmc_set_timing(host, MMC_TIMING_MMC_DDR52);
> > > > >>>>>>>>>>
> > > > >>>>>>>>>> +       /* Reduce frequency to HS */
> > > > >>>>>>>>>> +       max_dtr = card->ext_csd.hs_max_dtr;
> > > > >>>>>>>>>> +       mmc_set_clock(host, max_dtr);
> > > > >>>>>>>>>> +
> > > > >>>>>>>>>
> > > > >>>>>>>>> Perhaps it's even more correct to change the clock frequency before
> > > > >>>>>>>>> the call to mmc_set_timing(host, MMC_TIMING_MMC_DDR52). Otherwise you
> > > > >>>>>>>>> will be using the DDR52 timing in the controller, but with a too high
> > > > >>>>>>>>> frequency.
> > > > >>>>>>>>>
> > > > >>>>>>>> for Our host, it has no impact to change the clock before or after
> > > > >>>>>>>> change timing, as the mmc_set_timing() is only for host side, not
> > > > >>>>>>>> related to MMC card side and no commands sent do card before the
> > > > >>>>>>>> timing/clock change completed.
> > > > >>>>>>>
> > > > >>>>>>> Alright. After a second thought, it actually looks more consistent
> > > > >>>>>>> with mmc_select_hs400() to do it after, as what you propose in
> > > > >>>>>>> $subject patch.
> > > > >>>>>>>
> > > > >>>>>>> So, let's keep it as is.
> > > > >>>>>>>
> > > > >>>>>>>>>>         err = mmc_switch_status(card);
> > > > >>>>>>>>>>         if (err)
> > > > >>>>>>>>>>                 goto out_err;
> > > > >>>>>>>>>> --
> > > > >>>>>>>>>> 1.8.1.1.dirty
> > > > >>>>>>>>>>
> > > > >>>>>>>>>
> > > > >>>>>>>>> Finally, it sounds like you are trying to fix a real problem, can you
> > > > >>>>>>>>> please provide some more information what is happening when the
> > > > >>>>>>>>> problem occurs at your side?
> > > > >>>>>>>>>
> > > > >>>>>>>> Yes, I got a problem with new kernel version. with
> > > > >>>>>>>> commit:57da0c042f4af52614f4bd1a148155a299ae5cd8, this commit makes
> > > > >>>>>>>> re-tuning every time when access RPMB partition.
> > > > >>>>>>>
> > > > >>>>>>> Okay, could you please add this as fixes tag for the next version of the patch.
> > > > >>>>>>>
> > > > > Ok, sorry for late reply due to Chinese New Year.
> > > > >>>>>>>>
> > > > >>>>>>>> in fact, our host tuning result of hs400 is very stable and almost never
> > > > >>>>>>>> get response CRC error with clock frequency at 200Mhz. but cannot ensure
> > > > >>>>>>>> this tuning result also suitable when running at HS400 mode @50Mhz. as I
> > > > >>>>>>>> mentioned before, the host side does not know the reason of reduce clock
> > > > >>>>>>>> frequency to 50Mhz at HS400 mode, so what's the host side can do is only
> > > > >>>>>>>> reduce the bus clock to 50Mhz, even it can just only set the tuning
> > > > >>>>>>>> setting to default when clock frequency lower than 50Mhz, but both card
> > > > >>>>>>>> & host side are still at HS400 mode, still cannot ensure this setting is
> > > > >>>>>>>> suitable.
> > > > >>>>>>>
> > > > >>>>>>> Right, thanks for clarifying.
> > > > >>>>>>>
> > > > >>>>>>> So I am expecting a new version with a fixes tag and some
> > > > >>>>>>> clarification of the changelog, then I am ready to apply this to give
> > > > >>>>>>> it some test.
> > > > >>>>>>
> > > > >>>>>> The switch from HS400 mode is done for tuning at times when CRC errors are a
> > > > >>>>>> possibility e.g. after a CRC error during transfer.  So if the frequency is
> > > > >>>>>> not to be reduced, then some mitigation is needed for the possibility that
> > > > >>>>>> the CMD6 response itself will have a CRC error.
> > > > >>>>>
> > > > >>>>> That's a good point!
> > > > >>>>>
> > > > >>>>> However, how can we know that a CMD6 command is successfully
> > > > >>>>> completed, if there is CRC errors detected during the transmission? I
> > > > >>>>> guess we can't!?
> > > > >>>>
> > > > >>>> Yes, in that case, the only option is to assume the CMD6 was successful,
> > > > >>>> like in
> > > > >>>>
> > > > >>>>   commit ef3d232245ab7a1bf361c52449e612e4c8b7c5ab
> > > > >>>>   Author: Adrian Hunter <adrian.hunter@intel.com>
> > > > >>>>   Date:   Fri Dec 2 13:16:35 2016 +0200
> > > > >>>>
> > > > >>>>       mmc: mmc: Relax checking for switch errors after HS200 switch
> > > > >>>
> > > > >>> Well, relaxing the check for switch errors, is to me a different
> > > > >>> thing. This means we are first doing the CMD6, then allowing the
> > > > >>> following status command (CMD13) to have CRC errors. Actually, even
> > > > >>> the spec mention this as a case to consider. I guess it's because the
> > > > >>> card internally have switched to a new speed mode timing.
> > > > >>>
> > > > >>> Allowing CRC errors for the actual CMD6 sound more fragile to me. Of
> > > > >>> course, we can always try and see what happens.
> > > > >>>
> > > > >>> Chaotian, can you give it a go? Somehow, change the call to
> > > > >>> __mmc_switch() in mmc_hs400_to_hs200(), so the CMD6 doesn't have the
> > > > >>> CRC flag set.
> > @Adrian, @Ulf, another question: if remove the MMC_RSP_CRC flag, it will
> > have big impact to all host driver, as the "mmc_resp_type()" can not get
> > MMC_RESP_R1B return value, so many host drivers use mmc_resp_type() to
> > get resp type. if We make CMD6 does not have CRC flag set, then We must
> > modify the using of "mmc_resp_type()" to "mmc_resp_type() | MMC_RSP_CRC"
> > in all host drives. the same issue occurs at other place which remove
> > MMC_RSP_CRC(eg. mmc_cqe_recovery()).
> 
> The idea is actually to try to change this for all host drivers, of
> course it's only for this particular CMD6 in question, so not for all
> CMD6.
> 
Well, I mean, all commands(R1/R1B/R5/R6/R7) with MMC_RSP_CRC flag NOT
set will cause host driver cannot work properly, host driver cannot get
correct response type by mmc_resp_type() to padding its register.
if the MMC core layer supports "cmd.flags &= ~MMC_RSP_CRC", then must
modify all host driver to support it.

So, in this case, the easy way to check return value of this
__mmc_switch() may like blow:
	if (err && err != -EILSEQ)
> However, before we consider doing such a change, we need to know if it
> solves the problem for you? If it doesn't, then we can drop the idea.
> 
> As a perhaps better alternative, Adrian also suggested, if possible,
> to let the mediatek driver change to "fixed sampling mode" via the
> ->set_ios() host ops, at the point when the clk rate drops to
> HS-frequency, but still running with MMC_TIMING_MMC_HS400 timings. Of
> course this means "fixed sampling" needs to be supported by the
> mediatek IP.
> 
> If neither of this works for you, we need to consider something else.
> 
> [...]
> 
> Kind regards
> Uffe



_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
