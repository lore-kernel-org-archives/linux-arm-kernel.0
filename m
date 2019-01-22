Return-Path: <SRS0=B2vk=P6=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3B8BC282C3
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 06:07:12 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9BD7120870
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 06:07:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="pJVc6JI+";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ppe9cX4z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9BD7120870
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=YZ8npzEz+U/8rNXTPLAtUHoR+cATJg9vxJQ/l7NYiQo=; b=pJVc6JI+njqcsG
	PZy86SfVk6CGp0JCQhnBba8CIVDAogTbIBFf2X/oD7/XUZTS1UImaWbTZS/ry+i69xhXClKWieiqQ
	eVMTIHbyGF9Bz8ZylWsgun4L236WFdxmbNjzJ77XuVQdrV4a9C77tTMG2kQBAyCwSyFKdd2+iTqkQ
	FDI7F9BFVpWpa0+OLRyr7PHfa/j3jw20WF21BRtv3B2JX/Eyuu3PURCqFjsRFeX6Tk71tUA+Ccwnd
	yH/Lnmw4R9aquVnc++824Unflv5hZo40E79U3xgCawebJj/anANKJYagc5hb+BJkheOkcIkq08sKl
	iINypRyprtUdaHY6byJA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1glpDI-0003Qf-PI; Tue, 22 Jan 2019 06:07:08 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1glpDD-0003Pv-UN
 for linux-arm-kernel@lists.infradead.org; Tue, 22 Jan 2019 06:07:07 +0000
