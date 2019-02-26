Return-Path: <SRS0=3RVO=RB=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC63FC43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 23:31:44 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 851E5218D0
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 23:31:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="jKJ58uNN";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="CJVChc04"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 851E5218D0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=yaz/5Meg3dI7eatPH3wjcxV/2C8M61kqCzsYU5VBEY8=; b=jKJ58uNNBTEqP1
	VMW3c8A4UwWC2TWEmAEu/yQDxJEzxnoAjdl6WptcxzoNrnow1iZDiQZoLV8KgPhME/refYKNgGORG
	MEuyja12GX8LiOU+dj+gtkg7Y2yOyYKYFNEOYNUPeyxx2EPDoYrTxv7hmYi3byPOPMaBxPFqb1U9H
	szYgofyb8XHicNK2cJKrOrrj+ZfGbeNgqBHcDxaoV+nOSzhBldiFM343RkDUm5u7luPTpDeBdUFHK
	7+zG/l1WKEHOx3zphK5VDdaiFmEuKkgrLeS8Ew1jQQG/72oIKCYCnXdVouzWtS3lURSLG8YCrnCPb
	dzmDJ4MVdJu3t2ZNGJlg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gymCK-0006FV-Oq; Tue, 26 Feb 2019 23:31:40 +0000
Received: from mail-pl1-x641.google.com ([2607:f8b0:4864:20::641])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gymCH-0006Dz-1u
 for linux-arm-kernel@lists.infradead.org; Tue, 26 Feb 2019 23:31:38 +0000
Received: by mail-pl1-x641.google.com with SMTP id q3so7004818pll.4
 for <linux-arm-kernel@lists.infradead.org>;
 Tue, 26 Feb 2019 15:31:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=chromium.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=eZftrEl2TJJyeXw3guyXn2Erxve3Q0bY03ECyAZSZkA=;
 b=CJVChc04zJZUo3K33F3OsZQDaPAKKoTWxPs3ew9CDFaI+QdAV0Zz9utupNPjw66fh0
 60t5Uhv7rXVQxDz3sE+dgO1F8HHjDXWcFc074qe2B8O0x57vHqUQ4+4SH4jVkevTW9Pi
 NSQ0iXXV3VsMlpaebzt6XC+/0kY/8yaeBt3WQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=eZftrEl2TJJyeXw3guyXn2Erxve3Q0bY03ECyAZSZkA=;
 b=KNz+5c+Ukfy1l6L0rkj0Kz4OgWCHL/4NlC671iGu9eCHSmTI1q0Fzhx72UatA/P+m/
 00uRnYy7zucSCI2xcBQinfyw4LrNpwhEeqTDnnEe81ZnXnO5oCbcudhzMx06+qpFChGN
 MHL6L5ZoxunxhczUBwS3FfQv0YqA+98W3MBLEIuGbjaDwIfNl7KhBPIQeH4EA5UZFBmr
 XRucGOW5lrA2Bo0oSMIo8iD8jZCDUHcAeeuSxLoNmTdosKJTHq8W6kCGFZArsyXm3EPk
 a7uXwaKWYb4jKvXj/rI9cVfuDDyV8z6/OxV5RpqS4t2gpdXMRr+j+Sp3F1W5p++9gd2Y
 SbCQ==
X-Gm-Message-State: AHQUAuZ0bGsdphTL1LZKL+M+ekRfwhuyWQea1oieObmYSRdfPm/Z644A
 ZST+UpUzCm0zF0DRXaglA0asfA==
X-Google-Smtp-Source: AHgI3IYXSloYwmu732eq9VDlhsQrfMmwAMs1E83QJcex86P2fK0Dk80HaMPkiZGCK4hNwXQLdTNWhQ==
X-Received: by 2002:a17:902:b609:: with SMTP id
 b9mr29004600pls.134.1551223895038; 
 Tue, 26 Feb 2019 15:31:35 -0800 (PST)
