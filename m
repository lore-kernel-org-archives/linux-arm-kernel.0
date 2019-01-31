Return-Path: <SRS0=sKCI=QH=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C1ADC169C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 15:58:49 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6CB33218AC
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 15:58:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="jSc8md1c";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="cgW51nDD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6CB33218AC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=JQG88bHIM1e+6ColwHmsb+iBvhwvQbvl1G00Y4XWxTU=; b=jSc8md1clqDvB6
	BdxC4ilXoO758bTQGcH3qtu2KXerfnuJJJTB54HjNlnPqTpn7/Pe2/bLSs5m5ztpj1Ob31S9QRqRb
	/baU7QfvRiEy35gg4EKG3prTxrDiB4PbI2/254zzaPSvQwHnublGMhPGLHL7Rl87ozTHUDw4WxD5+
	2v10QUCdeEa1rgZhVw1NQEJ8vZRcxy9Ms5h9bU0JwqM3N2c87s2pw3fWHMZMVwhg6gU02KvIe0vdP
	OURs2pmjIisf4uValaZditwbMFviCuuY/dvPgEF1X1MMSYwmcqHy4Q6J29FnUj1caFV5ZweBZslqH
	OUL+o7CCzO3eUWAWH/Uw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gpEjn-00024q-JI; Thu, 31 Jan 2019 15:58:47 +0000
Received: from mail-vs1-xe43.google.com ([2607:f8b0:4864:20::e43])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gpEjj-00023y-O9
 for linux-arm-kernel@lists.infradead.org; Thu, 31 Jan 2019 15:58:45 +0000
Received: by mail-vs1-xe43.google.com with SMTP id x1so2231195vsc.10
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 31 Jan 2019 07:58:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=nH5mNWtP0x8UXx0oXeOP2TvPQWq72kKSDM0AQ5R9WoI=;
 b=cgW51nDDcvuE3NyqlCfSqKlnKnW9lujHHDCIhEqlQIC2Aul5RbAzOIiTw908gytMZB
 V1g036lzhSCjtibG0HpH3e/7KgxRTdjqwoL8ZUJoIZHkl/Rp1A1sehHn0XeadudESJZW
 qk3H1YHBUXRMBVcg0rACrkyag28hBBSEFCR9E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=nH5mNWtP0x8UXx0oXeOP2TvPQWq72kKSDM0AQ5R9WoI=;
 b=tqqw7xyZfZ3lJ+oCGYPuje9aSHiUxzcZYsg9E6iuLqLQuz6Z11v8q2P8oLsiGAR0P4
 25ugUjy4Aiy8phrJNJofsbOXxI5ejcV99udv2X35ltWa5VhvknqA01q3IjN/Yx+Y09e3
 GT6ExRUfEHBLDv47e8h7DxaxtsYR+Hdm5hezzgGWbSH+GqXYpLPnXCTXJfw1E2TQHDhm
 76HWERn6zIjDLrSVcDZPoAWLjveXL+fUdhEs2+taCGCQbtQWui767Nie5HBVMQjUBgsY
 HmfLaZ/9+MFtEl/jOniRh4kGKOmidMJvDhtenoSWBJtaPN1ynNJPU2j0KWQIeGfA62vu
 Vycw==
X-Gm-Message-State: AJcUukcsdfeZvvBvolj9cjWj6Qjc4T1DzuvWmS4JWgtINHvV4PgScMbL
 zim3kMmsa74cj+8HuWz9hRKJSBmlY2CGpkd0XLcfmw==
X-Google-Smtp-Source: ALg8bN4oUHLL/CKdDkMhaSMKFdZ7r88yO/jlXHahRR2GQxANK1q8wQW2xyvCl3eZiHMmLMV41kKo6IDE7jne56P4/0E=
X-Received: by 2002:a67:b245:: with SMTP id s5mr14618120vsh.200.1548950322316; 
 Thu, 31 Jan 2019 07:58:42 -0800 (PST)
