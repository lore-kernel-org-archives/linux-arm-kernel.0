Return-Path: <SRS0=/awj=OT=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C997C67839
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 21:31:29 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EB31C2086D
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 21:31:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="go6VjNW9";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ylWzHb0s";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="XYJyz4tG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EB31C2086D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=bLJWuL7chI3qJps7E+jevkJPcacofmRtKa9dxJxd71s=; b=go6VjNW92FMeF6
	HT9fDs2a2F8O7Bbgs+BFhd/80EyRee/BI0yPWb7Lp1KToTFA/xX/fEa107JXeLTzUjMzP+KKQ25Z0
	YnQDNl8OJosWC9yq7iEaWo+HH9Gsg9qpjILHbjtfc4MJ4IBeylO6KavXDzDyZrE8D6FJAc5+zo55t
	OZ0bRWA5Pv8K3E/1aTqMPKp4ssMrCjUh6UDf8kPpRJYQalCDHQSF9xWNqhtc3PO1EUXOoKVbqU1Mj
	DV98dmdVQqvXJOC9eNnxyEUPMA7xWjf8i9Ks3FS11//JQeo1s7hdkd37RBdWTawml0jJI2N/S6ec9
	XMDGXo/OyPRMu1roAhfw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gWT9C-0004us-Cm; Mon, 10 Dec 2018 21:31:26 +0000
Received: from merlin.infradead.org ([2001:8b0:10b:1231::1])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gWT9A-0004ul-LD
 for linux-arm-kernel@bombadil.infradead.org; Mon, 10 Dec 2018 21:31:24 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=merlin.20170209; h=Content-Type:Cc:To:Subject:Message-ID:
 Date:From:In-Reply-To:References:MIME-Version:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=3bC2z7tUV8JkK88NZkHivaWApFVgDb5ee5X2hJ0P7qM=; b=ylWzHb0sPEIj/HCUKmJ02mkhD
 2kfLyfE+8ArU2X4PFvQqcAktK8+nebcM88Y1Yow7IrrKYZD9VEdB6V3fRyWhT0nEkVLB6rp69JoPa
 3S7+O2S9F723rwQtLlWIPcL5WCjwg3t/1FGQd7GxSLH9MNkXaeyaClk2eQQVCBIQOhN35rNRKhLJW
 nYtm3AG4m8j83pMNnw0wrwv5PW/Uw4CtojpW6TcM3SLgIfu1iyHx884gtqFg+aXMRhueziLrbtjv8
 Vp4cotb3L2I586DlvkrGsELx4X+3/aOuu8KjzcNtYE0/JU2UCOxZHBXNh8QVtyzAi0SC4etVpaOOU
 y6+Vt/h8A==;
Received: from mail-io1-xd43.google.com ([2607:f8b0:4864:20::d43])
 by merlin.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gWSjA-0008Oo-7r
 for linux-arm-kernel@lists.infradead.org; Mon, 10 Dec 2018 21:04:33 +0000
Received: by mail-io1-xd43.google.com with SMTP id i1so7974971ioo.2
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 10 Dec 2018 13:04:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=3bC2z7tUV8JkK88NZkHivaWApFVgDb5ee5X2hJ0P7qM=;
 b=XYJyz4tG9uLneocwyimMtdToxIZm8iC8Wh9IfWiuTX8iFg4nhqvAeXOIjo2ClmAwrA
 6Z1NpNLL/dDn9hti8LXR3L8DKzsqV+zYVcFpgQ4KEP9eq6h6zzNMeqAe5Irq2KvbSmWF
 mWxPCpYlj7gFccxBbv7SJjkUUaBYdfpAKVqqg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=3bC2z7tUV8JkK88NZkHivaWApFVgDb5ee5X2hJ0P7qM=;
 b=nekiAacwwtwnrIh75jwg9EDsYJf2C8ir9oRBrgrMhyxZnmkTjYpVDajK80USx5IJjY
 Svs9dD7b0PQtW2R0It9AJ/TSS9vjbs7qT2pVB5InUwswOrVfqmiTTWWwntU0bcDwdOd6
 MCnl1rWmzdbYf7tGf3pghjosgnadh9tH9MEHZvYyKv4maME3oOr7jsioXZrPl/vz6Xyb
 TI1GDhOlOgr1rgvdStXQaVFrBAgz1VQjzSWM9gO3c0+7Ohz7CH4CpMtj5IJ4es54EG88
 IAy+7ZH1i9owepJTBXJpGyX6eSkXIFvd96c9XXQT3yOwTaH//5IPZqGK+gi6WHuE0Bag
 xsNg==
