Return-Path: <SRS0=y9BX=QM=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73CF4C282CC
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 18:37:33 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 45C662083B
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 18:37:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="k8SeXKVv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 45C662083B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=S4lCEk2HsHCjBkwvczkm05PqZKCAXsDx/XWHYwWi4g0=; b=k8SeXKVvJ3Y3C/
	zozSBdyhnPHIuv37EkZ70ZNGwWUldQvz4FCF5HKwYtWwq5v/EwNSZNL1Ry5fVDsu3kbY0FRug/R/g
	WOIsBz5sjuYu+GzloRPV8wnyP0mdGIv10OY07gAqCnuYnj+Lc+Z6JqbOWP/v52qlzRGOST+7L2Kby
	2849/Y1r0swdTn4HMLiRXB3aC57ElzqWH9w5uo8HkLV7hrlluQcJ7VDcH532kC7x8vB+RK6ejH2ia
	aJyYJSfxL2i+pwaW1rmkMBKReJoMUp3FZra/fjeNjACteQQ077PRxnx9CodL/wtUTS5iAHjbCkneI
	Y3hF01LqyhOuaNI+Q1kA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gr5b9-0006Qy-W0; Tue, 05 Feb 2019 18:37:31 +0000
Received: from mail-ot1-f65.google.com ([209.85.210.65])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gr5b6-0006Qa-FM
 for linux-arm-kernel@lists.infradead.org; Tue, 05 Feb 2019 18:37:30 +0000
Received: by mail-ot1-f65.google.com with SMTP id n8so7466309otl.6
 for <linux-arm-kernel@lists.infradead.org>;
 Tue, 05 Feb 2019 10:37:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=/3GgccrqzfwsWlMRLz9C2/7SM77w7+QFAHKsiEj95d4=;
 b=L+zXD/cIu58Sh1joaa8jNrQQyT+Z9DMyyzRd+gyNKr4+Hfe0+S5TzySo21rOCsqpYt
 8wxr/shJ5LOuYtPEG0Ws3jkJRJQ3Dfs/nl6juOv3WxJd97qaJMqlOoEzpPH3xajrXGUc
 KXa5rgVolab5Gz9SaHz/OW/LpxPRSxfdZB7Nw7w/a4SoiQ6Ip+O7Bb76XRAF2+rsmwex
 tRP8rCfEyfM5UxP3hC7f9A219tMg+c9vXI0CVVwGIYQXap5qqXpCqVacUssNZYLKVnQa
 m9jCYwpt1tc7HtsI/6gMKNWc6XlHlrSqtd/pCXgORn91dOZf5WO78t3IkzSBXZV7KZTM
 tksw==
X-Gm-Message-State: AHQUAuZ3wfbx+/+wEbAoDoSc+3Rf28Q8dG9v+3XVdw1mvN6KlX7tDGtT
 2V0TgmufWvyiYsCNYqIWSiYws9CSsT0=
X-Google-Smtp-Source: AHgI3Iale4brnV41O9YcRw7sNnMdK8h+Jc+QtBSm7+uOLFG1vThpzmy5H+hv2Bp5ZxmxSi92WuDJCw==
X-Received: by 2002:aca:e0c2:: with SMTP id x185mr3427676oig.185.1549391847419; 
 Tue, 05 Feb 2019 10:37:27 -0800 (PST)
Received: from mail-ot1-f45.google.com (mail-ot1-f45.google.com.
 [209.85.210.45])
 by smtp.gmail.com with ESMTPSA id r21sm8413743otk.18.2019.02.05.10.37.26
 for <linux-arm-kernel@lists.infradead.org>
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 05 Feb 2019 10:37:26 -0800 (PST)
Received: by mail-ot1-f45.google.com with SMTP id t5so7537849otk.1
 for <linux-arm-kernel@lists.infradead.org>;
 Tue, 05 Feb 2019 10:37:26 -0800 (PST)
X-Received: by 2002:aca:654a:: with SMTP id j10mr3159373oiw.301.1549391846220; 
 Tue, 05 Feb 2019 10:37:26 -0800 (PST)
