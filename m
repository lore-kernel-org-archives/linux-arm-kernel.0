Return-Path: <SRS0=niBm=QV=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C32A1C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 08:41:14 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 95A482229F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 08:41:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="dXnxVAB+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 95A482229F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Date:To:From:Subject:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=72sFoNzKp06LANr5Rs2TwTcDtOgKUnIwESS83rU8OFU=; b=dXnxVAB+7J0zSu
	To02q/quvD+mUjvO5923eR0e4Bw1tpKIKFNlV6KPCoLUYMX8c1wZRY15VDFvHUVHERGQuKL27/aYo
	mLzTYtGJfXleXg7c2ifEDlmiWVj2yIyzVAgl0UszGcezbcq79Uk8PrtzkywS5b793hzV3khoczDE6
	cOwR2nr7Dn6Ctj8s1k0oxuGJTsmtfMP4igSpUkLQZ7QJlvM01mSEBwS9XLOjHNiX6SThOgQW5sGCz
	6ThveGbECeawPtjHhq/B+C6UCixjaz97GOCH/fnHm8BvMg800EoDatshIJOBqEgjndCZMZqJbx7cB
	HgTZBZgHSXFBpbAivWgw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1guCZu-0007O1-5S; Thu, 14 Feb 2019 08:41:06 +0000
Received: from mailgw01.mediatek.com ([216.200.240.184])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1guCZZ-00077e-8R; Thu, 14 Feb 2019 08:40:47 +0000
X-UUID: 8a6226537bb7411495f042d7d2b8a14b-20190214
X-UUID: 8a6226537bb7411495f042d7d2b8a14b-20190214
Received: from mtkcas66.mediatek.inc [(172.29.193.44)] by mailgw01.mediatek.com
 (envelope-from <chaotian.jing@mediatek.com>)
 (musrelay.mediatek.com ESMTP with TLS)
 with ESMTP id 1299376447; Thu, 14 Feb 2019 00:40:33 -0800
Received: from mtkmbs03n1.mediatek.inc (172.21.101.181) by
 MTKMBS62N2.mediatek.inc (172.29.193.42) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Thu, 14 Feb 2019 00:40:32 -0800
Received: from MTKCAS32.mediatek.inc (172.27.4.184) by mtkmbs03n1.mediatek.inc
 (172.21.101.181) with Microsoft SMTP Server (TLS) id 15.0.1395.4;
 Thu, 14 Feb 2019 16:40:29 +0800
Received: from [10.17.3.153] (10.17.3.153) by MTKCAS32.mediatek.inc
 (172.27.4.170) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Thu, 14 Feb 2019 16:40:28 +0800
Message-ID: <1550133628.16070.32.camel@mhfsdcap03>
Subject: Re: [PATCH v1] mmc: mmc: Fix HS setting in mmc_hs400_to_hs200()
From: Chaotian Jing <chaotian.jing@mediatek.com>
To: Ulf Hansson <ulf.hansson@linaro.org>
Date: Thu, 14 Feb 2019 16:40:28 +0800
In-Reply-To: <CAPDyKFqncdVs-jB4_46ZhgZP3TGCaUWnOCoNmjfT-kAESY3csw@mail.gmail.com>
References: <1550048812-29068-1-git-send-email-chaotian.jing@mediatek.com>
 <CAPDyKFpNEhXT0dD_p85Ab2H_nHtr5r86BLcvkLVUsdwtYLUs4g@mail.gmail.com>
 <1550110458.16070.30.camel@mhfsdcap03>
 <CAPDyKFqncdVs-jB4_46ZhgZP3TGCaUWnOCoNmjfT-kAESY3csw@mail.gmail.com>
X-Mailer: Evolution 3.2.3-0ubuntu6 
MIME-Version: 1.0
X-MTK: N
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190214_004045_467099_2D258EFB 
X-CRM114-Status: GOOD (  32.87  )
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
 Adrian Hunter <adrian.hunter@intel.com>, linux-mediatek@lists.infradead.org,
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

