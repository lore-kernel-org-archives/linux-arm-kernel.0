Return-Path: <SRS0=KsRD=PT=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC391C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 16:34:26 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9AB0220872
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 16:34:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Y/TxW0rW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9AB0220872
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=O0KWY7W7JGCl1HhXvBl3xa/+dLcE2j/LbaUTrBTeVrM=; b=Y/TxW0rWK7rAKx
	l25w7YEGI/U9MU7rJ6Ha6Tx5YGZAASvzXtQmCkgrGQKdcuUPCm1J4k2QlLYSoPCfbGKGjRAU6SFLV
	QQbefTzWWwH1d+Otz0y874tIGATd7faiCPeBg4bQ5MKwhd6O4o/veGTvJufRY7/W9fcVkKwIyKOMK
	JaFwAryPw2kD7jJWTkmfFaox26JrtWUvhs8hkE7Ck7Dde5HIjQEVpmYT2GsSMWfCsgRlIUPseH656
	/HydVj9hgcBP/4etd76Aqe0MQuJf/4k+gZe9HC2mj4YuhQMbfWcLe8Zh0CsdExRpk4ZYBbEfoxVXk
	QkueTIcmVerQJ1VYo21w==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1ghzlJ-0006XH-Kr; Fri, 11 Jan 2019 16:34:25 +0000
Received: from mail-oi1-f196.google.com ([209.85.167.196])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1ghzlG-0006Wt-4A
 for linux-arm-kernel@lists.infradead.org; Fri, 11 Jan 2019 16:34:23 +0000
Received: by mail-oi1-f196.google.com with SMTP id x23so12675869oix.3
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 11 Jan 2019 08:34:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=SmbBsFaE2AnxI/LZ9i7weYqy+canQ8pDIZE+UU080nw=;
 b=Mp465xmce+uedF8T1vfnH/r6lM8o9XG2O62SNExFI/hXht+DtKoXYwfizH7yrHLwth
 yPN+s1zmVJJVA+JllSaLS48HkSdixlfZiqiF8fOZCfIpHLr1vRPbGy7Ob0r70AsfpTtn
 u2ZdXBrboc4WoXfWNdPCKvXXY+GvihSGtAaJHGaVhm2U8nYYe2T3Z63PlpUKQY4LBvjQ
 ez3TEJB+DcgOf83p3dlaRTU3VRM97QUlR55B0Vt1NuYQNwsa1rs8UZMNBqlsO7JXKKW7
 5hOCnzbPhlcB9nwQ3wgcO9yPA97GGkO8lhHjPYE1lSjg1aQN4xaqgEjaUd7e/Snbfakr
 b+6w==
X-Gm-Message-State: AJcUukcB4Kd47BdWttHhfZt8QMjo1OR1gP4yD8vxVDFwCgUsiCNfvUR5
 wblwNt84RmRF81mgwZfAQMVEhpU=
X-Google-Smtp-Source: ALg8bN7KdwgagvyEhnL6IBeiIpshjibXkfCtmAhpW1RlXZZ7D9Gr/cs8b211hHistqfaeW7HGKUTBQ==
X-Received: by 2002:a05:6808:34e:: with SMTP id
 j14mr9265226oie.32.1547224461065; 
 Fri, 11 Jan 2019 08:34:21 -0800 (PST)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net.
 [24.155.109.49])
 by smtp.gmail.com with ESMTPSA id 127sm36540155oid.36.2019.01.11.08.34.20
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Fri, 11 Jan 2019 08:34:20 -0800 (PST)
Date: Fri, 11 Jan 2019 10:34:20 -0600
From: Rob Herring <robh@kernel.org>
To: David Summers <beagleboard@davidjohnsummers.uk>
Subject: Re: [PATCHv2] Description of the realtek bluetooth device tree hooks
Message-ID: <20190111163420.GA20311@bogus>
References: <20181229115513.31153-1-beagleboard@davidjohnsummers.uk>
 <20190103163538.6575-1-beagleboard@davidjohnsummers.uk>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190103163538.6575-1-beagleboard@davidjohnsummers.uk>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190111_083422_167967_D3AC75EA 
X-CRM114-Status: GOOD (  22.68  )
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
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org, johan.hedberg@gmail.com,
 marcel@holtmann.org, linux-bluetooth@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Thu, Jan 03, 2019 at 04:35:37PM +0000, David Summers wrote:
> This adds the desrciption file that describes the hooks for the
> realtek bluetooth serial devices, as needed to refer to the interface
> in the device tree.

Please follow conventions for patch subjects. 'git log --oneline 
--no-merges -- path/to/file' usually gives a good clue. In this case, 
something like:

dt-bindings: net: Add Realtek serial bluetooth binding

> 
> Signed-off-by: David Summers <beagleboard@davidjohnsummers.uk>
> ---
>  .../bindings/net/realtek-bluetooth-serial.txt | 28 +++++++++++++++++++
>  1 file changed, 28 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/net/realtek-bluetooth-serial.txt
> 
> diff --git a/Documentation/devicetree/bindings/net/realtek-bluetooth-serial.txt b/Documentation/devicetree/bindings/net/realtek-bluetooth-serial.txt
> new file mode 100644
> index 000000000000..0aabca1fc002
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/net/realtek-bluetooth-serial.txt
> @@ -0,0 +1,28 @@
> +Realtek bluetooth devices connected via a UART
> +
> +- compatible: should be "realtek,<name>-bluetooth"
> +  except for "realtek,trl8761atv" - which only has a serial bluetooth connection
> +       "realtek,rtl8723as-bluetooth"
> +       "realtek,rtl8723bs-bluetooth"
> +       "realtek,rtl8723ds-bluetooth"
> +       "realtek,rtl8761atv"
> +       "realtek,rtl8821as-bluetooth"
> +       "realtek,rtl8821cs-bluetooth"
> +       "realtek,rtl8822bs-bluetooth"

Arguably, '-bluetooth' is not necessary as nothing else is attached to 
the serial port. At least shorten it to '-bt'.

> +- These device are bluetooth devices, that connect via a uart

s/device/devices/

> +- all devices (except for rtl8761atv) are also wifi devices, this is connected
> +  seperatly via sdio - and is not covered by this compatible node

Really, this should be up above the property list in a description of 
the device(s).

> +- ideally these will be referenced in a device tree serial node via serdev

Not ideally, but it is only valid for this to be a child of a UART.

serdev is a kernel thing, and shouldn't be part of the binding doc.

> + http://events17.linuxfoundation.org/sites/events/files/slides/serdev-elce-2017-2.pdf

Useful, but again, not part of this binding.

There's no interrupts, GPIO control lines, power supplies, etc. for 
these chips? The binding should be complete even if your platform 
doesn't need these.

> +
> +Example:
> +
> +&uart0 {
> +	status = "okay";

Don't show status in examples.

> +       	pinctrl-0 = <&uart0_xfer>, <&uart0_cts>;
> +       	bluetooth {
> +               	  compatible = "realtek,rtl8723bs-bluetooth";
> +       	};

Mixed tabs and spaces. Use tabs.

> +};
> +
> +this ensures that the bluetooth device is tied to the correct uart
> -- 
> beagleboard@davidjohnsummers.uk
> 

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
