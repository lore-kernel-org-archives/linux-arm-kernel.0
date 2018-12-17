Return-Path: <SRS0=FFYW=O2=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E420C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 22:15:21 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1C92721783
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 22:15:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="YduCrdCS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1C92721783
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=rC38jzCzL7kbasevtY0uMwCgevK7dPDg7NlxWF1i4PY=; b=YduCrdCSKRTOq3
	aBEZjlTLPuSL1+W84PE09/o38kDu8uSU5izVG6/ZBB6in4XsnlOHsFKzvC5K2nscSgSlK2ms2eYGG
	SueoBdX6CjA96vm0FPyrR//rWHaR8Nv/W4GOk1jsHO66MZRLeqpOn8Hcx/yieCKV40SUnDX0nW5fU
	dCqtq8ur1jgAAudera3aN4RyXO/ob48PNQvd4a6zFwVDIBpFPhFdb2sWLG+dleHHEDUjdpPFciYZx
	CSjXFdrRd/WItQ/vEkV9LiDKS9KYhCnPEQdFcyjSyaTmy0WNJCuL2azdIFd7TyVzZjHYmMfYBXdK1
	A00SQXNadE3eFkoLtwVQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gZ1AU-00073D-AR; Mon, 17 Dec 2018 22:15:18 +0000
Received: from mail-oi1-f194.google.com ([209.85.167.194])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gZ1AQ-0005yt-D9
 for linux-arm-kernel@lists.infradead.org; Mon, 17 Dec 2018 22:15:16 +0000
Received: by mail-oi1-f194.google.com with SMTP id j21so330666oii.8
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 17 Dec 2018 14:15:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=J/B8oun+KHAVhOm1kX/D4B4VD+5LS8jbpKrt1ggcc4Y=;
 b=j0OBx4oycrCvriYwh2aHRkNfrL3Q2Y22ZzG9KUpXuUTqJ2Xdegb/bq+uPeM8yOcahn
 GP0KujOVUa0FKy/wIgTosJLLPyGiR0IuUAJYDT30DE81OyDOPhr5kQ8Cobq4JlzhY3mX
 yLNsJQMiD9IJy0ftCglnu51bWGObf3CPo6CjqqLBfj4vDUQZv7zvLBDMqSkUU2Wy1ji+
 RX9HUSqq9+Qwa9kvfuC7bDOKnun/mQME6vVQRiE1okGYy1+FaVW03JdSh0qhxmZiJLqe
 hCvHvsD0WHAVpcMJr0ui9dnTtaTAnc3uPZd3VwPMG4Var741jaPu1RT0cHWH3SO+h+nu
 xbyg==
X-Gm-Message-State: AA+aEWaPnoQBrunA/nMas5iNJR9fBRi42jhBIeEPVEyDTNCZkjqF2lU5
 ugtjs2NI+smRQtqH6uR8wwL3+K8=
X-Google-Smtp-Source: AFSGD/XEh/ctX59reAbXLa6kDM4mVw4TyvR1QFIX2TNEylkKFSKcFStRZfVW273MC1u4mlg2F6da7w==
X-Received: by 2002:aca:c0c6:: with SMTP id q189mr6138964oif.226.1545084903536; 
 Mon, 17 Dec 2018 14:15:03 -0800 (PST)
Received: from localhost (cpe-70-114-214-127.austin.res.rr.com.
 [70.114.214.127])
 by smtp.gmail.com with ESMTPSA id x92sm8386076ota.55.2018.12.17.14.15.02
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Mon, 17 Dec 2018 14:15:02 -0800 (PST)
Date: Mon, 17 Dec 2018 16:15:02 -0600
From: Rob Herring <robh@kernel.org>
To: Philippe Schenker <dev@pschenker.ch>
Subject: Re: [PATCH v4 6/8] iio: adc: add STMPE ADC devicetree bindings
Message-ID: <20181217221502.GA30121@bogus>
References: <20181212130649.15146-1-dev@pschenker.ch>
 <20181212130649.15146-6-dev@pschenker.ch>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20181212130649.15146-6-dev@pschenker.ch>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181217_141514_452513_62401500 
