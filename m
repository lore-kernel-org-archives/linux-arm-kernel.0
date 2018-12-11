Return-Path: <SRS0=rVA4=OU=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E0D8C07E85
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 16:44:51 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 496B22086D
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 16:44:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="iBgDFxn9";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OcNWtioe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 496B22086D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=1TmF/w5CWnm41Ov+YVGC82tErmDWGl76/qRtR0EiQZ4=; b=iBgDFxn9or47vc
	nvLOjCl999d7toAOFkH2pC9m4Trgq4z1q5SRJefugEhXwWv8FwfuIU9S4E/hiQEV1hW6EaIHG5t2u
	JvLJhPbygrWWsPE/nk94v+tzyqzOqWT6UB2gQDmbncaavcrWc7IcKm24M/e4kUkYbaVRC8SAv4Hcw
	P0DHw2zt+F6PVcRLrWrGnQJezBoFO1mCj0lLgbEavK8VqDvAnXAgmJTAuBqgT5fStbJ2OlG5QeGWI
	54acPwpVA+S/i8OLkz+yjWW522jzrmlwF71cZrbJDdubfuB1hpPWq47gcR5lArECw4Ts6DYJpPSGt
	WPZr24vTDxAboRMzO9jw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gWl9I-0004Wz-6y; Tue, 11 Dec 2018 16:44:44 +0000
Received: from mail-it1-x143.google.com ([2607:f8b0:4864:20::143])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gWl96-0004CQ-VY
 for linux-arm-kernel@lists.infradead.org; Tue, 11 Dec 2018 16:44:38 +0000
Received: by mail-it1-x143.google.com with SMTP id g76so4537851itg.2
 for <linux-arm-kernel@lists.infradead.org>;
 Tue, 11 Dec 2018 08:44:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=DwyPkcVNlLZnkFsH0IBvFgeaelucitRwz/cnxhMyq00=;
 b=OcNWtioevuvc/8nzGgqOOYaIHMqoBT6YJ2NyNbql7RMuuxhL4oV92ktm8oRmQnUeIG
 wu+lLgmvB9xMGXFdQsHo8M2mx3yzMuu2aqVH3iec43sjq6rrdbM2cEGBu5pw3bfMPnXE
 m3gXAzkzLSipA7Njzg8vduGttGwauGeMi3MGnkoFa0iBjSoQWuJ4lfDEshT+KDbTBz20
 uswk+V0hIyoh40gz15/V25colYk6DlMJ5dVylZU5NRN3fhBYBhESBBcaylxHsR6U83qp
 TIHpswi79HBhZWqQX3MD8RU2zYCizeJYDdZ6ynCTDzUqZnQ+ggrITAvsleIPYG2nEg23
 PiuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=DwyPkcVNlLZnkFsH0IBvFgeaelucitRwz/cnxhMyq00=;
 b=q6YX7tPIANIn//rivTH6GXwqhjB6jwLKZWUb73/S/oVIh7+jYPa/gisnokjZp7wrJP
 oQE63/p5EMASPWGmYc51fQ6iEaCmNRu3zaS4MIm7m6LJUlikLibviAMugpnvp/NyRce8
 4+HjU14Mb+azDk8wPh6VoC1qh7DKJCmmmAY4vFdrqCUS9mVoanVlhHqLJ0sZvHhgKSCx
 25BJRN8FnSNQTtHJUZ/J1Q6DQrDOMkLWuPjOrVU0QpMxOyVouYt9VHwAqJ6KIuT/Q1Yr
 6f0Og2bPgD2K34gP5AqVMWRrSdhuLagc3whmENPoNZUU8oIcl23pjf6FAaid5lcWNwTq
 o7OQ==
X-Gm-Message-State: AA+aEWZ0R2TeRdjFN5mYO9FyeIYxCzMpxX03mqxhCk97oWYDK1rez+Mu
 jCJ66zt+xuvpQX4Qp6Qm3fAZXiBtFFVMviMCjxw=
X-Google-Smtp-Source: AFSGD/X4y0pidDxX9ZH+JY5Xsua9IQ/rzkuT99x+4G01MX0m+PX+crm4EEO57sDth6obt0Ty02P5KX6ZJWvl5R5g/Bg=
X-Received: by 2002:a24:a701:: with SMTP id a1mr2731659itf.7.1544546661714;
 Tue, 11 Dec 2018 08:44:21 -0800 (PST)
