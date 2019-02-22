Return-Path: <SRS0=2lwk=Q5=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_MUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1505C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 23:37:43 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 70DEE2070D
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 23:37:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="QG/21rFH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 70DEE2070D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=XYj5q2QsJMi07gwzM32kCKCiQyLenBsjgO25sJZbEss=; b=QG/21rFHyTjRw5
	AmJLRkcmHw8V+DANMOPG2nihiAfUd3M+dyHFK54BNY/yfi0M234zuIW7yPvQSzp1VALSXpI1yF4rj
	zB9QiDWyFC9wds+R3XgEyCv2eOqeg/Oh/CZDD14Q5ziuKbq6c2ggosWQtollv8ylS6WuarjpcSUm7
	QwHUOncu6H7jSWjkD+teYD2D1Lm7mB0wsGXpeFQ2mhWDvvuCrPcpXMj9w51IMA/m/0RuQyZBVMNmo
	8YuIwJdfE+sNN/lkn+lB8fQSSu9GeBih6s6OhZqRfmQNl5XC5BO0ij6Ble17kqqdfISgAgGGwksOk
	z9Jb/I50PUrQIyUQRugw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gxKNt-0001iB-P1; Fri, 22 Feb 2019 23:37:37 +0000
Received: from mail-oi1-f196.google.com ([209.85.167.196])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gxKNq-0001hf-Qx
 for linux-arm-kernel@lists.infradead.org; Fri, 22 Feb 2019 23:37:36 +0000
Received: by mail-oi1-f196.google.com with SMTP id b4so3088172oif.6
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 22 Feb 2019 15:37:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=TXwjQ2b7Jw3X1MBD87UlddaI6hJT6VW9GD6LgD5VUJE=;
 b=swM2G0TTv8ZECKK8RxUupCCHlh9KBY8lEKvdTMoVSmElk4ANrIecRWXnGTxff+mo4V
 3A5hmbgdtSJJJsmgxZZqYiy45Kd+PKcdEq3tT782PuNZfVTqrrc+h/87S6h18qU6/3hk
 gRBW0GUuYbgBPmtlyAPrC4zEqWJVu+tQY1M5bD9gnZyPQgOYYtq0ghByNFRziTCuZyBy
 SxP7dQInAw/EhYkeJ45S+6zp76pz7EOwGdp50kvo78dXgR4YoDen6m07T3HR1Iu1W2OE
 sE/rBDoYsNMSwop/+9RH1cTP5xSexcElp7QOl4A4WN8vIulfyY6ybxliF4HlckaNZmxR
 /0xQ==
X-Gm-Message-State: AHQUAuaXsGIxwDkZdanSPB2tsJ6mYcSspJJcEeryHsV9gNZBMmPpls1u
 dYo7kzk895B8EdMFLxaOjg==
X-Google-Smtp-Source: AHgI3Ia5vCL+Al2a75f8dpb0twRi8Zctlq8hLuPr9oUT72Hqa2YgKPAsIkQsGuoRaqtxZWBTxIb6Rw==
X-Received: by 2002:aca:75cf:: with SMTP id q198mr4134244oic.125.1550878653778; 
 Fri, 22 Feb 2019 15:37:33 -0800 (PST)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net.
 [24.155.109.49])
 by smtp.gmail.com with ESMTPSA id l134sm1185756oih.43.2019.02.22.15.37.32
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Fri, 22 Feb 2019 15:37:33 -0800 (PST)
Date: Fri, 22 Feb 2019 17:37:32 -0600
From: Rob Herring <robh@kernel.org>
To: Claudiu Manoil <claudiu.manoil@nxp.com>
Subject: Re: [PATCH net-next v3 4/4] dt-bindings: net: freescale: enetc: Add
 connection bindings for ENETC ethernet nodes
Message-ID: <20190222233732.GA1518@bogus>
References: <1550847859-17346-1-git-send-email-claudiu.manoil@nxp.com>
 <1550847859-17346-5-git-send-email-claudiu.manoil@nxp.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1550847859-17346-5-git-send-email-claudiu.manoil@nxp.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190222_153734_870870_0CBBC493 
X-CRM114-Status: GOOD (  26.84  )
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
Cc: devicetree@vger.kernel.org, netdev@vger.kernel.org,
 alexandru.marginean@nxp.com, linux-kernel@vger.kernel.org,
 Li Yang <leoyang.li@nxp.com>, Shawn Guo <shawnguo@kernel.org>,
 "David S . Miller" <davem@davemloft.net>, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Fri, Feb 22, 2019 at 05:04:19PM +0200, Claudiu Manoil wrote:
