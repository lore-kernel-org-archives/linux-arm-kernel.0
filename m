Return-Path: <SRS0=iy7m=RA=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5C89C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 16:09:04 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B06F120842
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 16:09:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="XNppYh/1";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="BCuDZc1I"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B06F120842
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=BFYOMzuSMCbvVGAMfGcfOzjjV/zTG3H9sMeSAgZIT6Y=; b=XNppYh/1RNqF01
	mrcNpHCfG3YdXVegmJ14gvoTV3wzeXy/OiIFQ0XbjcRhMbKwrIKwRRAmHJhEdu0dQMNlysvlRXd20
	ZCITRStdX/9axtjNLy3SSV+iMeoF2n2unhiydt32up/j+OJcZw4+Os4EaQU0vt+ssHMuLMXK3r36M
	IR/FYZoWJw6DFfOfOp7MNTNtZJEY4D3wTIqjNpBTv06l0bhUahfL50qvSsbzoewtpb8/cknCwDtrq
	4NsUUkMzeEEiYG48B9mm0Y4wF64Dc465Y7d1EH1zxiBA/kO2ug76Xqe6Pr/lg21MsnkMlMOCvF8gE
	hdPWKpKHZr+FNVpaGbOg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gyIoL-0001J0-0J; Mon, 25 Feb 2019 16:08:57 +0000
Received: from mail-ua1-x942.google.com ([2607:f8b0:4864:20::942])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gyIoH-0001Hi-7N
 for linux-arm-kernel@lists.infradead.org; Mon, 25 Feb 2019 16:08:55 +0000
Received: by mail-ua1-x942.google.com with SMTP id u1so8120646uae.12
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 25 Feb 2019 08:08:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=XU/r/zwkjtr/RRn8IMe8IxcCB42wnio9h2da5cXx2F0=;
 b=BCuDZc1I8jlLwdob6hihdZ9/mzNbiHx6tE9ePO/YQhcdKZBMptqMnFfuQHIdTBA/dK
 Sz5RAkKQ6JVttL5jKs2sXpsC46t14X/s5OritYw2w5zrizWaFvzAxMIDSzO2idbqeCBk
 Tz8eKbhzvi0OvalPBIJT+Z75yOzaZADf4tg6L9pvvSWSvginy8uHjvDy1EHIPjeNLKy7
 YT0du3Xfi+T3K0sFvgYSd81xQB1UdqaulxOFWRn84exap5EJjrhXUJjn5n8R4ZkFSRY+
 Rd1x6rw5zxAGw9EzKWnSLH5VgJhkqGGzodOVq/PWr1ZH008Y67/8oz7cTeeScEobkxJn
 QNyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=XU/r/zwkjtr/RRn8IMe8IxcCB42wnio9h2da5cXx2F0=;
 b=Ow1EURzAsYFahQL/ZYC/MRNxr9dGeoCqZ6kEBhxCzu/HSDxDxc8jBxhFbFp2GTHsX9
 KqIwdtHwkGDH6Vb/UxUI1+rCvnrfmll768tm+eaYFdeI0HtRtowS7dKDMK9JLiJSiEYV
 40OVsERxLS4UgpmRn3lgXdMluntRXFd7FFJ2Iyzu0J/9GDUmkxtW+SuLRML3ELITEFnS
 4U7nooZyAUDe3kV/tZpQN3WFzJKPL1PFFOY4d6JeG9U6V5tZuvg+a4Siv86Se+PVs9i6
 S/FulymWTyhtKwyJ8AfOv7a4iHVzbjVqknWmjCphN6fF5QsR+7xM4jLkyszi/OtYn4h/
 sOqA==
X-Gm-Message-State: AHQUAuY3I51zfsoxJe0yanOIreqMObMa4t02G/Ti3sH8ESmCTJP2/HN0
 cDKZKAOhvxLk7L9ezNS243VVZXI++ELUCyNzOBSeRA==
X-Google-Smtp-Source: AHgI3IZxinq8v01ArpVsWD6oL5Yo/p4NZDXG9ouiGftD1xFUdDWGdXCLun9xQRAS56RvrMLwILQ0x38WMIpiP/+WvD8=
X-Received: by 2002:a67:8055:: with SMTP id b82mr7902148vsd.200.1551110930624; 
 Mon, 25 Feb 2019 08:08:50 -0800 (PST)
MIME-Version: 1.0
References: <1550210375-32270-1-git-send-email-chaotian.jing@mediatek.com>
 <1550210375-32270-3-git-send-email-chaotian.jing@mediatek.com>