MIME-Version: 1.0
References: <20190204141641.18272-1-pankaj.bansal@nxp.com>
In-Reply-To: <20190204141641.18272-1-pankaj.bansal@nxp.com>
From: Li Yang <leoyang.li@nxp.com>
Date: Tue, 5 Feb 2019 12:37:14 -0600
X-Gmail-Original-Message-ID: <CADRPPNSnPoEwUFKK0=FE9RG9QfTUPKoTXkZPVEpskC13mD-R2A@mail.gmail.com>
Message-ID: <CADRPPNSnPoEwUFKK0=FE9RG9QfTUPKoTXkZPVEpskC13mD-R2A@mail.gmail.com>
Subject: Re: [PATCH v2] arm64: dts: lx2160aqds: Add mdio mux nodes
To: Pankaj Bansal <pankaj.bansal@nxp.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190205_103728_550737_B61336E1 
X-CRM114-Status: GOOD (  20.43  )
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
Cc: Andrew Lunn <andrew@lunn.ch>, Florian Fainelli <f.fainelli@gmail.com>,
 Shawn Guo <shawnguo@kernel.org>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Mon, Feb 4, 2019 at 2:53 AM Pankaj Bansal <pankaj.bansal@nxp.com> wrote:
>
> The two external MDIO buses used to communicate with phy devices that are
> external to SOC are muxed in LX2160AQDS board.
>
> These buses can be routed to any one of the eight IO slots on LX2160AQDS
> board depending on value in fpga register 0x54.
>
> Additionally the external MDIO1 is used to communicate to the onboard
> RGMII phy devices.
>
> The mdio1 is controlled by bits 4-7 of fpga register and mdio2 is
> controlled by bits 0-3 of fpga register.
>
> Signed-off-by: Pankaj Bansal <pankaj.bansal@nxp.com>
> ---
>
> Notes:
>     V2:
>     - removed unnecassary TODO statements
>     - removed device_type from mdio nodes
>     - change the case of hex number to lowercase
>     - removed board specific comments from soc file

There are still some comments from V1 haven't been addressed.