MIME-Version: 1.0
References: <20181210210310.12677-1-wsa+renesas@sang-engineering.com>
 <20181210210310.12677-5-wsa+renesas@sang-engineering.com>
In-Reply-To: <20181210210310.12677-5-wsa+renesas@sang-engineering.com>
From: Kamal Dasu <kdasu.kdev@gmail.com>
Date: Tue, 11 Dec 2018 11:44:01 -0500
Message-ID: <CAC=U0a2cvdhAdBPyowR3i=wpnONDHjBWMZ56D_pJYfhYL=DTbg@mail.gmail.com>
Subject: Re: [RFC/RFT 04/10] i2c: brcmstb: use core helper to mark adapter
 suspended
To: wsa+renesas@sang-engineering.com
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181211_084433_918173_8306FD69 
X-CRM114-Status: GOOD (  17.51  )
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
Cc: Florian Fainelli <f.fainelli@gmail.com>, linux-pm@vger.kernel.org,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 linux-renesas-soc@vger.kernel.org, hdegoede@redhat.com,
 bcm-kernel-feedback-list@broadcom.com, linux-i2c@vger.kernel.org,
 Gregory Fong <gregory.0xf0@gmail.com>,
 Brian Norris <computersforpeace@gmail.com>,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Mon, Dec 10, 2018 at 4:03 PM Wolfram Sang
<wsa+renesas@sang-engineering.com> wrote:
>
> Rejecting transfers should be handled by the core.
>
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>

Reviewed-by: Kamal Dasu <kdasu.kdev@gmail.com>

> ---
>  drivers/i2c/busses/i2c-brcmstb.c | 13 ++-----------
>  1 file changed, 2 insertions(+), 11 deletions(-)
>
> diff --git a/drivers/i2c/busses/i2c-brcmstb.c b/drivers/i2c/busses/i2c-brcmstb.c
> index 826d32049996..05c822e5a3f6 100644
> --- a/drivers/i2c/busses/i2c-brcmstb.c
> +++ b/drivers/i2c/busses/i2c-brcmstb.c
> @@ -170,7 +170,6 @@ struct brcmstb_i2c_dev {
>         struct bsc_regs *bsc_regmap;
>         struct i2c_adapter adapter;
>         struct completion done;
> -       bool is_suspended;
>         u32 clk_freq_hz;
>         int data_regsz;
>  };
> @@ -467,9 +466,6 @@ static int brcmstb_i2c_xfer(struct i2c_adapter *adapter,
>         int xfersz = brcmstb_i2c_get_xfersz(dev);
>         u32 cond, cond_per_msg;
>
> -       if (dev->is_suspended)
> -               return -EBUSY;
> -
>         /* Loop through all messages */
>         for (i = 0; i < num; i++) {
>                 pmsg = &msgs[i];
> @@ -689,10 +685,7 @@ static int brcmstb_i2c_suspend(struct device *dev)
>  {
>         struct brcmstb_i2c_dev *i2c_dev = dev_get_drvdata(dev);
>
> -       i2c_lock_bus(&i2c_dev->adapter, I2C_LOCK_ROOT_ADAPTER);
> -       i2c_dev->is_suspended = true;
> -       i2c_unlock_bus(&i2c_dev->adapter, I2C_LOCK_ROOT_ADAPTER);
> -
> +       i2c_mark_adapter_suspended(&i2c_dev->adapter, true);
>         return 0;
>  }
>
> @@ -700,10 +693,8 @@ static int brcmstb_i2c_resume(struct device *dev)
>  {
>         struct brcmstb_i2c_dev *i2c_dev = dev_get_drvdata(dev);
>
> -       i2c_lock_bus(&i2c_dev->adapter, I2C_LOCK_ROOT_ADAPTER);
>         brcmstb_i2c_set_bsc_reg_defaults(i2c_dev);
> -       i2c_dev->is_suspended = false;
> -       i2c_unlock_bus(&i2c_dev->adapter, I2C_LOCK_ROOT_ADAPTER);
> +       i2c_mark_adapter_suspended(&i2c_dev->adapter, false);
>
>         return 0;
>  }
> --
> 2.11.0
>

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
