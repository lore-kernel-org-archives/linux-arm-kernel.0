From: arnd@arndb.de (Arnd Bergmann)
Date: Sat, 05 Dec 2015 23:19:04 +0100
Subject: [PATCH net-next 2/2] net: hns: enet specisies a reference to dsaf
 (config and documents)
In-Reply-To: <1449295856-31068-3-git-send-email-yankejian@huawei.com>
References: <1449295856-31068-1-git-send-email-yankejian@huawei.com>
 <1449295856-31068-3-git-send-email-yankejian@huawei.com>
Message-ID: <23027215.8RIhViTVaB@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Saturday 05 December 2015 14:10:56 yankejian wrote:
> diff --git a/Documentation/devicetree/bindings/net/hisilicon-hns-dsaf.txt b/Documentation/devicetree/bindings/net/hisilicon-hns-dsaf.txt
> index 80411b2..ecacfa4 100644
> --- a/Documentation/devicetree/bindings/net/hisilicon-hns-dsaf.txt
> +++ b/Documentation/devicetree/bindings/net/hisilicon-hns-dsaf.txt
> @@ -4,8 +4,6 @@ Required properties:
>  - compatible: should be "hisilicon,hns-dsaf-v1" or "hisilicon,hns-dsaf-v2".
>    "hisilicon,hns-dsaf-v1" is for hip05.
>    "hisilicon,hns-dsaf-v2" is for Hi1610 and Hi1612.
> -- dsa-name: dsa fabric name who provide this interface.
> -  should be "dsafX", X is the dsaf id.
>  - mode: dsa fabric mode string. only support one of dsaf modes like these:
>                 "2port-64vf",
>                 "6port-16rss",
> @@ -26,9 +24,8 @@ Required properties:
>  
>  Example:
>  
> -dsa: dsa at c7000000 {
> +dsaf0: dsa at c7000000 {
>         compatible = "hisilicon,hns-dsaf-v1";
> -       dsa_name = "dsaf0";
>         mode = "6port-16rss";
>         interrupt-parent = <&mbigen_dsa>;
>         reg = <0x0 0xC0000000 0x0 0x420000
> diff --git a/Documentation/devicetree/bindings/net/hisilicon-hns-nic.txt b/Documentation/devicetree/bindings/net/hisilicon-hns-nic.txt
> index 41d19be..e6a9d1c 100644
> --- a/Documentation/devicetree/bindings/net/hisilicon-hns-nic.txt
> +++ b/Documentation/devicetree/bindings/net/hisilicon-hns-nic.txt
> @@ -4,8 +4,9 @@ Required properties:
>  - compatible: "hisilicon,hns-nic-v1" or "hisilicon,hns-nic-v2".
>    "hisilicon,hns-nic-v1" is for hip05.
>    "hisilicon,hns-nic-v2" is for Hi1610 and Hi1612.
> -- ae-name: accelerator name who provides this interface,
> -  is simply a name referring to the name of name in the accelerator node.
> +- ae-handle: accelerator engine handle for hns,
> +  specifies a reference to the associating hardware driver node.
> +  see Documentation/devicetree/bindings/net/hisilicon-hns-dsaf.txt
>  - port-id: is the index of port provided by DSAF (the accelerator). DSAF can
>    connect to 8 PHYs. Port 0 to 1 are both used for adminstration purpose. They
>    are called debug ports.
> @@ -41,7 +42,7 @@ Example:
>  
> 

This looks like an incompatible change, as you add and remove
required properties. Is there a way to support both the old and
the new style?

	Arnd
