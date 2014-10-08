From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 08 Oct 2014 21:23:05 +0200
Subject: [PATCH 2/3] ARM: mediatek: add dts for mt6592-evb
In-Reply-To: <1412760987-1668-2-git-send-email-ibanezchen@gmail.com>
References: <1412760987-1668-1-git-send-email-ibanezchen@gmail.com>
 <1412760987-1668-2-git-send-email-ibanezchen@gmail.com>
Message-ID: <1905265.b2oMdAExsA@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 08 October 2014 17:36:26 Howard Chen wrote:
> +/ {
> +       model = "mt6592 evb";
> +       compatible = "mediatek,mt6592-evb", "mediatek,mt6592";
> +
> +       chosen {
> +               bootargs = "earlyprintk console=ttyS0,921600n8";
> +       };
> +

We're trying to get more people to use the DT earlyprintk method.
Can you move this into a stdout-path property instead of the
bootargs and make sure the driver supports it?

	Arnd