X-CRM114-Status: GOOD (  27.29  )
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
 linux-iio@vger.kernel.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>,
 Alexandre Torgue <alexandre.torgue@st.com>, marcel.ziswiler@toradex.com,
 Peter Meerwald-Stadler <pmeerw@pmeerw.net>, linux-input@vger.kernel.org,
 linux-kernel@vger.kernel.org, stefan@agner.ch,
 Maxime Coquelin <mcoquelin.stm32@gmail.com>,
 Philippe Schenker <philippe.schenker@toradex.com>, thierry.reding@gmail.com,
 linux-arm-kernel@lists.infradead.org,
 Max Krummenacher <max.krummenacher@toradex.com>,
 Hartmut Knaack <knaack.h@gmx.de>, Lee Jones <lee.jones@linaro.org>,
 linux-stm32@st-md-mailman.stormreply.com, jic23@kernel.org,
 Lars-Peter Clausen <lars@metafoo.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Wed, Dec 12, 2018 at 02:06:47PM +0100, Philippe Schenker wrote:
> From: Stefan Agner <stefan@agner.ch>
> 
> This adds the devicetree bindings for the STMPE ADC. And corrects a
> typo in st,sample-time it is rather "6 -> 124 clocks" according
> to the datasheet and not 144.
> 
> Signed-off-by: Stefan Agner <stefan@agner.ch>
> Signed-off-by: Max Krummenacher <max.krummenacher@toradex.com>
> Signed-off-by: Philippe Schenker <philippe.schenker@toradex.com>
> ---
> 
> Changes in v4:
>  - Put reformatting in a separate precursor patch.
> 
> Changes in v3:
>  - Reformatted documentation for touchscreen to use tabs and have a better
>    overview of the settings.
>  - Added note which adc-settings will take precedence.
>  - changed typo in sample-time setting from 144 clocks to 124 clocks, as stated
>    in the datasheet.
> 
> Changes in v2:
>  - Moved the bindings for ADC to the overlying mfd.
>  - Reformatted for better readability
> 
>  .../devicetree/bindings/iio/adc/stmpe-adc.txt | 21 ++++++++++++
>  .../bindings/input/touchscreen/stmpe.txt      | 32 +++++++++----------
>  .../devicetree/bindings/mfd/stmpe.txt         | 14 ++++++++
>  3 files changed, 51 insertions(+), 16 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/iio/adc/stmpe-adc.txt
> 
> diff --git a/Documentation/devicetree/bindings/iio/adc/stmpe-adc.txt b/Documentation/devicetree/bindings/iio/adc/stmpe-adc.txt
> new file mode 100644
> index 000000000000..480e66422625
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/adc/stmpe-adc.txt
> @@ -0,0 +1,21 @@
> +STMPE ADC driver
> +----------------
> +
> +Required properties:
> + - compatible: "st,stmpe-adc"
> +
> +Optional properties:
> +Note that the ADC is shared with the STMPE touchscreen. ADC related settings
> +have to be done in the mfd.
> +- st,norequest-mask: bitmask specifying which ADC channels should _not_ be
> +  requestable due to different usage (e.g. touch)
> +
> +Node name must be stmpe_adc and should be child node of stmpe node to
> +which it belongs.
> +
> +Example:
> +
> +	stmpe_adc {
> +		compatible = "st,stmpe-adc";
> +		st,norequest-mask = <0x0F>; /* dont use ADC CH3-0 */
> +	};
> diff --git a/Documentation/devicetree/bindings/input/touchscreen/stmpe.txt b/Documentation/devicetree/bindings/input/touchscreen/stmpe.txt
> index 1d3f84308142..8e2b240882fa 100644
> --- a/Documentation/devicetree/bindings/input/touchscreen/stmpe.txt
> +++ b/Documentation/devicetree/bindings/input/touchscreen/stmpe.txt
> @@ -5,18 +5,6 @@ Required properties:
>   - compatible: "st,stmpe-ts"
>  
>  Optional properties:
> -- st,sample-time	: ADC conversion time in number of clock.
> -				0 -> 36 clocks		4 -> 80 clocks (recommended)
> -				1 -> 44 clocks		5 -> 96 clocks
> -				2 -> 56 clocks		6 -> 144 clocks
> -				3 -> 64 clocks
> -- st,mod-12b		: ADC Bit mode
> -				0 -> 10bit ADC		1 -> 12bit ADC
> -- st,ref-sel		: ADC reference source
> -				0 -> internal		1 -> external
> -- st,adc-freq		: ADC Clock speed
> -				0 -> 1.625 MHz		2 || 3 -> 6.5 MHz
> -				1 -> 3.25 MHz
>  - st,ave-ctrl		: Sample average control
>  				0 -> 1 sample
>  				1 -> 2 samples
> @@ -40,17 +28,29 @@ Optional properties:
>  				0 -> 20 mA (typical 35mA max)
>  				1 -> 50 mA (typical 80 mA max)
>  
> +Optional properties common with MFD (deprecated):
> + - st,sample-time	: ADC conversion time in number of clock.
> +				0 -> 36 clocks		4 -> 80 clocks (recommended)
> +				1 -> 44 clocks		5 -> 96 clocks
> +				2 -> 56 clocks		6 -> 124 clocks
> +				3 -> 64 clocks
> + - st,mod-12b		: ADC Bit mode
> +				0 -> 10bit ADC		1 -> 12bit ADC
> + - st,ref-sel		: ADC reference source
> +				0 -> internal		1 -> external
> + - st,adc-freq		: ADC Clock speed
> +				0 -> 1.625 MHz		2 || 3 -> 6.5 MHz
> +				1 -> 3.25 MHz
> +
>  Node name must be stmpe_touchscreen and should be child node of stmpe node to
>  which it belongs.
>  
> +Note that common ADC settings of stmpe_touchscreen will take precedence.

