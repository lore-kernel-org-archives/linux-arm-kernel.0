Return-Path: <SRS0=d92h=OZ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6633C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sun, 16 Dec 2018 12:29:16 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8DFDE21839
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sun, 16 Dec 2018 12:29:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="VuHmae5U";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="QZtk3W/i"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8DFDE21839
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=H+UbMVBbWk3T6lsnkhKZSIVFdO08/bxI3A+oRV1jVik=; b=VuHmae5U1ay4vc
	g3OYkb7JCxMSLJfswS/Tsk43fP1C5O3WSPbK3zYLr24VRy1ZQHZ7vPNM8AfPzQ2ycQs6Zcd6z5WVl
	yd80k+ta6rmBqRg0bWR5Hw4hS2c08hJXaGV0WMKqZAQSfTaBvfN6hDUGvh7wejQrF1Bg4R1NncG2W
	gavXi9mpMamRs5l5CbEABOUBaTq7NBTUxJMVSXk+vNPmlC5QawYtShmtnp81beDcm+QyFXX+JHAHx
	ow2LjRfqHthkwE+Lphx9zi+Mhn+jFW73olKFbgcXke7+mhPbUq9CJBeACo3BqfngqRDIb51iEpaPl
	YRcheDQHTvj27ehWjt5g==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gYVXm-0006zH-M1; Sun, 16 Dec 2018 12:29:14 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gYVXi-0006yN-VI
 for linux-arm-kernel@lists.infradead.org; Sun, 16 Dec 2018 12:29:12 +0000
Received: from archlinux (cpc91196-cmbg18-2-0-cust659.5-4.cable.virginm.net
 [81.96.234.148])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id E06C52084D;
 Sun, 16 Dec 2018 12:28:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1544963340;
 bh=vdeBvuvBHcge1WC3UbaIywqhesr5dL8W6evg0mC3/Gg=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=QZtk3W/ikFJxDu2xLblqAh9Xne7IGwdrzrPYEuqKHzB8AhcCDT+ttdOv98YYeCfpL
 GuszwhQ6PVW7uFraTqIHl8pc7FR2WTREGb2JK2hdBFlzGld901J0MFe02A7vxuiodw
 IdV4nr8i0cMgKvZNpyRSWWcbIKP/nRgc7UjQ0JBQ=
Date: Sun, 16 Dec 2018 12:28:53 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Philippe Schenker <dev@pschenker.ch>
Subject: Re: [PATCH v4 6/8] iio: adc: add STMPE ADC devicetree bindings
Message-ID: <20181216122853.31a12016@archlinux>
In-Reply-To: <20181212130649.15146-6-dev@pschenker.ch>
References: <20181212130649.15146-1-dev@pschenker.ch>
 <20181212130649.15146-6-dev@pschenker.ch>
X-Mailer: Claws Mail 3.17.2 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181216_042911_037573_BB0CE7F2 
X-CRM114-Status: GOOD (  23.41  )
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
 Philippe Schenker <philippe.schenker@toradex.com>, thierry.reding@gmail.com,
 linux-arm-kernel@lists.infradead.org,
 Max Krummenacher <max.krummenacher@toradex.com>,
 Hartmut Knaack <knaack.h@gmx.de>, Rob Herring <robh+dt@kernel.org>,
 Lee Jones <lee.jones@linaro.org>, linux-stm32@st-md-mailman.stormreply.com,
 Maxime Coquelin <mcoquelin.stm32@gmail.com>,
 Lars-Peter Clausen <lars@metafoo.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Wed, 12 Dec 2018 14:06:47 +0100
Philippe Schenker <dev@pschenker.ch> wrote:

> From: Stefan Agner <stefan@agner.ch>
> 
> This adds the devicetree bindings for the STMPE ADC. And corrects a
> typo in st,sample-time it is rather "6 -> 124 clocks" according
> to the datasheet and not 144.
> 
> Signed-off-by: Stefan Agner <stefan@agner.ch>
> Signed-off-by: Max Krummenacher <max.krummenacher@toradex.com>
> Signed-off-by: Philippe Schenker <philippe.schenker@toradex.com>

This still conflates a couple of different things but we can argue
about patch separation for ever so never mind.

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
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
> +
>  Example:
>  
>  	stmpe_touchscreen {
>  		compatible = "st,stmpe-ts";
> -		st,sample-time = <4>;
> -		st,mod-12b = <1>;
> -		st,ref-sel = <0>;
> -		st,adc-freq = <1>;
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


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