In-Reply-To: <1550210375-32270-3-git-send-email-chaotian.jing@mediatek.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Mon, 25 Feb 2019 17:08:14 +0100
Message-ID: <CAPDyKFquyyXx1MqNLVXuFxcEDB9nKzN8LGGNUP2yxoVMQrWiUg@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] mmc: mmc: Fix HS setting in mmc_hs400_to_hs200()
To: Chaotian Jing <chaotian.jing@mediatek.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190225_080853_294376_379F8D9E 
X-CRM114-Status: GOOD (  28.81  )
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
 Avri Altman <avri.altman@wdc.com>, linux-mediatek@lists.infradead.org,
 Hongjie Fang <hongjiefang@asrmicro.com>,
 Matthias Brugger <matthias.bgg@gmail.com>,
 Simon Horman <horms+renesas@verge.net.au>,
 Kyle Roeschley <kyle.roeschley@ni.com>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Fri, 15 Feb 2019 at 06:59, Chaotian Jing <chaotian.jing@mediatek.com> wrote:
>
> mmc_hs400_to_hs200() begins with the card and host in HS400 mode.
> before send CMD6 to switch card's timing to HS mode, it reduce clock
> frequency to 50Mhz firstly, the original intention of reduce clock
> is to make "more stable" when doing HS switch. however,reduce clock
> frequency to 50Mhz but without host timming change may cause CMD6
> response CRC error. because host is still running at hs400 mode,
> and it's hard to find a suitable setting for all eMMC cards when
> clock frequency reduced to 50Mhz but card & host still in hs400 mode.
>
> so that We consider that CMD6 response CRC error is not a fatal error,
> if host gets CMD6 response CRC error, it means that card has already
> received this command.
>
> Signed-off-by: Chaotian Jing <chaotian.jing@mediatek.com>
> Fixes: ef3d232245ab ("mmc: mmc: Relax checking for switch errors after HS200 switch")
> ---
>  drivers/mmc/core/mmc.c | 21 +++++++++++++++++++--
>  1 file changed, 19 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
> index 09c688f..03d1c17 100644
> --- a/drivers/mmc/core/mmc.c
> +++ b/drivers/mmc/core/mmc.c
> @@ -1248,8 +1248,25 @@ int mmc_hs400_to_hs200(struct mmc_card *card)
>         err = __mmc_switch(card, EXT_CSD_CMD_SET_NORMAL, EXT_CSD_HS_TIMING,
>                            val, card->ext_csd.generic_cmd6_time, 0,
>                            true, false, true);
> -       if (err)
> -               goto out_err;
> +       /*
> +        * as we are on the way to do re-tune, so if the CMD6 got response CRC
> +        * error, do not treat it as error.
> +        */
> +       if (err) {
> +               if (err == -EILSEQ) {

Well, I am having seconds thoughts about this. Sorry.

There are different scenarios of why we end up doing a re-tune and
thus call mmc_hs400_to_hs200(). These are:

1) Because of a periodic re-tuning - to avoid CRC errors in the future.
2) Because the host controller needs to do a re-tune when it gets
runtime resumed, due to that it lost its tuning data (and is unable to
restore it).
3) Because we encountered a CRC (-EILSEQ) error for a block I/O
request and want to try re-cover.

I assume you are looking at case 3), because mtk-sd don't use periodic
re-tuning and nor does it need re-tune at runtime resume, right?

So, when thinking a bit about these cases, more closely, I think we
need to admit that these are actually quite fundamentally different
cases. Therefore, we should probably start treat them like that as
well.

For 1), There are no reason to decrease the clock rate before invoking
__mmc_switch(), but rather we should decrease it afterwards instead.
For 2), The clock rate must to be decreased to HS speed (50 MHz),
before invoking __mmc_switch(), as there are really no tuning
parameters available at all to use for the controller.
For 3). Similar to 1) and for the reasons you also have brought up
earlier, the clock rate should remain at HS400 speed before invoking
__mmc_switch(). This is because the controller are still using the
tuned data for the HS400 clock rate. So, even if the conditions
started to become fragile, I think it's better to try with the HS400
MHz than on any other rate.

Moreover, as I stated in an earlier reply, if the call to
__mmc_switch() ends up with a CRC error, how can we ever be sure that
the command was accepted by the card? We can't, hence that solution
will probably never fly.

> +                       /*
> +                        * card will busy after sending out response and host
> +                        * driver may not wait busy de-assert when get
> +                        * response CRC error. so just wait enough time to
> +                        * ensure card leave busy state.
> +                        */
> +                       mmc_delay(card->ext_csd.generic_cmd6_time);
> +                       pr_debug("%s: %s switch to HS got CRC error\n",
> +                                mmc_hostname(host), __func__);
> +               } else {
> +                       goto out_err;
> +               }
> +       }
>
>         mmc_set_timing(host, MMC_TIMING_MMC_DDR52);
>
> --
> 1.8.1.1.dirty
>

If you take into account my comments above, it seems like we need to
add a new tuning flag somewhere, to tell the reason for why the tuning
is needed. Then we can let mmc_hs400_to_hs200() act on that flag, and
depending on its value it can either change the clock rate before or
after the call to __mmc_switch(). If we can make this work, that would
be the best solution, I think.

The fallback method, is to add a specific host cap bit, that instructs
the mmc core to adjust clock rate before/after the switch, but I would
rather avoid this solution, but perhaps there is no other way. Let's
see.

Kind regards
Uffe

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
