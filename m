From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 14 Aug 2015 22:49:50 +0200
Subject: [PATCH 1/5] net: add Hisilicon Network Subsystem support (config
 and documents)
In-Reply-To: <1439548222-231611-2-git-send-email-liguozhu@hisilicon.com>
References: <1439548222-231611-1-git-send-email-liguozhu@hisilicon.com>
 <1439548222-231611-2-git-send-email-liguozhu@hisilicon.com>
Message-ID: <1536926.jEJjsM70Lj@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 14 August 2015 18:30:18 Kenneth Lee wrote:
> diff --git a/Documentation/devicetree/bindings/net/hisilicon-hns-nic.txt b/Documentation/devicetree/bindings/net/hisilicon-hns-nic.txt
> new file mode 100644
> index 0000000..5ab6969
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/net/hisilicon-hns-nic.txt
> @@ -0,0 +1,14 @@
> +Hisilicon Network Subsystem NIC controller
> +
> +Required properties:
> +- compatible: hisilicon,hns-nic
> +- ae-name: accelerator name who provide this interface
> +- ae-opts: options (string) to the accelerator. e.g. the index interface
> +
> +Example:
> +
> +       ethernet at 0{
> +               compatible = "hisilicon,hns-nic";
> +               ae-name = "soc0-n4";
> +               ae-opts = "0";
> +       };
> 

These properties look very unconventional. What are the valid strings
for ae-name and ae-opts? It looks like the latter is just a number,
so why not use an integer property?

	Arnd