This isn't clear. The parent or child properties take precedence?

> +
>  Example:
>  
>  	stmpe_touchscreen {
>  		compatible = "st,stmpe-ts";
> -		st,sample-time = <4>;
> -		st,mod-12b = <1>;
> -		st,ref-sel = <0>;
> -		st,adc-freq = <1>;

It would be nice to see an example with both ADC and touchscreen.

>  		st,ave-ctrl = <1>;
>  		st,touch-det-delay = <2>;
>  		st,settling = <2>;
> diff --git a/Documentation/devicetree/bindings/mfd/stmpe.txt b/Documentation/devicetree/bindings/mfd/stmpe.txt
> index a46e7177195d..d4408a417193 100644
> --- a/Documentation/devicetree/bindings/mfd/stmpe.txt
> +++ b/Documentation/devicetree/bindings/mfd/stmpe.txt
> @@ -14,6 +14,20 @@ Optional properties:
>   - st,autosleep-timeout		: Valid entries (ms); 4, 16, 32, 64, 128, 256, 512 and 1024
>   - irq-gpio			: If present, which GPIO to use for event IRQ
>  
> +Optional properties for devices with touch and ADC (STMPE811|STMPE610):
> + - st,sample-time		: ADC conversion time in number of clock.
> +					0 -> 36 clocks		4 -> 80 clocks (recommended)
> +					1 -> 44 clocks		5 -> 96 clocks
> +					2 -> 56 clocks		6 -> 124 clocks
> +					3 -> 64 clocks
> + - st,mod-12b			: ADC Bit mode
> +					0 -> 10bit ADC		1 -> 12bit ADC
> + - st,ref-sel			: ADC reference source
> +					0 -> internal		1 -> external
> + - st,adc-freq			: ADC Clock speed
> +					0 -> 1.625 MHz		2 || 3 -> 6.5 MHz
> +					1 -> 3.25 MHz
> +
>  Example:
>  
>  	stmpe1601: stmpe1601@40 {
> -- 
> 2.19.2
> 

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
