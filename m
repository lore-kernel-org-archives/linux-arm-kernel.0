Return-Path: <SRS0=JyYb=QI=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0D51C169C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 02:54:27 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C161420863
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 02:54:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="VLpI5K2Q";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="p7BWOEbn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C161420863
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=8DQ85w6H4WgBoUfG3FGTMi4K41bnfpfXRAJMT0pWbiM=; b=VLpI5K2QDHK5rh
	hJzzUclZN8hKy6B2UuZGPS8FGHQJkA40nbWRAI308VkvPPpOS84R5WK6s7/aaND8gCYjIjJ8Ty3jT
	vjXYouIiXurk7dzlxIy1oN/bJ8voEh61i5Layynd/HzJPYd3gS0hMRAAj/iJC3wPJw+g1m1lMCY/5
	jyzgZOOCW1ffbcL34vD2NOVeMwlfM2Y9t4pB6pVZ9LEY5grsxznf0PR37HVa373QykrVtNp7kBarZ
	P1F8tI8zMW8wOPSkoOvIFPrWWZsnLluxkoAgkp/Nk67bm4B8RNmVxWBpGvn0tbqwJm9CNzB+nnLtp
	rAAHamz7LTNdOJVi5QHg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gpOyG-0004ew-2l; Fri, 01 Feb 2019 02:54:24 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gpOyC-0004eS-N7; Fri, 01 Feb 2019 02:54:22 +0000
Received: from dragon (61-216-91-114.HINET-IP.hinet.net [61.216.91.114])
 (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 6EB6720863;
 Fri,  1 Feb 2019 02:54:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1548989659;
 bh=8RCVc/UR6RQLUvQQQztdVUBfDTbSQz/Ra9DMj49JNqU=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=p7BWOEbn/9OIQs+CILDKvZ8zwagUsVRXIQWJ/Q06cwIG+Ggq95/AExJS/4GLxw5Th
 NEenY/+eKCv73QR11RpDeI3goTknhZo5yphL90+/05TgFjLoFN2tPkKeWfVRdduUaW
 PpdtofQUD6W53M35qG+VpOcyh3zlRG//VnAPhvac=
Date: Fri, 1 Feb 2019 10:54:07 +0800
From: Shawn Guo <shawnguo@kernel.org>
To: Yogesh Narayan Gaur <yogeshnarayan.gaur@nxp.com>
Subject: Re: [PATCH v8 3/5] arm64: dts: lx2160a: add FlexSPI node property
Message-ID: <20190201025405.GA19882@dragon>
References: <1547553487-9936-1-git-send-email-yogeshnarayan.gaur@nxp.com>
 <1547553487-9936-4-git-send-email-yogeshnarayan.gaur@nxp.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1547553487-9936-4-git-send-email-yogeshnarayan.gaur@nxp.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190131_185420_790753_FD77A5B5 
X-CRM114-Status: GOOD (  16.20  )
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
Cc: "mark.rutland@arm.com" <mark.rutland@arm.com>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "bbrezillon@kernel.org" <bbrezillon@kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "frieder.schrempf@kontron.de" <frieder.schrempf@kontron.de>,
 "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
 "marek.vasut@gmail.com" <marek.vasut@gmail.com>,
 "broonie@kernel.org" <broonie@kernel.org>,
 "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
 "computersforpeace@gmail.com" <computersforpeace@gmail.com>,
 "robh@kernel.org" <robh@kernel.org>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Tue, Jan 15, 2019 at 12:00:26PM +0000, Yogesh Narayan Gaur wrote:
> Add fspi node property for LX2160A SoC for FlexSPI driver.
> Property added for the FlexSPI controller and for the connected
> slave device for the LX2160ARDB target.
> This is having two SPI-NOR flash device, mt35xu512aba, connected
> at CS0 and CS1.
> 
> Signed-off-by: Yogesh Narayan Gaur <yogeshnarayan.gaur@nxp.com>
> ---
> Changes for v8:
> - None
> Changes for v7:
> - None
> Changes for v6:
> - None
> Changes for v5:
> - None
> Changes for v4:
> - Incorporated Rob review comments.
> Changes for v3:
> - None.
> Changes for v2:
> - Incorporated Shawn review comments.
> 
>  .../boot/dts/freescale/fsl-lx2160a-rdb.dts    | 22 +++++++++++++++++++
>  .../arm64/boot/dts/freescale/fsl-lx2160a.dtsi | 13 +++++++++++
>  2 files changed, 35 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/freescale/fsl-lx2160a-rdb.dts b/arch/arm64/boot/dts/freescale/fsl-lx2160a-rdb.dts
> index 6481e5f20e69..70658946fbbe 100644
> --- a/arch/arm64/boot/dts/freescale/fsl-lx2160a-rdb.dts
> +++ b/arch/arm64/boot/dts/freescale/fsl-lx2160a-rdb.dts
> @@ -50,6 +50,28 @@
>  	status = "okay";
>  };
>  
> +&fspi {
> +	status = "okay";
> +
> +	mt35xu512aba0: flash@0 {
> +		#address-cells = <1>;
> +		#size-cells = <1>;
> +		compatible = "spansion,m25p80";
> +		m25p,fast-read;
> +		spi-max-frequency = <50000000>;
> +		reg = <0>;
> +	};
> +
> +	mt35xu512aba1: flash@1 {
> +		#address-cells = <1>;
> +		#size-cells = <1>;
> +		compatible = "spansion,m25p80";
> +		m25p,fast-read;
> +		spi-max-frequency = <50000000>;
> +		reg = <1>;
> +	};
> +};
> +
>  &i2c0 {
>  	status = "okay";
>  
> diff --git a/arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi b/arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi
> index a79f5c1ea56d..e3ff86201f73 100644
> --- a/arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi
> +++ b/arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi
> @@ -762,5 +762,18 @@
>  				     <GIC_SPI 209 IRQ_TYPE_LEVEL_HIGH>;
>  			dma-coherent;
>  		};
> +
> +		fspi: spi@20c0000 {

To keep the nodes sorted in unit-address, it should go after
i2c@2070000.

> +			compatible = "nxp,lx2160a-fspi";
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +			reg = <0x0 0x20c0000 0x0 0x10000>,
> +				<0x0 0x20000000 0x0 0x10000000>;

I would align the indentation with the above.

> +			reg-names = "fspi_base", "fspi_mmap";
> +			interrupts = <0 25 0x4>; /* Level high type */

interrupts = <GIC_SPI 25 IRQ_TYPE_LEVEL_HIGH>; so that we can save the
comment there.

I fixed up all these small things and applied the patch.

Shawn

> +			clocks = <&clockgen 4 3>, <&clockgen 4 3>;
> +			clock-names = "fspi_en", "fspi";
> +			status = "disabled";
> +		};
>  	};
>  };
> -- 
> 2.17.1
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