Received: from google.com ([2620:15c:202:1:534:b7c0:a63c:460c])
 by smtp.gmail.com with ESMTPSA id x2sm22722798pfx.78.2019.02.26.15.31.33
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Tue, 26 Feb 2019 15:31:34 -0800 (PST)
Date: Tue, 26 Feb 2019 15:31:31 -0800
From: Brian Norris <briannorris@chromium.org>
To: Marc Zyngier <marc.zyngier@arm.com>
Subject: Re: [PATCH 3/4] mwifiex: Flag wake-up interrupt as IRQ_NOAUTOEN
 rather than disabling it too late
Message-ID: <20190226233130.GB174696@google.com>
References: <20190224140426.3267-1-marc.zyngier@arm.com>
 <20190224140426.3267-4-marc.zyngier@arm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190224140426.3267-4-marc.zyngier@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190226_153137_098758_12997291 
X-CRM114-Status: GOOD (  18.38  )
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
Cc: Ganapathi Bhat <gbhat@marvell.com>, Heiko Stuebner <heiko@sntech.de>,
 devicetree@vger.kernel.org, Xinming Hu <huxinming820@gmail.com>,
 netdev@vger.kernel.org, linux-wireless@vger.kernel.org,
 linux-kernel@vger.kernel.org, Amitkumar Karwar <amitkarwar@gmail.com>,
 linux-rockchip@lists.infradead.org, Nishant Sarmukadam <nishants@marvell.com>,
 Rob Herring <robh+dt@kernel.org>, linux-arm-kernel@lists.infradead.org,
 Enric Balletbo i Serra <enric.balletbo@collabora.com>,
 "David S. Miller" <davem@davemloft.net>, Kalle Valo <kvalo@codeaurora.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi Marc,

On Sun, Feb 24, 2019 at 02:04:25PM +0000, Marc Zyngier wrote:
> The mwifiex driver makes unsafe assumptions about the state of the
> wake-up interrupt. It requests it and only then disable it. Of
> course, the interrupt may be screaming for whatever reason at that
> time, and the handler will then be called without the interrupt
> having been registered with the PM/wakeup subsystem. Oops.
> 
> The right way to handle this kind of situation is to flag the
> interrupt with IRQ_NOAUTOEN before requesting it. It will then
> stay disabled until someone (the wake-up subsystem) enables it.
> 
> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>

This could be:

Fixes: 853402a00823 ("mwifiex: Enable WoWLAN for both sdio and pcie")

although, that was just borrowing the existing antipattern from SDIO
code..

Reviewed-by: Brian Norris <briannorris@chromium.org>

Thanks.

> ---
>  drivers/net/wireless/marvell/mwifiex/main.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/net/wireless/marvell/mwifiex/main.c b/drivers/net/wireless/marvell/mwifiex/main.c
> index 2105c2b7c627..82cf35e50579 100644
> --- a/drivers/net/wireless/marvell/mwifiex/main.c
> +++ b/drivers/net/wireless/marvell/mwifiex/main.c
> @@ -1610,6 +1610,7 @@ static void mwifiex_probe_of(struct mwifiex_adapter *adapter)
>  			 "wake-up interrupt outside 'wake-up' subnode of %pOF\n",
>  			 adapter->dt_node);
>  
> +	irq_set_status_flags(adapter->irq_wakeup, IRQ_NOAUTOEN);
>  	ret = devm_request_irq(dev, adapter->irq_wakeup,
>  			       mwifiex_irq_wakeup_handler, IRQF_TRIGGER_LOW,
>  			       "wifi_wake", adapter);
> @@ -1619,7 +1620,6 @@ static void mwifiex_probe_of(struct mwifiex_adapter *adapter)
>  		goto err_exit;
>  	}
>  
> -	disable_irq(adapter->irq_wakeup);
>  	if (device_init_wakeup(dev, true)) {
>  		dev_err(dev, "fail to init wakeup for mwifiex\n");
>  		goto err_exit;
> -- 
> 2.20.1
> 

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
