From: andrew@lunn.ch (Andrew Lunn)
Date: Thu, 5 Nov 2015 00:38:22 +0100
Subject: [PATCH 2/4] ARM: dts: kirkwood: add Linksys EA3500
In-Reply-To: <00000150d49a832c-f77d66d7-8f66-4b36-ac2c-df85deee46b6-000000@email.amazonses.com>
References: <1446675888-24495-1-git-send-email-luka.perkov@sartura.hr>
 <00000150d49a832c-f77d66d7-8f66-4b36-ac2c-df85deee46b6-000000@email.amazonses.com>
Message-ID: <20151104233822.GC8263@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Luka

>  "lacie,netspace_mini_v2"
>  "lacie,netspace_v2"
>  "linksys,ea4500"
> +"linksys,ea3500"

Other way around please, to keep the sorted order.

> +	chosen {
> +		bootargs = "console=ttyS0,115200n8 earlyprintk";

stdout = ...

> +&nand {
> +	status = "okay";
> +	pinctrl-0 = <&pmx_nand>;
> +	pinctrl-names = "default";
> +
> +	partition at 0 {
> +		label = "u-boot";
> +		reg = <0x0000000 0x80000>;
> +		read-only;
> +	};
> +
> +	partition at 80000 {
> +		label = "u-boot environment";
> +		reg = <0x80000 0x20000>;
> +	};

Same hole?

> +	partition at 200000 {
> +		label = "kernel";
> +		reg = <0x200000 0x200000>;
> +	};
> +
> +	partition at 400000 {
> +		label = "root";
> +		reg = <0x400000 0x1200000>;
> +	};
> +};

  Andrew
