Return-Path: <SRS0=niBm=QV=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67220C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 08:15:31 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 365622229F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 08:15:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="qsYmuXiT";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xBBa4RXz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 365622229F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=N5DZ9xi+oJ4p7mDWKXfuSdjWhhitNZdzI69jOz/JHK8=; b=qsYmuXiTxvuJBO
	8KVrf7y14g7jdZ8IKOI1dxtH5j6boODw8/sAmnP4wx69u9nhJxo7Op0CU9KgH8X2c4xpKYqJAfa6k
	1OKQMngRx6nINMA7y3uWZjcgaijuFT0Z+bKuLoasXMLM6qdvhAOQJgzhY6Lc1OAb62Xy5Ap6L2+Mv
	mLoMf+c02DbB8pY1Do8PSi32GEbKTTk87V+geSZ7cpZgJlfAZ5Xun9YWMGUTzDVCxBQiTwNC3D+qj
	Je+nUL6ry9k9+jEPk3dPlvyEqx+mIq2ShKZOpmGm13o2wxuqRaz4Sfa0nZ0T5xzCW6lji7XLyXOq6
	/dqSh0YD2qs9HugEvjAw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1guCAz-0004QJ-NY; Thu, 14 Feb 2019 08:15:21 +0000
Received: from mail-vs1-xe43.google.com ([2607:f8b0:4864:20::e43])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1guCAv-0004PG-Dn
 for linux-arm-kernel@lists.infradead.org; Thu, 14 Feb 2019 08:15:19 +0000
Received: by mail-vs1-xe43.google.com with SMTP id n10so3095915vso.13
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 14 Feb 2019 00:15:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=Q1vSlE9Et3cfPY2F1A8sGnwrhCQsNEoL0FUxEug8lZc=;
 b=xBBa4RXz1IjzdL6Lt4V26sxhE7+GX/cw0HWxWUzg2kgnlpVjgh+xAr7uWx4CLoeQ/3
 5mYnSHXELr3tAZ26gQsVJnMg9651fkcMU/yCKYUIlk013OlDP8tXaHc+EkMA9viA7YfD
 6p+fscpw5PI7bsP1fdiH7SzSDXFdbiSjEmqg1HASKmCup7vWPBizYvaRIpW13bbpo86b
 WDowb8IV51W4bnn4Hq+AiEAMswOXGiR+6VIPcTHuDWpeR2uqYvERYkNiTH5XlW+lek9N
 GfjaDa2jeUZwKfbxg1LAXvw+0n1qUqdXcijXTS6Lz6pnVEsuckPlqr58iaiWx2Y4Gq1s
 6+OQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=Q1vSlE9Et3cfPY2F1A8sGnwrhCQsNEoL0FUxEug8lZc=;
 b=XPxAqqT8xhisOilluPDiu+YqZLIoOinXQT6qRdCBe8+KwujzrWilMZ+85XsdYafxlf
 fBXCM8xUyIR9rtOO3I2+2n2Zdg215sQgt+v0FyM4NS1q7TWbo1jlXNxyl9ivAmpoLeGW
 btuQm+X/3PRknvOruuVTHztGdDhbkqhvj+0vGxHcwufjaCO17GFGk6Gca8GXoM77p0tl
 6m/d7m/e6Za4bDrixbrDyB5HSfKCEnxw2u/PcLcTgXeK9U+abt9JarNF6vcuS0Uwk8IS
 7+iw3nuPVP9fpYm3agYTgYXMxvajI9miXoa5buUqbISSNCxXZLX1DL9SQZts6Ug8ZCaB
 GHJw==
X-Gm-Message-State: AHQUAubl6e01VTJsm/BN715x9lgbK95SwDnyMKa4ZcWqJOdxMfCxSsp1
 3kTv2RPTsDTZ51pVoLPINcxCEnA0Jqd6eZtTps2Q/A==
X-Google-Smtp-Source: AHgI3IZb1SyyZLg12u8rwtuZhCGYI/OQRskQQFBwn36j/LE7FglemYXyDqS16sJgwfH3fDSLVJ+13kvXM558cDuNMyU=
X-Received: by 2002:a67:b003:: with SMTP id z3mr1479418vse.200.1550132115847; 
 Thu, 14 Feb 2019 00:15:15 -0800 (PST)
MIME-Version: 1.0
References: <1550048812-29068-1-git-send-email-chaotian.jing@mediatek.com>
 <CAPDyKFpNEhXT0dD_p85Ab2H_nHtr5r86BLcvkLVUsdwtYLUs4g@mail.gmail.com>
 <1550110458.16070.30.camel@mhfsdcap03>
