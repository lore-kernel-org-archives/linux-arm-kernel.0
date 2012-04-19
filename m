From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 19 Apr 2012 11:32:01 +0000
Subject: [PATCH V2] Ethernut 5 board support
In-Reply-To: <4F8FE598.5090409@egnite.de>
References: <4F8FE598.5090409@egnite.de>
Message-ID: <201204191132.02009.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 19 April 2012, Tim Schendekehl wrote:
> +       i2c at 0 {
> +               status = "okay";
> +
> +               pcf8563 at 50 {
> +                       compatible = "pcf8563";
> +                       reg = <0x51>;
> +               };
> +
> +               pmmc at 22 {
> +                       compatible = "pmmc";
> +                       reg = <0x22>;
> +               };
> +       };

Please make the compatible properties more specific. The first one should be
compatible="nxp,pcf8563". For the second one, it's not clear what this
refers to. What is a pmmc?

Everything else looks good to me.

	Arnd