Received: from dragon (61-216-91-114.HINET-IP.hinet.net [61.216.91.114])
 (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 86FF820870;
 Tue, 22 Jan 2019 06:07:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1548137223;
 bh=cKQLumwaKxiQYwkd6RZglmED5JtbfC3J0jYmqsrEcJ0=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=Ppe9cX4zlBbd5gk88g6JBU1RiGr5k/I80VTJh7Tw/AB60RkUsPW0ApWFpvBwSmVxP
 5HEFW3+GG/eey91fyXG2fRcsxOcEWcsHEH7O9aMQdamtWnQ9nKZtmMPxM3D3DEyd4/
 YyG2RYZmlQ1ItxFpqLwVTAJH06iLc2/mqlXKXnQE=
Date: Tue, 22 Jan 2019 14:06:25 +0800
From: Shawn Guo <shawnguo@kernel.org>
To: Fabio Estevam <festevam@gmail.com>
Subject: Re: [PATCH] ARM: dts: imx: Remove 'simple-bus' from anatop compatible
Message-ID: <20190122060624.GD19929@dragon>
References: <20190121202905.31224-1-festevam@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190121202905.31224-1-festevam@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190121_220704_005940_9512CF0A 
X-CRM114-Status: GOOD (  14.30  )
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
Cc: linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
 robh+dt@kernel.org, linux-imx@nxp.com, kernel@pengutronix.de
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Mon, Jan 21, 2019 at 06:29:05PM -0200, Fabio Estevam wrote:
> dtc gives the following warnings when building with W=1:
> 
> arch/arm/boot/dts/imx6qdl.dtsi:702.19-715.7: Warning (simple_bus_reg): /soc/aips-bus@2000000/anatop@20c8000/regulator-1p1: missing or empty reg/ranges property
> arch/arm/boot/dts/imx6qdl.dtsi:717.19-730.7: Warning (simple_bus_reg): /soc/aips-bus@2000000/anatop@20c8000/regulator-3p0: missing or empty reg/ranges property
> arch/arm/boot/dts/imx6qdl.dtsi:732.19-745.7: Warning (simple_bus_reg): /soc/aips-bus@2000000/anatop@20c8000/regulator-2p5: missing or empty reg/ranges property
> arch/arm/boot/dts/imx6qdl.dtsi:747.32-762.7: Warning (simple_bus_reg): /soc/aips-bus@2000000/anatop@20c8000/regulator-vddcore: missing or empty reg/ranges property
> arch/arm/boot/dts/imx6qdl.dtsi:764.29-779.7: Warning (simple_bus_reg): /soc/aips-bus@2000000/anatop@20c8000/regulator-vddpu: missing or empty reg/ranges property
> arch/arm/boot/dts/imx6qdl.dtsi:781.31-796.7: Warning (simple_bus_reg): /soc/aips-bus@2000000/anatop@20c8000/regulator-vddsoc: missing or empty reg/ranges property
> 
> Remove 'simple-bus' from the compatible list of anatop, since it is a
> regulator and thus should not be described as 'simple-bus'.

Will the child regulator devices still be populated by kernel?

Shawn

> 
> Signed-off-by: Fabio Estevam <festevam@gmail.com>
> ---
>  arch/arm/boot/dts/imx6qdl.dtsi | 2 +-
>  arch/arm/boot/dts/imx6sl.dtsi  | 2 +-
>  arch/arm/boot/dts/imx6sll.dtsi | 2 +-
>  arch/arm/boot/dts/imx6sx.dtsi  | 2 +-
>  arch/arm/boot/dts/imx6ul.dtsi  | 2 +-
>  arch/arm/boot/dts/imx7s.dtsi   | 2 +-
>  6 files changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/imx6qdl.dtsi b/arch/arm/boot/dts/imx6qdl.dtsi
> index fe17a3405edc..5b54f1bfa03d 100644
> --- a/arch/arm/boot/dts/imx6qdl.dtsi
> +++ b/arch/arm/boot/dts/imx6qdl.dtsi
> @@ -693,7 +693,7 @@
>  			};
>  
>  			anatop: anatop@20c8000 {
> -				compatible = "fsl,imx6q-anatop", "syscon", "simple-bus";
> +				compatible = "fsl,imx6q-anatop", "syscon";
>  				reg = <0x020c8000 0x1000>;
>  				interrupts = <0 49 IRQ_TYPE_LEVEL_HIGH>,
>  					     <0 54 IRQ_TYPE_LEVEL_HIGH>,
> diff --git a/arch/arm/boot/dts/imx6sl.dtsi b/arch/arm/boot/dts/imx6sl.dtsi
> index 4b4813f176cd..1bbcfcf6b2fc 100644
> --- a/arch/arm/boot/dts/imx6sl.dtsi
> +++ b/arch/arm/boot/dts/imx6sl.dtsi
> @@ -518,7 +518,7 @@
>  			anatop: anatop@20c8000 {
>  				compatible = "fsl,imx6sl-anatop",
>  					     "fsl,imx6q-anatop",
> -					     "syscon", "simple-bus";
> +					     "syscon";
>  				reg = <0x020c8000 0x1000>;
>  				interrupts = <0 49 IRQ_TYPE_LEVEL_HIGH>,
>  					     <0 54 IRQ_TYPE_LEVEL_HIGH>,
> diff --git a/arch/arm/boot/dts/imx6sll.dtsi b/arch/arm/boot/dts/imx6sll.dtsi
> index 62847c68330b..b2caf86dd9a9 100644
> --- a/arch/arm/boot/dts/imx6sll.dtsi
> +++ b/arch/arm/boot/dts/imx6sll.dtsi
> @@ -506,7 +506,7 @@
>  			anatop: anatop@20c8000 {
>  				compatible = "fsl,imx6sll-anatop",
>  					     "fsl,imx6q-anatop",
> -					     "syscon", "simple-bus";
> +					     "syscon";
>  				reg = <0x020c8000 0x4000>;
>  				interrupts = <GIC_SPI 49 IRQ_TYPE_LEVEL_HIGH>,
>  					     <GIC_SPI 54 IRQ_TYPE_LEVEL_HIGH>,
> diff --git a/arch/arm/boot/dts/imx6sx.dtsi b/arch/arm/boot/dts/imx6sx.dtsi
> index 5b16e65f7696..44b2824a0a3f 100644
> --- a/arch/arm/boot/dts/imx6sx.dtsi
> +++ b/arch/arm/boot/dts/imx6sx.dtsi
> @@ -594,7 +594,7 @@
>  
>  			anatop: anatop@20c8000 {
>  				compatible = "fsl,imx6sx-anatop", "fsl,imx6q-anatop",
> -					     "syscon", "simple-bus";
> +					     "syscon";
>  				reg = <0x020c8000 0x1000>;
>  				interrupts = <GIC_SPI 49 IRQ_TYPE_LEVEL_HIGH>,
>  					     <GIC_SPI 54 IRQ_TYPE_LEVEL_HIGH>,
> diff --git a/arch/arm/boot/dts/imx6ul.dtsi b/arch/arm/boot/dts/imx6ul.dtsi
> index 3282eed497ea..6916d8ea1abc 100644
> --- a/arch/arm/boot/dts/imx6ul.dtsi
> +++ b/arch/arm/boot/dts/imx6ul.dtsi
> @@ -557,7 +557,7 @@
>  
>  			anatop: anatop@20c8000 {
>  				compatible = "fsl,imx6ul-anatop", "fsl,imx6q-anatop",
> -					     "syscon", "simple-bus";
> +					     "syscon";
>  				reg = <0x020c8000 0x1000>;
>  				interrupts = <GIC_SPI 49 IRQ_TYPE_LEVEL_HIGH>,
>  					     <GIC_SPI 54 IRQ_TYPE_LEVEL_HIGH>,
> diff --git a/arch/arm/boot/dts/imx7s.dtsi b/arch/arm/boot/dts/imx7s.dtsi
> index 81fe18c0b7da..73fea5b16b6c 100644
> --- a/arch/arm/boot/dts/imx7s.dtsi
> +++ b/arch/arm/boot/dts/imx7s.dtsi
> @@ -519,7 +519,7 @@
>  
>  			anatop: anatop@30360000 {
>  				compatible = "fsl,imx7d-anatop", "fsl,imx6q-anatop",
> -					"syscon", "simple-bus";
> +					"syscon";
>  				reg = <0x30360000 0x10000>;
>  				interrupts = <GIC_SPI 49 IRQ_TYPE_LEVEL_HIGH>,
>  					<GIC_SPI 51 IRQ_TYPE_LEVEL_HIGH>;
> -- 
> 2.17.1
> 

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
