From: shawnguo@kernel.org (Shawn Guo)
Date: Fri, 18 Aug 2017 21:02:25 +0800
Subject: [PATCH] arm64: dts: ls1088a: Add USB support
In-Reply-To: <1503044085-5024-1-git-send-email-yinbo.zhu@nxp.com>
References: <1503044085-5024-1-git-send-email-yinbo.zhu@nxp.com>
Message-ID: <20170818130224.GN7608@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Aug 18, 2017 at 04:14:45PM +0800, yinbo.zhu at nxp.com wrote:
> From: "yinbo.zhu" <yinbo.zhu@nxp.com>
> 
> Fix the issue that usb is not detected on ls1088ardb
> 
> Signed-off-by: yinbo.zhu <yinbo.zhu@nxp.com>
> Signed-off-by: Ran Wang <ran.wang_1@nxp.com>

You are sending an updated patch.  Please have the version number in
subject prefix ...

> ---

... and a change history here.  There are a lot of good examples on the
list.  Please have a check.

>  arch/arm64/boot/dts/freescale/fsl-ls1088a-rdb.dts |  8 ++++++++
>  arch/arm64/boot/dts/freescale/fsl-ls1088a.dtsi    | 20 ++++++++++++++++++++
>  2 files changed, 28 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1088a-rdb.dts b/arch/arm64/boot/dts/freescale/fsl-ls1088a-rdb.dts
> index 213abb7..6c3c3bc 100644
> --- a/arch/arm64/boot/dts/freescale/fsl-ls1088a-rdb.dts
> +++ b/arch/arm64/boot/dts/freescale/fsl-ls1088a-rdb.dts
> @@ -118,6 +118,14 @@
>  	status = "okay";
>  };
>  
> +&usb0 {
> +	status = "okay";
> +};
> +
> +&usb1 {
> +	status = "okay";
> +};
> +
>  &esdhc {
>  	status = "okay";
>  };

I had already put this on previous version - please sort these labelled
nodes alphabetically.  That said, &usb should go after &sata.

Shawn