> Define connection bindings (external PHY connections and internal links)
> for the ENETC on-chip ethernet controllers.
> 
> Signed-off-by: Claudiu Manoil <claudiu.manoil@nxp.com>
> ---
> v3 - added this patch to the set
> 
>  .../devicetree/bindings/net/fsl-enetc.txt          | 109 +++++++++++++++++++++
>  1 file changed, 109 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/net/fsl-enetc.txt
> 
> diff --git a/Documentation/devicetree/bindings/net/fsl-enetc.txt b/Documentation/devicetree/bindings/net/fsl-enetc.txt
> new file mode 100644
> index 0000000..2fbb998
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/net/fsl-enetc.txt
> @@ -0,0 +1,109 @@
> +* ENETC ethernet nodes - external connection bindings
> +
> +The ENETC ethernet controllers are PCIe integrated endpoints
> +(IEPs), on-chip devices discoverable as standard PCIe endpoints,
> +integrated into Freescale SoCs.  The ENETC devices are self
> +contained, the information needed for device initialization
> +is available in hardware (PCIe ECAM area).  However, depending
> +on board design, their external connections are configurable.
> +As usual for SoCs, device tree nodes may be used to define these
> +external connections.  The rest of the document specifies how
> +external connections for ENETC ethernet controllers may be
> +defined via device tree nodes.
> +
> +Silicon (SoC) availability (<SoC name>: <SoC DT path/name>)
> +	- LS1028A: [arch/arm64]	[...]freescale/fsl-ls1028a.dtsi

This doesn't belong in bindings.

> +
> +
> +* ENETC nodes
> +
> +Defined in the SoC device tree as "pci" child nodes of the
> +"pci-host-ecam-generic" compatible "pcie" parent node also known
> +as the Integrated Endpoint Root Complex (IERC) SoC node.

The host controller attachment is also outside the scope of this 
binding.

> +
> +Structure - example (LS1028A):
> +
> +	pcie@1f0000000 {
> +		compatible = "pci-host-ecam-generic";
> +		device_type = "pci";
> +		...
> +		enetc_port0: pci@0,0 {

The node name 'pci' is reserved for bridges. This should match the 
device class if possible (ethernet).

> +			reg = <0x000000 0 0 0 0>;
> +		};
> +		enetc_port1: pci@0,1 {
> +			reg = <0x000100 0 0 0 0>;
> +		};
> +		...
> +	}
> +
> +Each ENETC node has a device number and a function number (expressed
> +by its "reg" property and pci node name, i.e. "pci@0,1" represents
> +device number 0 and functions number 1).  Only the standard pci "reg"
> +property is needed here.

There should be a compatible too.

> +For easy reference, each ENETC node is tagged by a handle having the
> +following format:
> +
> +	"enetc_port<idx>"   where, idx = 0 .. n-1;
> +			    n - #of available ENETC nodes (Ports) on
> +				the given SoC.

These are just source labels, so really they can be anything.

> +
> +NOTES
> +i. The SoC H/W Reference Manual provides a mapping of the ENETC Port
> +numbers to the PCIe Device Number/ Function Number.
> +Example (LS1028):
> +	All ENETC PFs (PCIe Physical Functions) have Device Number 0.
> +	Port 0 - PF0 (pci@0,0)
> +	Port 1 - PF1 (pci@0,1)
> +	Port 2 - PF2 (pci@0,2)
> +	Port 3 - PF6 (pci@0,6)
> +
> +ii. The SoC H/W Reference Manual also defines which ENETC Ports may have
> +external connections (external ports) and which ones are internally
> +connected to a on-chip L2 switch for instance (internal ports).
> +
> +
> +* Defining connections for ENETC nodes
> +
> +To define external connections for the external ENETC Ports on a given
> +board/platform, the board device tree should include the SoC device tree
> +and reference the external ports by their "enetc_port<idx>" handle.

SoC vs. board files are convention, but not really part of the binding 
ABI.

> +
> +Following cases arise, defining all possible connection bindings:
> +
> +1) The ENETC Port is connected to a MDIO configurable PHY:
> +
> +	In this case, the ENETC node should include a "mdio" sub-node
> +	that in turn should contain the "phy" node describing the
> +	external phy.  ENETC Port node structure (example):
> +
> +	&enetc_port0 {

Please just show the full DT example, not separate chunks.

> +		phy-handle = <&sgmii_phy0>;
> +		phy-connection-type = "sgmii";
> +
> +		mdio {
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +			sgmii_phy0: ethernet-phy@2 {
> +				reg = <0x2>;
> +			};
> +		};
> +	};
> +
> +	All properties are mandatory for this case, their bindings already
> +	defined (see ethernet.txt and phy.txt).
> +
> +2) The ENETC Port has a fixed-link connection:
> +
> +	In this case, the ENETC Port node defines a fixed link connection,
> +	with the following structure (example):
> +
> +	&enetc_port2 {
> +		fixed-link {
> +			speed = <1000>;
> +			full-duplex;
> +		};
> +	};
> +
> +	The "fixed-link" node properties are standard (as defined in
> +	fixed-link.txt).
> +	This connection type also applies to the internal ENETC Ports.
> -- 
> 2.7.4
> 

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