MIME-Version: 1.0
References: <1548921212-5219-1-git-send-email-chaotian.jing@mediatek.com>
In-Reply-To: <1548921212-5219-1-git-send-email-chaotian.jing@mediatek.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Thu, 31 Jan 2019 16:58:06 +0100
Message-ID: <CAPDyKFruCCs_un1oR-gd1P=ZGryyHwKuY0SkvLO2=Jm1bGV6sQ@mail.gmail.com>
Subject: Re: [PATCH] mmc: mmc: Fix HS setting in mmc_hs400_to_hs200()
To: Chaotian Jing <chaotian.jing@mediatek.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190131_075843_792668_02B01227 
X-CRM114-Status: GOOD (  21.69  )
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
 Simon Horman <horms+renesas@verge.net.au>,
 Kyle Roeschley <kyle.roeschley@ni.com>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Thu, 31 Jan 2019 at 08:53, Chaotian Jing <chaotian.jing@mediatek.com> wrote:
>
> mmc_hs400_to_hs200() begins with the card and host in HS400 mode.
> Therefore, any commands sent to the card should use HS400 timing.
> It is incorrect to reduce frequency to 50Mhz before sending the switch
> command, in this case, only reduce clock frequency to 50Mhz but without
> host timming change, host is still in hs400 mode but clock changed from
> 200Mhz to 50Mhz, which makes the tuning result unsuitable and cause
> the switch command gets response CRC error.

According the eMMC spec there is no violation by decreasing the clock
frequency like this. We can use whatever value <=200MHz.

However, perhaps in practice this becomes an issue, due to the tuning
for HS400 has been done on the "current" frequency.

As as start, I think you need to clarify this in the changelog.

>
> this patch refers to mmc_select_hs400(), make the reduce clock frequency
> after card timing change.
>
> Signed-off-by: Chaotian Jing <chaotian.jing@mediatek.com>
> ---
>  drivers/mmc/core/mmc.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
> index da892a5..21b811e 100644
> --- a/drivers/mmc/core/mmc.c
> +++ b/drivers/mmc/core/mmc.c
> @@ -1239,10 +1239,6 @@ int mmc_hs400_to_hs200(struct mmc_card *card)
>         int err;
>         u8 val;
>
> -       /* Reduce frequency to HS */
> -       max_dtr = card->ext_csd.hs_max_dtr;
> -       mmc_set_clock(host, max_dtr);
> -

As far as I can tell, the reason to why we change the clock frequency
*before* the call to __mmc_switch() below, is probably to try to be on
the safe side and conform to the spec.

However, I think you have a point, as the call to __mmc_switch(),
passes the "send_status" parameter as false, no other command than the
CMD6 is sent to the card.

>         /* Switch HS400 to HS DDR */
>         val = EXT_CSD_TIMING_HS;
>         err = __mmc_switch(card, EXT_CSD_CMD_SET_NORMAL, EXT_CSD_HS_TIMING,
> @@ -1253,6 +1249,10 @@ int mmc_hs400_to_hs200(struct mmc_card *card)
>
>         mmc_set_timing(host, MMC_TIMING_MMC_DDR52);
>
> +       /* Reduce frequency to HS */
> +       max_dtr = card->ext_csd.hs_max_dtr;
> +       mmc_set_clock(host, max_dtr);
> +

Perhaps it's even more correct to change the clock frequency before
the call to mmc_set_timing(host, MMC_TIMING_MMC_DDR52). Otherwise you
will be using the DDR52 timing in the controller, but with a too high
frequency.

>         err = mmc_switch_status(card);
>         if (err)
>                 goto out_err;
> --
> 1.8.1.1.dirty
>

Finally, it sounds like you are trying to fix a real problem, can you
please provide some more information what is happening when the
problem occurs at your side?

Kind regards
Uffe

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
