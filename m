Return-Path: <SRS0=ULCN=QZ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECACEC43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 21:11:13 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BDF192070D
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 21:11:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="KGgJkQ53"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BDF192070D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=SZWwYjVPoxHSz/LrJwNdr4Y1ccagdHd0kNKz470DAdw=; b=KGgJkQ53mI5w+x
	O8FLZsRn8W/FDOdOGsMMJpirbx20lRXwzgXmRc3Q51kRUoy8nwikLx6o2zJNewjo3WT/c177FUs5E
	ncXim8RvYFCiVsDrqQXv0A9qExC63GgIlO+aMzw/8eGELfsRnyQurc2vZLNKNDw1DbG7Z5ELALhP2
	oNoT8X4o8LcccqNaXlcXInoISZ8+mDs9Jh1uEzkjMNkUvvv+vbgDIZj+x15XVv3cDrcmyqhX+I7pr
	RsceR9FC3EsQTSOZfoRYYEodm57bqk01vCNK7WlbiG0oDhgRDnNEJ3Pm7VQ2K66SvuuPTY6Ft8TgW
	05NwLuhToV3hBhSlGcJw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gvqBv-0001Sp-76; Mon, 18 Feb 2019 21:11:07 +0000
Received: from mail-ot1-f66.google.com ([209.85.210.66])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gvqBS-0001D6-3u
 for linux-arm-kernel@lists.infradead.org; Mon, 18 Feb 2019 21:10:48 +0000
Received: by mail-ot1-f66.google.com with SMTP id s5so30631784oth.7
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 18 Feb 2019 13:10:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=vfh9VEg4/DD5W56HTE1UyJO7PeETQccNa3gxtKG5ZfU=;
 b=MQrVMvzmsHz+i1CJJyfvs1ygwmFc8QP0hACov7iehrI4TkRdfi3bQYhq1hKkcsQswN
 6KDsIoIGxm7i51Irvusj0I/pmLCfk9/nTQCPEULKm7zEAQXUQC7FJbPx+jshFbvtQuuL
 sHPhM+vDVhI8zSJhpLSs+9EXZDDcy3sw9OsjnLlpSsgNE0LW/UnKkkfS1zZfWFcbrVh+
 qjG5/AELyXJeFl9jMNGskD1j3w/qUFPimeYLz/XdZrxgvxGqCORl2WVV+3kBxpfZAO+i
 q+88xGx8p0HVdaGEoFX2ohfyEm9dpy83jAtFZKG56pP1Zblp7wcrO629eYFkbay13aop
 tX+g==
X-Gm-Message-State: AHQUAubgz176zkzJFliGBPe97ik21yv7t3YAfhjVYtTURDm+4D4OyQee
 WgL8XCSKZtTOLmYoQh2SRQ==
X-Google-Smtp-Source: AHgI3IaBxXUPWP1IeKYNVsruYCspdQ3LnjBv1J7NyA3zKPf1UcF887+r635FYe1HPhnH9k5lbjcAmQ==
X-Received: by 2002:a9d:2f64:: with SMTP id h91mr15620192otb.14.1550524236851; 
 Mon, 18 Feb 2019 13:10:36 -0800 (PST)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net.
 [24.155.109.49])
 by smtp.gmail.com with ESMTPSA id d11sm4453324otp.18.2019.02.18.13.10.36
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Mon, 18 Feb 2019 13:10:36 -0800 (PST)
Date: Mon, 18 Feb 2019 15:10:35 -0600
From: Rob Herring <robh@kernel.org>
To: Vasily Khoruzhick <anarsoul@gmail.com>
Subject: Re: [PATCH 3/8] dt-bindings: net: bluetooth: Add rtl8723bs-bluetooth
Message-ID: <20190218211035.GA28145@bogus>
References: <20190118170232.16142-1-anarsoul@gmail.com>
 <20190118170232.16142-4-anarsoul@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190118170232.16142-4-anarsoul@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190218_131038_264237_4E08277D 
X-CRM114-Status: GOOD (  16.44  )
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
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org,
 Johan Hedberg <johan.hedberg@gmail.com>,
 Maxime Ripard <maxime.ripard@bootlin.com>, netdev@vger.kernel.org,
 Marcel Holtmann <marcel@holtmann.org>, linux-bluetooth@vger.kernel.org,
 Chen-Yu Tsai <wens@csie.org>, "David S. Miller" <davem@davemloft.net>,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Fri, Jan 18, 2019 at 09:02:27AM -0800, Vasily Khoruzhick wrote:
> Add binding document for bluetooth part of RTL8723BS/RTL8723CS
> 
> Signed-off-by: Vasily Khoruzhick <anarsoul@gmail.com>
> ---
>  .../bindings/net/rtl8723bs-bluetooth.txt      | 35 +++++++++++++++++++
>  1 file changed, 35 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/net/rtl8723bs-bluetooth.txt
> 
> diff --git a/Documentation/devicetree/bindings/net/rtl8723bs-bluetooth.txt b/Documentation/devicetree/bindings/net/rtl8723bs-bluetooth.txt
> new file mode 100644
> index 000000000000..8357f242ae4c
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/net/rtl8723bs-bluetooth.txt
> @@ -0,0 +1,35 @@
> +RTL8723BS/RTL8723CS Bluetooth
> +---------------------
> +
> +RTL8723CS/RTL8723CS is WiFi + BT chip. WiFi part is connected over SDIO, while
> +BT is connected over serial. It speaks H5 protocol with few extra commands
> +to upload firmware and change module speed.
> +
> +Required properties:
> +
> + - compatible: should be one of the following:
> +   * "realtek,rtl8723bs-bt"
> +   * "realtek,rtl8723cs-bt"
> +Optional properties:
> +
> + - device-wake-gpios: GPIO specifier, used to wakeup the BT module (active high)
> + - enable-gpios: GPIO specifier, used to enable the BT module (active high)
> + - host-wake-gpios: GPIO specifier, used to wakeup the host processor (active high)
> + - firmware-postfix: firmware postfix to be used for firmware config

How is this used?

Rob


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
