Return-Path: <SRS0=JyYb=QI=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BBAAC282D9
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 01:38:46 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6F2CC20869
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 01:38:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="OeDmxahP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6F2CC20869
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Date:To:From:Subject:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=SF2OtYiB2M5sOOjmHRcYe3xNuPVmWoHQJXoXPZcj05A=; b=OeDmxahPtyki8c
	114VrQe2HlYTswBiwLO6XHBelAqiWwjkAAKi8RvHqa5UEaieKnbuPBqg24V1I7blCkeGHVKUmU22q
	ZpKnMHfU50f4+JYYXuPz/supJoPunei83+bWOUsYeWRWPLzu+6xONqLQ+E+mNYFtqpmnB/ORnwOAN
	qBxEOmh/KZNQOdrwKmpxqhANoM+i2cyDGj0D6cnw7C3DT36MWbnXUosWpsUFX7RwBpRCUANFJHpdJ
	2H4P/QKYr5z/1Z8YLQG7E+5BHIzitrAz8ieJMAch/EVRTD9RFimTiHOvJ+F2Gk8vhdX3db7eNnff7
	uiC5MilsaifGJPT+2rnQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gpNn0-0003y0-7e; Fri, 01 Feb 2019 01:38:42 +0000
Received: from mailgw01.mediatek.com ([216.200.240.184])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gpNmw-0003xE-Co; Fri, 01 Feb 2019 01:38:39 +0000
X-UUID: ddd3245a37564a438199facafc933c8e-20190131
X-UUID: ddd3245a37564a438199facafc933c8e-20190131
Received: from mtkcas68.mediatek.inc [(172.29.94.19)] by mailgw01.mediatek.com
 (envelope-from <chaotian.jing@mediatek.com>)
 (musrelay.mediatek.com ESMTP with TLS)
 with ESMTP id 1670104885; Thu, 31 Jan 2019 17:38:17 -0800
Received: from mtkmbs03n2.mediatek.inc (172.21.101.182) by
 MTKMBS62DR.mediatek.inc (172.29.94.18) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Thu, 31 Jan 2019 17:38:15 -0800
Received: from MTKCAS32.mediatek.inc (172.27.4.184) by mtkmbs03n2.mediatek.inc
 (172.21.101.182) with Microsoft SMTP Server (TLS) id 15.0.1395.4;
 Fri, 1 Feb 2019 09:38:13 +0800
Received: from [10.17.3.153] (10.17.3.153) by MTKCAS32.mediatek.inc
 (172.27.4.170) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Fri, 1 Feb 2019 09:38:12 +0800
Message-ID: <1548985091.10251.26.camel@mhfsdcap03>
Subject: Re: [PATCH] mmc: mmc: Fix HS setting in mmc_hs400_to_hs200()
From: Chaotian Jing <chaotian.jing@mediatek.com>
To: Ulf Hansson <ulf.hansson@linaro.org>
Date: Fri, 1 Feb 2019 09:38:11 +0800
In-Reply-To: <CAPDyKFruCCs_un1oR-gd1P=ZGryyHwKuY0SkvLO2=Jm1bGV6sQ@mail.gmail.com>
References: <1548921212-5219-1-git-send-email-chaotian.jing@mediatek.com>
 <CAPDyKFruCCs_un1oR-gd1P=ZGryyHwKuY0SkvLO2=Jm1bGV6sQ@mail.gmail.com>
X-Mailer: Evolution 3.2.3-0ubuntu6 
MIME-Version: 1.0
X-TM-SNTS-SMTP: B537CDA27EF59E3B1B84E492B269AE1FB2207C44900CE4F37535641C42AF7ECF2000:8
X-MTK: N
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190131_173838_438891_EBBD1311 
X-CRM114-Status: GOOD (  30.08  )
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
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 linux-mediatek@lists.infradead.org,
 Harish Jenny K N <harish_kandiga@mentor.com>,
 Hongjie Fang <hongjiefang@asrmicro.com>,
 Matthias Brugger <matthias.bgg@gmail.com>,
 Simon Horman <horms+renesas@verge.net.au>, Kyle
 Roeschley <kyle.roeschley@ni.com>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Thu, 2019-01-31 at 16:58 +0100, Ulf Hansson wrote:
> On Thu, 31 Jan 2019 at 08:53, Chaotian Jing <chaotian.jing@mediatek.com> wrote:
> >
> > mmc_hs400_to_hs200() begins with the card and host in HS400 mode.
> > Therefore, any commands sent to the card should use HS400 timing.
> > It is incorrect to reduce frequency to 50Mhz before sending the switch
> > command, in this case, only reduce clock frequency to 50Mhz but without
> > host timming change, host is still in hs400 mode but clock changed from
> > 200Mhz to 50Mhz, which makes the tuning result unsuitable and cause
> > the switch command gets response CRC error.
> 
> According the eMMC spec there is no violation by decreasing the clock
> frequency like this. We can use whatever value <=200MHz.
> 
> However, perhaps in practice this becomes an issue, due to the tuning
> for HS400 has been done on the "current" frequency.
> 
> As as start, I think you need to clarify this in the changelog.
> 
Yes, reduce clock frequency to 50Mhz is no Spec violation, but it may
cause __mmc_switch() gets response CRC error, decreasing the clock but
without HOST mode change, on the host side, host driver do not know
what's operation the core layer want to do and can only set current bus
clock to 50Mhz, without tuning parameter change, it has a chance lead to
response CRC error. even lower clock frequency, but with the wrong
tuning parameter setting(the setting is of hs400 tuning @200Mhz).
> >
> > this patch refers to mmc_select_hs400(), make the reduce clock frequency
> > after card timing change.
> >
> > Signed-off-by: Chaotian Jing <chaotian.jing@mediatek.com>
> > ---
> >  drivers/mmc/core/mmc.c | 8 ++++----
> >  1 file changed, 4 insertions(+), 4 deletions(-)
> >
> > diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
> > index da892a5..21b811e 100644
> > --- a/drivers/mmc/core/mmc.c
> > +++ b/drivers/mmc/core/mmc.c
> > @@ -1239,10 +1239,6 @@ int mmc_hs400_to_hs200(struct mmc_card *card)
> >         int err;
> >         u8 val;
> >
> > -       /* Reduce frequency to HS */
> > -       max_dtr = card->ext_csd.hs_max_dtr;
> > -       mmc_set_clock(host, max_dtr);
> > -
> 
> As far as I can tell, the reason to why we change the clock frequency
> *before* the call to __mmc_switch() below, is probably to try to be on
> the safe side and conform to the spec.
> 
Agree, it Must be more safe with lower clock frequency, but the
precondition is to make the host side recognize current timing is not
HS400 mode. it has no method to find a safe setting to ensure no
response CRC error when reduce clock from 200Mhz to 50Mhz.
> However, I think you have a point, as the call to __mmc_switch(),
> passes the "send_status" parameter as false, no other command than the
> CMD6 is sent to the card.
> 
yes, the send status command was sent only after __mmc_switch() done.
> >         /* Switch HS400 to HS DDR */
> >         val = EXT_CSD_TIMING_HS;
> >         err = __mmc_switch(card, EXT_CSD_CMD_SET_NORMAL, EXT_CSD_HS_TIMING,
> > @@ -1253,6 +1249,10 @@ int mmc_hs400_to_hs200(struct mmc_card *card)
> >
> >         mmc_set_timing(host, MMC_TIMING_MMC_DDR52);
> >
> > +       /* Reduce frequency to HS */
> > +       max_dtr = card->ext_csd.hs_max_dtr;
> > +       mmc_set_clock(host, max_dtr);
> > +
> 
> Perhaps it's even more correct to change the clock frequency before
> the call to mmc_set_timing(host, MMC_TIMING_MMC_DDR52). Otherwise you
> will be using the DDR52 timing in the controller, but with a too high
> frequency.
> 
for Our host, it has no impact to change the clock before or after
change timing, as the mmc_set_timing() is only for host side, not
related to MMC card side and no commands sent do card before the
timing/clock change completed.
> >         err = mmc_switch_status(card);
> >         if (err)
> >                 goto out_err;
> > --
> > 1.8.1.1.dirty
> >
> 
> Finally, it sounds like you are trying to fix a real problem, can you
> please provide some more information what is happening when the
> problem occurs at your side?
> 
Yes, I got a problem with new kernel version. with
commit:57da0c042f4af52614f4bd1a148155a299ae5cd8, this commit makes
re-tuning every time when access RPMB partition.

in fact, our host tuning result of hs400 is very stable and almost never
get response CRC error with clock frequency at 200Mhz. but cannot ensure
this tuning result also suitable when running at HS400 mode @50Mhz. as I
mentioned before, the host side does not know the reason of reduce clock
frequency to 50Mhz at HS400 mode, so what's the host side can do is only
reduce the bus clock to 50Mhz, even it can just only set the tuning
setting to default when clock frequency lower than 50Mhz, but both card
& host side are still at HS400 mode, still cannot ensure this setting is
suitable.

> Kind regards
> Uffe



_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
