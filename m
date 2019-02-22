Return-Path: <SRS0=2lwk=Q5=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22355C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 18:04:18 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DD4A32070D
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 18:04:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="oZvYa2Sa";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="gN98Qmmx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DD4A32070D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=24uIp5s6yd2UP1cVV62TWp6yquzqlSSnIdvLFILLDhs=; b=oZvYa2Saw5gsDj
	0tQExrCdfmXI2YdQyDzI97Sp12E8x4YRHO25Opk7+td60BpzfyWYuVl3vYMT2I9HoKBWt+x8UF7Uc
	x5/a/lCKtpNQRxlcY1UE7JyaFKnatBZf3KXfBpmloQZau6kq+CIChnd9t0S4o4f0prL2WofKikICS
	PSAmm5qkLLfrJDZebyfIb1q2PSXg1n6XLyqyhP8pbmvYLuvCoVklsTdnVzDi/yVROc/4+MbKOTqka
	NHmMmNKA2btKzn+HnrSNl6Bk6CBvhz81Ad4ZZ0gAgXva9F5gE/xz5VKGM83Xfy7uq+sdW1Jm0lE8M
	ZEKD+jFBAmUtqMNnB5NA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gxFBE-0006Ro-DA; Fri, 22 Feb 2019 18:04:12 +0000
Received: from mail-pf1-x444.google.com ([2607:f8b0:4864:20::444])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gxFBB-0006Qj-7I
 for linux-arm-kernel@lists.infradead.org; Fri, 22 Feb 2019 18:04:10 +0000
Received: by mail-pf1-x444.google.com with SMTP id j5so1458168pfa.2
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 22 Feb 2019 10:04:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=chromium.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=NBDYynHnmf+PRB+3zm8U/Thb/lB25m9nA1UHHlQDuNI=;
 b=gN98QmmxC+80Hu4YvrI+l3Hfk1gs5wZNu1e4tkZEzLWreZtkoR4+s+lplguLhGMadW
 8Iw5FbnNo//NOsKNMu8tqa5plZa92xNAu5v2ZspLY2mNgA8MMsSmYBfnIU9V+qiySEzP
 nbinkTI3qQInivoWhVx2fUrdIFYG3EotOlxIM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=NBDYynHnmf+PRB+3zm8U/Thb/lB25m9nA1UHHlQDuNI=;
 b=AB8sJjN7cDgbGoQaDbmtMZW+ytyDZAlDndxszY1/8RtdW2crWGkh7S5B5GFtoObnQV
 LbanW69n2nkUoCZ3yyLdmOWtNWDO/lxcD87I8ir7xYuXA6nqTho1sH5i7jbT0YTTdaCc
 MAaFBqD2hotjyjmhEchqCa92XdGPh4PrAkf1L0IYYetRFlxgShCPlnrMmE94SAeb/z5K
 vp6LG98jZKq2tU4oeyYAJab7w7Jn7xW9REh1440YDRjELO8aJWMeqjvso1tUGEgEzdXJ
 HSxQjnaMRe7Mg2BnF9tUJhVesSH4vvA0jWcWFKnil6HDAguLwA3uAYi+wSQs0UVegYYe
 W3lg==
X-Gm-Message-State: AHQUAuaPuuoSi2U1glVAK3DMXx8ZoKBvE2hEQeEBw/PXLagHQBzdGftO
 WKbWB75gBC+aSGsMZGhF2LgtwUVQHiM=
X-Google-Smtp-Source: AHgI3IYJGUQh4RRG119Jd6S5+H3oe5J3JtSpbOhsBeGSquz0ecMAsn4NE6EKS1OKUgutuP6fEYvfiQ==
X-Received: by 2002:a62:ea08:: with SMTP id t8mr5437076pfh.60.1550858648347;
 Fri, 22 Feb 2019 10:04:08 -0800 (PST)
Received: from localhost ([2620:15c:202:1:75a:3f6e:21d:9374])
 by smtp.gmail.com with ESMTPSA id g67sm6423447pfg.13.2019.02.22.10.04.07
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Fri, 22 Feb 2019 10:04:07 -0800 (PST)
Date: Fri, 22 Feb 2019 10:04:06 -0800
From: Matthias Kaehlcke <mka@chromium.org>
To: Brian Norris <briannorris@chromium.org>
Subject: Re: [PATCH 1/3] Bluetooth: btusb: add QCA6174A compatible properties
Message-ID: <20190222180406.GA223791@google.com>
References: <20190222003403.128243-1-briannorris@chromium.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190222003403.128243-1-briannorris@chromium.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190222_100409_302282_2D2E12DE 
X-CRM114-Status: GOOD (  15.77  )
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
Cc: devicetree@vger.kernel.org, Heiko Stuebner <heiko@sntech.de>,
 linux-bluetooth@vger.kernel.org, Marcel Holtmann <marcel@holtmann.org>,
 Douglas Anderson <dianders@chromium.org>, linux-kernel@vger.kernel.org,
 linux-rockchip@lists.infradead.org, Rob Herring <robh+dt@kernel.org>,
 Enric Balletbo i Serra <enric.balletbo@collabora.com>,
 Rajat Jain <rajatja@google.com>, linux-arm-kernel@lists.infradead.org,
 Johan Hedberg <johan.hedberg@gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Thu, Feb 21, 2019 at 04:34:01PM -0800, Brian Norris wrote:
> We may need to specify a GPIO wake pin for this device, so add a
> compatible property for it.
> 
> There are at least to USB PID/VID variations of this chip: one with a
> Lite-On ID and one with an Atheros ID.
> 
> Signed-off-by: Brian Norris <briannorris@chromium.org>
> ---
>  drivers/bluetooth/btusb.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
> index 470ee68555d9..380e6f38c607 100644
> --- a/drivers/bluetooth/btusb.c
> +++ b/drivers/bluetooth/btusb.c
> @@ -2862,6 +2862,8 @@ static irqreturn_t btusb_oob_wake_handler(int irq, void *priv)
>  
>  static const struct of_device_id btusb_match_table[] = {
>  	{ .compatible = "usb1286,204e" },
> +	{ .compatible = "usb0cf3,e300" }, /* QCA6174A */
> +	{ .compatible = "usb04ca,301a" }, /* QCA6174A (Lite-On) */
>  	{ }
>  };
>  MODULE_DEVICE_TABLE(of, btusb_match_table);

Reviewed-by: Matthias Kaehlcke <mka@chromium.org>

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