X-Gm-Message-State: AA+aEWY09BhQDBLU4ohP33FbeQGudC7ZljTv7Nas31OZRzro2UlZ9vbg
 edXFCfts5b3OGRNkGmbrG02c4mvPR/NHmDapcH/WtA==
X-Google-Smtp-Source: AFSGD/Wg0H2qX1k8HvrVBgsxXbbmsMAexORHgZBFUFulC7vw3NDvXsLWAKrxpF0aJvz+KEwdC244DcU+KzTj91mzkYc=
X-Received: by 2002:a5e:cb42:: with SMTP id h2mr11757906iok.60.1544475857969; 
 Mon, 10 Dec 2018 13:04:17 -0800 (PST)
MIME-Version: 1.0
References: <20181210210310.12677-1-wsa+renesas@sang-engineering.com>
 <20181210210310.12677-4-wsa+renesas@sang-engineering.com>
In-Reply-To: <20181210210310.12677-4-wsa+renesas@sang-engineering.com>
From: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date: Mon, 10 Dec 2018 22:04:06 +0100
Message-ID: <CAKv+Gu9uGxTjBhAD3WyQBohhZ=bswXOoo4waTetArrS601_LJQ@mail.gmail.com>
Subject: Re: [RFC/RFT 03/10] i2c: synquacer: remove unused is_suspended flag
To: wsa+renesas@sang-engineering.com
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181210_160432_349124_A4A6E426 
X-CRM114-Status: GOOD (  16.23  )
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
Cc: linux-pm <linux-pm@vger.kernel.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
 Hans de Goede <hdegoede@redhat.com>, linux-i2c <linux-i2c@vger.kernel.org>,
 linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Mon, 10 Dec 2018 at 22:03, Wolfram Sang
<wsa+renesas@sang-engineering.com> wrote:
>
> This flag was defined and checked but never set a value. Remove it.
>
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>

Acked-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>

> ---
>  drivers/i2c/busses/i2c-synquacer.c | 5 -----
>  1 file changed, 5 deletions(-)
>
> diff --git a/drivers/i2c/busses/i2c-synquacer.c b/drivers/i2c/busses/i2c-synquacer.c
> index 2184b7c3580e..d18b0941b71a 100644
> --- a/drivers/i2c/busses/i2c-synquacer.c
> +++ b/drivers/i2c/busses/i2c-synquacer.c
> @@ -144,8 +144,6 @@ struct synquacer_i2c {
>         u32                     timeout_ms;
>         enum i2c_state          state;
>         struct i2c_adapter      adapter;
> -
> -       bool                    is_suspended;
>  };
>
>  static inline int is_lastmsg(struct synquacer_i2c *i2c)
> @@ -316,9 +314,6 @@ static int synquacer_i2c_doxfer(struct synquacer_i2c *i2c,
>         unsigned long timeout;
>         int ret;
>
> -       if (i2c->is_suspended)
> -               return -EBUSY;
> -
>         synquacer_i2c_hw_init(i2c);
>         bsr = readb(i2c->base + SYNQUACER_I2C_REG_BSR);
>         if (bsr & SYNQUACER_I2C_BSR_BB) {
> --
> 2.11.0
>

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