In-Reply-To: <1550110458.16070.30.camel@mhfsdcap03>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Thu, 14 Feb 2019 09:14:39 +0100
Message-ID: <CAPDyKFqncdVs-jB4_46ZhgZP3TGCaUWnOCoNmjfT-kAESY3csw@mail.gmail.com>
Subject: Re: [PATCH v1] mmc: mmc: Fix HS setting in mmc_hs400_to_hs200()
To: Chaotian Jing <chaotian.jing@mediatek.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190214_001517_482970_5BBD3E6B 
X-CRM114-Status: GOOD (  29.76  )
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
 Simon Horman <horms+renesas@verge.net.au>,
 Kyle Roeschley <kyle.roeschley@ni.com>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Thu, 14 Feb 2019 at 03:14, Chaotian Jing <chaotian.jing@mediatek.com> wrote:
>
> On Wed, 2019-02-13 at 13:08 +0100, Ulf Hansson wrote:
> > On Wed, 13 Feb 2019 at 10:07, Chaotian Jing <chaotian.jing@mediatek.com> wrote:
> > >
> > > mmc_hs400_to_hs200() begins with the card and host in HS400 mode.
> > > Therefore, any commands sent to the card should use HS400 timing.
> > > reduce clock frequency to 50Mhz but without host timming change
> > > may cause CMD6 response CRC error. because host still running at
> > > hs400 mode, and it's hard to find a suitable setting for all eMMC
> > > cards when clock frequency reduced to 50Mhz but card & host still
> > > in hs400 mode.
> > > this patch refers to mmc_select_hs400(), make the reduce clock frequency
> > > after card timing change.
> > >
> > > Signed-off-by: Chaotian Jing <chaotian.jing@mediatek.com>
> > > Fixes: ef3d232245ab ("mmc: mmc: Relax checking for switch errors after HS200 switch")
> > > ---
> > >  drivers/mmc/core/mmc.c | 29 +++++++++++++++++++++++------
> > >  1 file changed, 23 insertions(+), 6 deletions(-)
> > >
> > > diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
> > > index 09c688f..00adc2d 100644
> > > --- a/drivers/mmc/core/mmc.c
> > > +++ b/drivers/mmc/core/mmc.c
> > > @@ -1239,20 +1239,37 @@ int mmc_hs400_to_hs200(struct mmc_card *card)
> > >         int err;
> > >         u8 val;
> > >
> > > -       /* Reduce frequency to HS */
> > > -       max_dtr = card->ext_csd.hs_max_dtr;
> > > -       mmc_set_clock(host, max_dtr);
> > > -
> > >         /* Switch HS400 to HS DDR */
> > >         val = EXT_CSD_TIMING_HS;
> > >         err = __mmc_switch(card, EXT_CSD_CMD_SET_NORMAL, EXT_CSD_HS_TIMING,
> > >                            val, card->ext_csd.generic_cmd6_time, 0,
> > >                            true, false, true);
> > > -       if (err)
> > > -               goto out_err;
> > > +       /*
> > > +        * as we are on the way to do re-tune, so if the CMD6 got response CRC
> > > +        * error, do not treat it as error.
> > > +        */
> > > +       if (err) {
> > > +               if (err == -EILSEQ) {
> > > +                       /*
> > > +                        * card will busy after sending out response and host
> > > +                        * driver may not wait busy de-assert when get
> > > +                        * response CRC error. so just wait enough time to
> > > +                        * ensure card leave busy state.
> > > +                        */
> > > +                       mmc_delay(card->ext_csd.generic_cmd6_time);
> > > +                       pr_debug("%s: %s switch to HS got CRC error\n",
> > > +                                mmc_hostname(host), __func__);
> > > +               } else {
> > > +                       goto out_err;
> > > +               }
> > > +       }
> > >
> > >         mmc_set_timing(host, MMC_TIMING_MMC_DDR52);
> > >
> > > +       /* Reduce frequency to HS */
> > > +       max_dtr = card->ext_csd.hs_max_dtr;
> > > +       mmc_set_clock(host, max_dtr);
> > > +
> >
> > What Adrian suggested was to not to move this part, but instead, only
> > allow CRC errors from the CMD6 as above.
> >
> > I guess it didn't work for you?
> >
> It should work for me. another issue is CMD6 will be sent 3 times at max

Alright, let's give it a try then.

>  err = mmc_wait_for_cmd(host, &cmd, MMC_CMD_RETRIES);

Yeah, that one have I thought about earlier as well.

>
> if the first CMD6 got response CRC error, then Host driver must wait
> busy signal de-assert before send the next CMD6.
>
> So that it really make sense to issue CMD6(R1B) for 3 times ? if host
> driver did not handle the first CMD6 response CRC error and send second
> CMD6 directly, then this CMD6 will get timeout due to card still in busy
> state.

I fully agree with you, I don't think it makes sense to retry - not
even for any CMD6, because of the busy signalling the card may raise
afterwards.

Perhaps we should start with a simple oneliner patch, giving zero
instead of MMC_CMD_RETRIES to mmc_wait_for_cmd() and see how that
plays.

Then on top we can add the special error handling of the CRC errors,
along the lines of what you suggest.

Does it make sense?

[...]

Kind regards
Uffe

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
