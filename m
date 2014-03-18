From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Tue, 18 Mar 2014 10:04:50 +0100
Subject: [PATCH v2 6/8] ARM: sunxi: dt: Add x-powers-axp209.dtsi file
In-Reply-To: <1394898225-28452-7-git-send-email-carlo@caione.org>
References: <1394898225-28452-1-git-send-email-carlo@caione.org>
 <1394898225-28452-7-git-send-email-carlo@caione.org>
Message-ID: <20140318090450.GV27873@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Mar 15, 2014 at 04:43:43PM +0100, Carlo Caione wrote:
> This dtsi describes the axp209 PMIC, and is to be included from inside
> the i2c controller node to which the axp209 is connected.
> 
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> Signed-off-by: Carlo Caione <carlo@caione.org>
> ---
>  arch/arm/boot/dts/x-powers-axp209.dtsi | 60 ++++++++++++++++++++++++++++++++++
>  1 file changed, 60 insertions(+)
>  create mode 100644 arch/arm/boot/dts/x-powers-axp209.dtsi
> 
> diff --git a/arch/arm/boot/dts/x-powers-axp209.dtsi b/arch/arm/boot/dts/x-powers-axp209.dtsi
> new file mode 100644
> index 0000000..d272e67
> --- /dev/null
> +++ b/arch/arm/boot/dts/x-powers-axp209.dtsi
> @@ -0,0 +1,60 @@
> +/*
> + * x-powers,axp209 common code to be include from inside the axp209 node
> + *
> + * Copyright 2014 - Carlo Caione <carlo@caione.org>
> + *
> + * The code contained herein is licensed under the GNU General Public
> + * License. You may obtain a copy of the GNU General Public License
> + * Version 2 or later at the following locations:
> + *
> + * http://www.opensource.org/licenses/gpl-license.html
> + * http://www.gnu.org/copyleft/gpl.html
> + */
> +

I didn't even know such a thing was possible :)
Nice hack.

> +	compatible = "x-powers,axp209";
> +	interrupt-controller;
> +	#interrupt-cells = <1>;

However, I'd move this out of it, and in the board file, so that we
actually get an idea by looking at the board DTS of what device we are
actually registering at this given address, and what it's capable of.

Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140318/0887235f/attachment.sig>
