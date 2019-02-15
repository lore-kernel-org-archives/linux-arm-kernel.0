Return-Path: <SRS0=7SPH=QW=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9295BC43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 11:08:36 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 50DB821A80
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 11:08:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="WpimZirZ";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mF96k0Ab"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 50DB821A80
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=oUReg+HlHNXYFNgrnBBhs04CYNP+erSVXF0IW0iKUQw=; b=WpimZirZkmXxkW
	iGgkoqKaKB1ihovT8RNvO+O59Hh6uZuugVLKJwPKirM8LBONobXiJHBqooL640EwWdgyrWRpEc3UG
	/tv7ht+HOwdl4d9FqUxukjmI8EKdJxYs4txhUVuHOomLaBVLaIZfbziOTob/OtVK6AYVI/Ad9dJex
	p560WxoyInQ/F5i1TbyHlENal3eVoVh7vZIjZrw5O5c92LJsVto21t/1utNmJ8I9nYdiCcoc/i47K
	nE34iRm5y0Dox5SJIbI2KzZRk8msH7PpmovmRHnNMe9PYZ/lUlXhjF47TRjukuS+fUoMtDplV/AjE
	HsaCRMfMYU168FBtEufQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gubLe-0000di-Ib; Fri, 15 Feb 2019 11:08:02 +0000
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gubLb-0000dG-8t
 for linux-arm-kernel@lists.infradead.org; Fri, 15 Feb 2019 11:08:00 +0000
Received: by mail-wr1-x441.google.com with SMTP id f14so9943895wrg.1
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 15 Feb 2019 03:07:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=DHreN7FmvfNjJM3uXrYhnaHzqQk+jmY9ofZPntDTasI=;
 b=mF96k0AbTJhNZCfTcEsvKSncScD1ZXwuN6JBD8+SmL9l6B9W9wbYM/MNfWu9EVfvyK
 qsZ3SjgifMyROTc155lHthisuXMNbHX9hi8KeFmm1M51Tibk2pe9//OOOl/6zgtsALA6
 QLf4rx8W+QCJ69hQBg10yi/mNvAKjeyE3iy8GxMshPtAyrbzTtvPvmrokqcR8mNEiPi5
 yFQk0mv6IDS/v950tFSS+yjupdYiMaQGHg7UqNbzDotndW4Z5eob1DrcXZ/7CKAdsigd
 0BgRcgzmKkn4qG+W2drHveKivVBz+kziQacK1KFAiE76889N2cdu7koKJ6z7XSNOzYdt
 iuEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=DHreN7FmvfNjJM3uXrYhnaHzqQk+jmY9ofZPntDTasI=;
 b=r6Lg8aplJYy1RLPQK4VTws+UfEWQw7O3K54h4dz7W+86A7Ky9Xq0CkfNI/Y53HmC0Q
 0qICYRGU9LVkkgalNeS1fMcfv4J0afZ9G+zyp8Fv3o8c0FmLbtYN3PBdrfpCUATKGrkK
 5MJW8DyheC6Nar1OYRaWgi/5qX2Tq7qXMHxv3wLs109xl2OxUtBdvcey1OVQPdcvwzBq
 hoEz4ktSqJXJkxht/BBdvbgemLlTtaxzQxFM7RIGoOY+KHugqo6c1qOakWkCMQDBYf+v
 WVefwTNRNr2BIXJjxWYYcYS75mO6AmS/9ty3PLjyp/byxHRQ6woqPMfe5v7E7QmDEfIk
 A6Eg==
X-Gm-Message-State: AHQUAuaUjcuEQg4sMAQSP1BBk1A65L6g38oChymAR6Wx3ifEAaFKQQRg
 Ph868qKnfJDtKE1KHt0GSHnnikQV1HNqX9B+304=
X-Google-Smtp-Source: AHgI3IZKH68DrdTcf1gIsMsZukuofUUR2cx420By69f0NaWIFbm6xY/eUgsqqrzWZVTyy3PGN0rhyyGX1aiFYjcMlB8=
X-Received: by 2002:a5d:5504:: with SMTP id b4mr3800825wrv.291.1550228877049; 
 Fri, 15 Feb 2019 03:07:57 -0800 (PST)
MIME-Version: 1.0
References: <20190129195214.30272-1-sxauwsk@163.com>
In-Reply-To: <20190129195214.30272-1-sxauwsk@163.com>
From: Shubhrajyoti Datta <shubhrajyoti.datta@gmail.com>
Date: Fri, 15 Feb 2019 16:37:46 +0530
Message-ID: <CAKfKVtELqoNNJB0qB88ghGoVrdV2-Ez1DjvmT3dZifntdV0GQg@mail.gmail.com>
Subject: Re: [PATCH] i2c: cadence: try reset when master receive error
 interrupts
To: sxauwsk <sxauwsk@163.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190215_030759_323793_FE9ED7FE 
X-CRM114-Status: GOOD (  20.95  )
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
Cc: linux-kernel@vger.kernel.org,
 Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>,
 Michal Simek <michal.simek@xilinx.com>, linux-arm-kernel@lists.infradead.org,
 linux-i2c@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi Sxauwsk,

On Wed, Jan 30, 2019 at 3:13 PM sxauwsk <sxauwsk@163.com> wrote:
>
> When the adapter receive error interrupts, such as NACK, arbitration lost,
> cdns_i2c_master_xfer return to the caller directly instead of resuming
> the adapter which resulted in the adapter being out of control.
>
> So when driver detect err_status then try to repair and fix it.
>
> Signed-off-by: sxauwsk <sxauwsk@163.com>
> ---
>  drivers/i2c/busses/i2c-cadence.c | 12 +++++++-----
>  1 file changed, 7 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/i2c/busses/i2c-cadence.c b/drivers/i2c/busses/i2c-cadence.c
> index b13605718291..e10048d7524a 100644
> --- a/drivers/i2c/busses/i2c-cadence.c
> +++ b/drivers/i2c/busses/i2c-cadence.c
> @@ -548,10 +548,6 @@ static int cdns_i2c_process_msg(struct cdns_i2c *id, struct i2c_msg *msg,
>         cdns_i2c_writereg(CDNS_I2C_IXR_ALL_INTR_MASK,
>                           CDNS_I2C_IDR_OFFSET);
>
> -       /* If it is bus arbitration error, try again */
> -       if (id->err_status & CDNS_I2C_IXR_ARB_LOST)
> -               return -EAGAIN;
> -
>         return 0;
>  }
>
> @@ -617,13 +613,19 @@ static int cdns_i2c_master_xfer(struct i2c_adapter *adap, struct i2c_msg *msgs,
>                         id->bus_hold_flag = 0;
>
>                 ret = cdns_i2c_process_msg(id, msgs, adap);
> -               if (ret)
> +               if (!ret)
>                         goto out;
>
In case  the Arbitration error happend  the cdns_i2c_process_msg would return 0
and we will miss the check  below.

Am I missing something ?

>                 /* Report the other error interrupts to application */
>                 if (id->err_status) {
>                         cdns_i2c_master_reset(adap);
>
> +                       /* If it is bus arbitration error, try again */
> +                       if (id->err_status & CDNS_I2C_IXR_ARB_LOST) {
> +                               ret = -EAGAIN;
> +                               goto out;
> +                       }
> +
>                         if (id->err_status & CDNS_I2C_IXR_NACK) {
>                                 ret = -ENXIO;
>                                 goto out;
> --
> 2.19.2
>
>

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
