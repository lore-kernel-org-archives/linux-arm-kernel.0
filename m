Return-Path: <SRS0=FFYW=O2=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_MUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94108C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 22:07:05 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5FBF521473
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 22:07:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="UOkuv5tR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5FBF521473
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Y/huOotorFoMX7o7J+2bgSrCK/z+H/BkKWIQD3aOwEQ=; b=UOkuv5tRykvh/X
	LdMFbQNiQRK+c/n9CFB/3Vj30YVrLOloYdsawQomm17R9sqtjtB9dkZXnAEM6/kYq1aQ5iFmmH+1F
	QoVitzU1tRuzkzdNntQ1fdjFme6QOOVv4p4Ba3Q2SELPZytdEnUkLK6J+1FdqtLP5PsEuApg4eRlB
	GNjFtypFsnJMcv0hlE7tL7DfF2vc8DC7FktvBD/Cc5l5qmphJ1PSzxX4XdYvjl/QXhGkJi3AsDTwg
	cDeG78krm4axjCFwKw7Pw82nvML34xhohfvx1PivehKAx4tADunEVniiOHvT9NYT9g3B4p3jkhxfJ
	VNTtQ6GQnKugyk1kRNZw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gZ12S-0003eU-0m; Mon, 17 Dec 2018 22:07:00 +0000
Received: from mail-oi1-f194.google.com ([209.85.167.194])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gZ12O-0003dM-CP
 for linux-arm-kernel@lists.infradead.org; Mon, 17 Dec 2018 22:06:57 +0000
Received: by mail-oi1-f194.google.com with SMTP id w13so308368oiw.9
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 17 Dec 2018 14:06:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=lsrVI+UQqYetR7FXHFIVqEUDCf1xzSqN+2Xw2fIvErA=;
 b=hTT8qYcwA0BlgYH14yvnfX0FMbnKOo3vpYUENhkksXdAbXqHeZZA9hrciBIP8LQ6Jo
 xDPwVBj1jc81i+1UuTIWChZq9iTXfYFKTthMNQnXhNtp2qF2zDN1v6bmQNh6DDmWasES
 j4FGKinuzGZm0ONStZeeDchWreCfLpkEY+1yleZ4jUmINtTh7hPGg0pdUA8jk6Xeem/T
 Q+HHZrW8l86L0fwh5bSJtN0cpel7zNCvw6OpA18nbp2T2qapF9+NY/rxRsQf7DgL7rmC
 OD3a3lOe9mQF9YVXjbe6fqbtDTroXVth8m0xQHfet94aEUa94IMfi50dt4WuV1qzu6nY
 fC9A==
X-Gm-Message-State: AA+aEWYCNCBWY7NRdvu2dfcFgRmLIVtgpZWOWDaCTCFa/we/q6Illhql
 cyAn4S3DxEwr+HZqJlUN7Duvwys=
X-Google-Smtp-Source: AFSGD/Vv14Lft5S8CMIfN78Hgsga270CLdVKj/7cJ4t8dKFx7y6UCDG0DSz5dwvdbyjB+nyxnQYV+A==
X-Received: by 2002:aca:f553:: with SMTP id t80mr6677458oih.358.1545084404983; 
 Mon, 17 Dec 2018 14:06:44 -0800 (PST)
Received: from localhost (cpe-70-114-214-127.austin.res.rr.com.
 [70.114.214.127])
 by smtp.gmail.com with ESMTPSA id v1sm6659324otq.80.2018.12.17.14.06.44
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Mon, 17 Dec 2018 14:06:44 -0800 (PST)
Date: Mon, 17 Dec 2018 16:06:43 -0600
From: Rob Herring <robh@kernel.org>
To: Philippe Schenker <dev@pschenker.ch>
Subject: Re: [PATCH v4 1/8] dt-bindings: stmpe: reformatting parameter list
 and use tabs only
Message-ID: <20181217220643.GA26243@bogus>
References: <20181212130649.15146-1-dev@pschenker.ch>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20181212130649.15146-1-dev@pschenker.ch>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181217_140656_424649_829293BA 
X-CRM114-Status: GOOD (  22.98  )
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
 Alexandre Torgue <alexandre.torgue@st.com>, marcel.ziswiler@toradex.com,
 Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-kernel@vger.kernel.org,
 stefan@agner.ch, Maxime Coquelin <mcoquelin.stm32@gmail.com>,
 Philippe Schenker <philippe.schenker@toradex.com>, thierry.reding@gmail.com,
 linux-arm-kernel@lists.infradead.org,
 Max Krummenacher <max.krummenacher@toradex.com>, linux-input@vger.kernel.org,
 Lee Jones <lee.jones@linaro.org>, linux-stm32@st-md-mailman.stormreply.com,
 jic23@kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Wed, Dec 12, 2018 at 02:06:42PM +0100, Philippe Schenker wrote:
> This patch reformats the parameter list for stmpe device in a
> table-style so it is more clear to read.
> 
> Signed-off-by: Philippe Schenker <philippe.schenker@toradex.com>

Need to fix the author and S-o-b emails to match.

