From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 02 May 2016 09:31:12 +0200
Subject: [PATCH v2 2/5] ARM: dts: vfxxx: Add device tree node for OCOTP
In-Reply-To: <b5c1ff5a805eae3e53f07f8d0161f0af51586c00.1462171990.git.maitysanchayan@gmail.com>
References: <cover.1462171989.git.maitysanchayan@gmail.com>
 <b5c1ff5a805eae3e53f07f8d0161f0af51586c00.1462171990.git.maitysanchayan@gmail.com>
Message-ID: <4759698.elnRBldlxl@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 02 May 2016 12:35:01 Sanchayan Maity wrote:
> +                       ocotp at 400a5000 {
> +                               compatible = "fsl,vf610-ocotp";
> +                               #address-cells = <1>;
> +                               #size-cells = <1>;
> +                               reg = <0x400a5000 0xCF0>;
> +                               clocks = <&clks VF610_CLK_OCOTP>;
> +
> +                               ocotp_cfg0: cfg0 at 410 {
> +                                       reg = <0x410 0x4>;
> +                               };
> +
> +                               ocotp_cfg1: cfg1 at 420 {
> +                                       reg = <0x420 0x4>;
> +                               };
> +                       };

How do the registers of the child nodes relate to the registers of the
parent? If there are in the same address space, it might be good to
add a "ranges" property to describe it.

	Arnd
-------------- next part --------------
An embedded message was scrubbed...
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
Subject: Re: [PATCH v8 40/45] drivers/of: Split unflatten_dt_node()
Date: Mon, 02 May 2016 12:02:21 +1000
Size: 8869
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160502/8b012f87/attachment-0001.mht>