On Thu, 2019-02-14 at 09:14 +0100, Ulf Hansson wrote:
> On Thu, 14 Feb 2019 at 03:14, Chaotian Jing <chaotian.jing@mediatek.com> wrote:
> >
> > On Wed, 2019-02-13 at 13:08 +0100, Ulf Hansson wrote:
> > > On Wed, 13 Feb 2019 at 10:07, Chaotian Jing <chaotian.jing@mediatek.com> wrote:
> > > >
> > > > mmc_hs400_to_hs200() begins with the card and host in HS400 mode.
> > > > Therefore, any commands sent to the card should use HS400 timing.
> > > > reduce clock frequency to 50Mhz but without host timming change
> > > > may cause CMD6 response CRC error. because host still running at
> > > > hs400 mode, and it's hard to find a suitable setting for all eMMC
> > > > cards when clock frequency reduced to 50Mhz but card & host still
> > > > in hs400 mode.
> > > > this patch refers to mmc_select_hs400(), make the reduce clock frequency
> > > > after card timing change.
> > > >
> > > > Signed-off-by: Chaotian Jing <chaotian.jing@mediatek.com>
> > > > Fixes: ef3d232245ab ("mmc: mmc: Relax checking for switch errors after HS200 switch")
> > > > ---
> > > >  drivers/mmc/core/mmc.c | 29 +++++++++++++++++++++++------
> > > >  1 file changed, 23 insertions(+), 6 deletions(-)
> > > >
> > > > diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
> > > > index 09c688f..00adc2d 100644
> > > > --- a/drivers/mmc/core/mmc.c
> > > > +++ b/drivers/mmc/core/mmc.c
> > > > @@ -1239,20 +1239,37 @@ int mmc_hs400_to_hs200(struct mmc_card *card)
> > > >         int err;
> > > >         u8 val;
> > > >
> > > > -       /* Reduce frequency to HS */
> > > > -       max_dtr = card->ext_csd.hs_max_dtr;
> > > > -       mmc_set_clock(host, max_dtr);
> > > > -
> > > >         /* Switch HS400 to HS DDR */
> > > >         val = EXT_CSD_TIMING_HS;
> > > >         err = __mmc_switch(card, EXT_CSD_CMD_SET_NORMAL, EXT_CSD_HS_TIMING,
> > > >                            val, card->ext_csd.generic_cmd6_time, 0,
> > > >                            true, false, true);
> > > > -       if (err)
> > > > -               goto out_err;
> > > > +       /*
> > > > +        * as we are on the way to do re-tune, so if the CMD6 got response CRC
> > > > +        * error, do not treat it as error.
> > > > +        */
> > > > +       if (err) {
> > > > +               if (err == -EILSEQ) {
> > > > +                       /*
> > > > +                        * card will busy after sending out response and host
> > > > +                        * driver may not wait busy de-assert when get
> > > > +                        * response CRC error. so just wait enough time to
> > > > +                        * ensure card leave busy state.
> > > > +                        */
> > > > +                       mmc_delay(card->ext_csd.generic_cmd6_time);
> > > > +                       pr_debug("%s: %s switch to HS got CRC error\n",
> > > > +                                mmc_hostname(host), __func__);
> > > > +               } else {
> > > > +                       goto out_err;
> > > > +               }
> > > > +       }
> > > >
> > > >         mmc_set_timing(host, MMC_TIMING_MMC_DDR52);
> > > >
> > > > +       /* Reduce frequency to HS */
> > > > +       max_dtr = card->ext_csd.hs_max_dtr;
> > > > +       mmc_set_clock(host, max_dtr);
> > > > +
> > >
> > > What Adrian suggested was to not to move this part, but instead, only
> > > allow CRC errors from the CMD6 as above.
> > >
> > > I guess it didn't work for you?
> > >
> > It should work for me. another issue is CMD6 will be sent 3 times at max
> 
> Alright, let's give it a try then.
> 
> >  err = mmc_wait_for_cmd(host, &cmd, MMC_CMD_RETRIES);
> 
> Yeah, that one have I thought about earlier as well.
> 
> >
> > if the first CMD6 got response CRC error, then Host driver must wait
> > busy signal de-assert before send the next CMD6.
> >
> > So that it really make sense to issue CMD6(R1B) for 3 times ? if host
> > driver did not handle the first CMD6 response CRC error and send second
> > CMD6 directly, then this CMD6 will get timeout due to card still in busy
> > state.
> 
> I fully agree with you, I don't think it makes sense to retry - not
> even for any CMD6, because of the busy signalling the card may raise
> afterwards.
> 
> Perhaps we should start with a simple oneliner patch, giving zero
> instead of MMC_CMD_RETRIES to mmc_wait_for_cmd() and see how that
> plays.
> 
> Then on top we can add the special error handling of the CRC errors,
> along the lines of what you suggest.
> 
> Does it make sense?
> 
Sure, I will upload a new patch to change the retry time from 3 to 0
along with this patch.
> [...]
> 
> Kind regards
> Uffe



_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