> ---
> 
> Changes in v4:
>  - New separate precursor patch for holding reformatting
> 
> Changes in v3: None
> Changes in v2: None
> 
>  .../bindings/input/touchscreen/stmpe.txt      | 52 ++++++++++++-------
>  .../devicetree/bindings/mfd/stmpe.txt         | 14 ++---
>  2 files changed, 41 insertions(+), 25 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/input/touchscreen/stmpe.txt b/Documentation/devicetree/bindings/input/touchscreen/stmpe.txt
> index 127baa31a77a..1d3f84308142 100644
> --- a/Documentation/devicetree/bindings/input/touchscreen/stmpe.txt
> +++ b/Documentation/devicetree/bindings/input/touchscreen/stmpe.txt
> @@ -5,24 +5,40 @@ Required properties:
>   - compatible: "st,stmpe-ts"
>  
>  Optional properties:
> -- st,sample-time: ADC converstion time in number of clock.  (0 -> 36 clocks, 1 ->
> -  44 clocks, 2 -> 56 clocks, 3 -> 64 clocks, 4 -> 80 clocks, 5 -> 96 clocks, 6
> -  -> 144 clocks), recommended is 4.
> -- st,mod-12b: ADC Bit mode (0 -> 10bit ADC, 1 -> 12bit ADC)
> -- st,ref-sel: ADC reference source (0 -> internal reference, 1 -> external
> -  reference)
> -- st,adc-freq: ADC Clock speed (0 -> 1.625 MHz, 1 -> 3.25 MHz, 2 || 3 -> 6.5 MHz)
> -- st,ave-ctrl: Sample average control (0 -> 1 sample, 1 -> 2 samples, 2 -> 4
> -  samples, 3 -> 8 samples)
> -- st,touch-det-delay: Touch detect interrupt delay (0 -> 10 us, 1 -> 50 us, 2 ->
> -  100 us, 3 -> 500 us, 4-> 1 ms, 5 -> 5 ms, 6 -> 10 ms, 7 -> 50 ms) recommended
> -  is 3
> -- st,settling: Panel driver settling time (0 -> 10 us, 1 -> 100 us, 2 -> 500 us, 3
> -  -> 1 ms, 4 -> 5 ms, 5 -> 10 ms, 6 for 50 ms, 7 -> 100 ms) recommended is 2
> -- st,fraction-z: Length of the fractional part in z (fraction-z ([0..7]) = Count of
> -  the fractional part) recommended is 7
> -- st,i-drive: current limit value of the touchscreen drivers (0 -> 20 mA typical 35
> -  mA max, 1 -> 50 mA typical 80 mA max)
> +- st,sample-time	: ADC conversion time in number of clock.
> +				0 -> 36 clocks		4 -> 80 clocks (recommended)
> +				1 -> 44 clocks		5 -> 96 clocks
> +				2 -> 56 clocks		6 -> 144 clocks
> +				3 -> 64 clocks

Just make this a 1 column list

> +- st,mod-12b		: ADC Bit mode
> +				0 -> 10bit ADC		1 -> 12bit ADC
> +- st,ref-sel		: ADC reference source
> +				0 -> internal		1 -> external
> +- st,adc-freq		: ADC Clock speed
> +				0 -> 1.625 MHz		2 || 3 -> 6.5 MHz
> +				1 -> 3.25 MHz
> +- st,ave-ctrl		: Sample average control
> +				0 -> 1 sample
> +				1 -> 2 samples
> +				2 -> 4 samples
> +				3 -> 8 samples
> +- st,touch-det-delay	: Touch detect interrupt delay (recommended is 3)
> +				0 -> 10 us		5 -> 5 ms
> +				1 -> 50 us		6 -> 10 ms
> +				2 -> 100 us		7 -> 50 ms
> +				3 -> 500 us
> +				4 -> 1 ms
> +- st,settling		: Panel driver settling time (recommended is 2)
> +				0 -> 10 us		5 -> 10 ms
> +				1 -> 100 us		6 for 50 ms
> +				2 -> 500 us		7 -> 100 ms
> +				3 -> 1 ms
> +				4 -> 5 ms
> +- st,fraction-z		: Length of the fractional part in z (recommended is 7)
> +			  (fraction-z ([0..7]) = Count of the fractional part)
> +- st,i-drive		: current limit value of the touchscreen drivers
> +				0 -> 20 mA (typical 35mA max)
> +				1 -> 50 mA (typical 80 mA max)
>  
>  Node name must be stmpe_touchscreen and should be child node of stmpe node to
>  which it belongs.
> diff --git a/Documentation/devicetree/bindings/mfd/stmpe.txt b/Documentation/devicetree/bindings/mfd/stmpe.txt
> index c797c05cd3c2..a46e7177195d 100644
> --- a/Documentation/devicetree/bindings/mfd/stmpe.txt
> +++ b/Documentation/devicetree/bindings/mfd/stmpe.txt
> @@ -4,15 +4,15 @@ STMPE is an MFD device which may expose the following inbuilt devices: gpio,
>  keypad, touchscreen, adc, pwm, rotator.
>  
>  Required properties:
> - - compatible                   : "st,stmpe[610|801|811|1600|1601|2401|2403]"
> - - reg                          : I2C/SPI address of the device
> + - compatible			: "st,stmpe[610|801|811|1600|1601|2401|2403]"
> + - reg				: I2C/SPI address of the device
>  
>  Optional properties:
> - - interrupts                   : The interrupt outputs from the controller
> - - interrupt-controller         : Marks the device node as an interrupt controller
> - - wakeup-source                : Marks the input device as wakable
> - - st,autosleep-timeout         : Valid entries (ms); 4, 16, 32, 64, 128, 256, 512 and 1024
> - - irq-gpio                     : If present, which GPIO to use for event IRQ
> + - interrupts			: The interrupt outputs from the controller
> + - interrupt-controller		: Marks the device node as an interrupt controller
> + - wakeup-source		: Marks the input device as wakable
> + - st,autosleep-timeout		: Valid entries (ms); 4, 16, 32, 64, 128, 256, 512 and 1024
> + - irq-gpio			: If present, which GPIO to use for event IRQ
>  
>  Example:
>  
> -- 
> 2.19.2
> 

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
