Return-Path: <SRS0=7SPH=QW=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7946C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 16:05:31 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A9F2721927
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 16:05:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="slebZRJE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A9F2721927
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=OL4Ul8KPBmpIFmHb5gJ1om2kVS2ITqy2dDdhpH/VlZo=; b=slebZRJEPuSlHI
	PMLN9PRdWG6cQna2C3NmSy3Mivet6/p5MSs7Vhz4KXCQ1dE4QbZlFO/yTNdgXtBipWLTLRWYry/K1
	XOk++RUx45eTbG08Meyg5IDNVJH7ffSNeERW/LwB+8mdgllxawCKUVgbojovTrqEFHpNeZM0Ui4tV
	IRPj4bnDdgPLOpax4ZuCMNEMuLHQhOM2hUTtTB9Zi48O9Do+cylo+T99P8qlcntVjl7zeFPU5HSHD
	Ubv0GT/4BpPY2oi7x5fIjM37ADYsyKVtsETubQ17AskuOlm8VeF+CIHvwdutcdRaSEGnvmkkTU32I
	l/l3HTC9ag3COpgIy3LA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gufzT-0007KL-H7; Fri, 15 Feb 2019 16:05:27 +0000
Received: from mail-lf1-f68.google.com ([209.85.167.68])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gufz9-00068l-WD; Fri, 15 Feb 2019 16:05:13 +0000
Received: by mail-lf1-f68.google.com with SMTP id h10so7337917lfc.12;
 Fri, 15 Feb 2019 08:05:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=pvVSU+OeBtnbLINS2fqQeebEh/Lf+PMY28nuMnUdYR0=;
 b=E4JWJTs0BcPGQvR2bQ3CCSpfNhvjJ9kuDF/tN2ZVSzkUzNYQmtZFPf24jg8uL1Z4dc
 NlV8oTUKMKheitPOXbmFTFLoQ3DfCguYnCGl82bNc9gBjQjLTZnDto6EYO5eRPNKPCWi
 PVxMLWMBFxcxKX9Z32dFFeU8afMNseMOW4xjg2+BKLzz6LL+RG++2WlIg2mNMM4zr6nF
 EJwoCaShPJE+B4AuIansx3uTw3J+9CGow7vom1xz1J5/HyHA03vCJq6RgmjMLB8LK/Ge
 Tx3O54a1a5pMVA0t0sxmTR/6XUuzXyQNfqhiYz8tHyA75IEaF6Jo4X9HK0gB3erTgqMh
 99ZA==
X-Gm-Message-State: AHQUAuYLBnBLjxBXJXOGLyZtEtBL0fgaI2a7J7dN8g60ljqfg9fLuF5S
 /9VGkphRLe7xKr1d6Bs4UT0=
X-Google-Smtp-Source: AHgI3IZRcnlB46Fnw+lqoINS7IG2dpHY6TaBaBqVmAUpJPIafA96D5LXIxG+4kwQCsRiLn251kDSgQ==
X-Received: by 2002:a19:5611:: with SMTP id k17mr5705165lfb.168.1550246705884; 
 Fri, 15 Feb 2019 08:05:05 -0800 (PST)
Received: from xi.terra ([85.230.190.116])
 by smtp.gmail.com with ESMTPSA id f10-v6sm1298296ljc.31.2019.02.15.08.05.04
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 15 Feb 2019 08:05:04 -0800 (PST)
Received: from johan by xi.terra with local (Exim 4.91)
 (envelope-from <johan@kernel.org>)
 id 1gufyz-0000qc-Eh; Fri, 15 Feb 2019 17:04:57 +0100
Date: Fri, 15 Feb 2019 17:04:57 +0100
From: Johan Hovold <johan@kernel.org>
To: Loys Ollivier <lollivier@baylibre.com>
Subject: Re: [PATCH v4 2/4] dt-bindings: gnss: add mediatek binding
Message-ID: <20190215160457.GO28278@localhost>
References: <1550070569-18588-1-git-send-email-lollivier@baylibre.com>
 <1550070569-18588-3-git-send-email-lollivier@baylibre.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1550070569-18588-3-git-send-email-lollivier@baylibre.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190215_080508_364017_1555920E 
X-CRM114-Status: GOOD (  16.53  )
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
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
 Kevin Hilman <khilman@baylibre.com>, Johan Hovold <johan@kernel.org>,
 linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
 linux-mediatek@lists.infradead.org, linux-amlogic@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Wed, Feb 13, 2019 at 04:09:27PM +0100, Loys Ollivier wrote:
> Add binding for Mediatek-based GNSS receivers.
> 
> Signed-off-by: Loys Ollivier <lollivier@baylibre.com>
> ---
> v4:
> Use standard names for reset-gpios and gnss-fix-gpios
> s/an/a UART
> 
> v3:
> Removed the I2C and SPI interfaces references.
> Removed the "mediatek,mt3339" compatible line.
> Added the optional propertied (reset, fix)
> Added the pin names for the optional properties.
> 
> v2:
> Renamed bindings from Globaltop/gtop to Mediatek/mtk.
> Moved current-speed as an optional propertie.
> Removed the status line in the example.
> Added "mediatek,mt3339" compatible.
> 
>  .../devicetree/bindings/gnss/mediatek.txt          | 37 ++++++++++++++++++++++
>  1 file changed, 37 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/gnss/mediatek.txt
> 
> diff --git a/Documentation/devicetree/bindings/gnss/mediatek.txt b/Documentation/devicetree/bindings/gnss/mediatek.txt
> new file mode 100644
> index 000000000000..12283d429baa
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/gnss/mediatek.txt
> @@ -0,0 +1,37 @@
> +Mediatek-based GNSS Receiver DT binding
> +
> +Mediatek chipsets are used in GNSS-receiver modules produced by several
> +vendors and can use a UART interface.
> +
> +Please see Documentation/devicetree/bindings/gnss/gnss.txt for generic
> +properties.
> +
> +Required properties:
> +
> +- compatible	: Must be
> +
> +			"globaltop,pa6h"
> +
> +- vcc-supply	: Main voltage regulator (pin name: VCC)
> +
> +Optional properties:
> +
> +- current-speed		: Default UART baud rate
> +- gnss-fix-gpios	: GPIO used to determine device position fix state
> +			  (pin name: FIX, 3D_FIX)
> +- reset-gpios		: GPIO used to reset the device
> +  		  	  (pin name: RESET, NRESET)
> +- timepulse-gpios	: Time pulse GPIO (pin name: PPS1, 1PPS)
> +- v-bckp-supply		: Backup voltage regulator
> +  			  (pin name: VBAT, VBACKUP)

As we discussed, I changed this to "vbackup-supply" (here and in the
driver) before applying.

Note that git reported some whitespace errors above too (spaces before
tabs) that I fixed up. Not sure why checkpatch doesn't complain.

All now applied.

Thanks,
Johan

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