>
>  .../boot/dts/freescale/fsl-lx2160a-qds.dts   | 115 +++++++++++++++++
>  .../boot/dts/freescale/fsl-lx2160a.dtsi      |  18 +++
>  2 files changed, 133 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/freescale/fsl-lx2160a-qds.dts b/arch/arm64/boot/dts/freescale/fsl-lx2160a-qds.dts
> index 99a22abbe725..2c3020a72d41 100644
> --- a/arch/arm64/boot/dts/freescale/fsl-lx2160a-qds.dts
> +++ b/arch/arm64/boot/dts/freescale/fsl-lx2160a-qds.dts
> @@ -46,6 +46,121 @@
>  &i2c0 {
>         status = "okay";
>
> +       fpga@66 {
> +               compatible = "fsl,lx2160aqds-fpga", "fsl,fpga-qixis-i2c";
> +               reg = <0x66>;
> +               #address-cells = <1>;
> +               #size-cells = <0>;
> +
> +               mdio-mux-1@54 {

Still no compatible string defined for the node.  Probably should be
"mdio-mux-mmioreg", "mdio-mux"

> +                       mdio-parent-bus = <&emdio1>;
> +                       reg = <0x54>;            /* BRDCFG4 */
> +                       mux-mask = <0xf8>;      /* EMI1_MDIO */
> +                       #address-cells=<1>;
> +                       #size-cells = <0>;
> +
> +                       mdio@0 {
> +                               reg = <0x00>;
> +                               #address-cells = <1>;
> +                               #size-cells = <0>;
> +                       };
> +                       mdio@40 {
> +                               reg = <0x40>;
> +                               #address-cells = <1>;
> +                               #size-cells = <0>;
> +                       };
> +                       mdio@c0 {
> +                               reg = <0xc0>;
> +                               #address-cells = <1>;
> +                               #size-cells = <0>;
> +                       };
> +                       mdio@c8 {
> +                               reg = <0xc8>;
> +                               #address-cells = <1>;
> +                               #size-cells = <0>;
> +                       };
> +                       mdio@d0 {
> +                               reg = <0xd0>;
> +                               #address-cells = <1>;
> +                               #size-cells = <0>;
> +                       };
> +                       mdio@d8 {
> +                               reg = <0xd8>;
> +                               #address-cells = <1>;
> +                               #size-cells = <0>;
> +                       };
> +                       mdio@e0 {
> +                               reg = <0xe0>;
> +                               #address-cells = <1>;
> +                               #size-cells = <0>;
> +                       };
> +                       mdio@e8 {
> +                               reg = <0xe8>;
> +                               #address-cells = <1>;
> +                               #size-cells = <0>;
> +                       };
> +                       mdio@f0 {
> +                               reg = <0xf0>;
> +                               #address-cells = <1>;
> +                               #size-cells = <0>;
> +                       };
> +                       mdio@f8 {
> +                               reg = <0xf8>;
> +                               #address-cells = <1>;
> +                               #size-cells = <0>;
> +                       };
> +               };
> +
> +               mdio-mux-2@54 {
> +                       mdio-parent-bus = <&emdio2>;
> +                       reg = <0x54>;            /* BRDCFG4 */
> +                       mux-mask = <0x07>;      /* EMI2_MDIO */
> +                       #address-cells=<1>;
> +                       #size-cells = <0>;
> +
> +                       mdio@0 {
> +                               reg = <0x00>;
> +                               #address-cells = <1>;
> +                               #size-cells = <0>;
> +                       };
> +                       mdio@1 {
> +                               reg = <0x01>;
> +                               #address-cells = <1>;
> +                               #size-cells = <0>;
> +                       };
> +                       mdio@2 {
> +                               reg = <0x02>;
> +                               #address-cells = <1>;
> +                               #size-cells = <0>;
> +                       };
> +                       mdio@3 {
> +                               reg = <0x03>;
> +                               #address-cells = <1>;
> +                               #size-cells = <0>;
> +                       };
> +                       mdio@4 {
> +                               reg = <0x04>;
> +                               #address-cells = <1>;
> +                               #size-cells = <0>;
> +                       };
> +                       mdio@5 {
> +                               reg = <0x05>;
> +                               #address-cells = <1>;
> +                               #size-cells = <0>;
> +                       };
> +                       mdio@6 {
> +                               reg = <0x06>;
> +                               #address-cells = <1>;
> +                               #size-cells = <0>;
> +                       };
> +                       mdio@7 {
> +                               reg = <0x07>;
> +                               #address-cells = <1>;
> +                               #size-cells = <0>;
> +                       };
> +               };
> +       };
> +
>         i2c-mux@77 {
>                 compatible = "nxp,pca9547";
>                 reg = <0x77>;
> diff --git a/arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi b/arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi
> index a79f5c1ea56d..a74045ad22ad 100644
> --- a/arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi
> +++ b/arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi
> @@ -762,5 +762,23 @@
>                                      <GIC_SPI 209 IRQ_TYPE_LEVEL_HIGH>;
>                         dma-coherent;
>                 };
> +
> +               /* WRIOP0: 0x8b8_0000, E-MDIO1: 0x1_6000 */
> +               emdio1: mdio@8b96000 {
> +                       compatible = "fsl,fman-memac-mdio";
> +                       reg = <0x0 0x8b96000 0x0 0x1000>;
> +                       #address-cells = <1>;
> +                       #size-cells = <0>;
> +                       little-endian;  /* force the driver in LE mode */

Still doesn't fully align with the binding at
"Documentation/devicetree/bindings/powerpc/fsl/fman.txt".

It should either have the "interrupts" property for external MDIO or
"fsl,fman-internal-mdio" for internal MDIO.

> +               };
> +
> +               /* WRIOP0: 0x8b8_0000, E-MDIO2: 0x1_7000 */
> +               emdio2: mdio@8b97000 {
> +                       compatible = "fsl,fman-memac-mdio";
> +                       reg = <0x0 0x8b97000 0x0 0x1000>;
> +                       #address-cells = <1>;
> +                       #size-cells = <0>;
> +                       little-endian;  /* force the driver in LE mode */
> +               };
>         };
>  };
> --
> 2.17.1
>

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
