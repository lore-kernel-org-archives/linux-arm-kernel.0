From: magnus.damm@gmail.com (Magnus Damm)
Date: Tue, 29 Apr 2014 06:23:39 +0000
Subject: [PATCH v4 05/11] ARM: shmobile: r7s72100: genmai: add uart
 aliases and activate scif2 as console
In-Reply-To: <1398704521-23767-6-git-send-email-wsa@the-dreams.de>
References: <1398704521-23767-1-git-send-email-wsa@the-dreams.de>
 <1398704521-23767-6-git-send-email-wsa@the-dreams.de>
Message-ID: <CANqRtoTHy+-ac0kWY5a9MdYN0=jwWdeuOus9CVBckmas32_hSQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Apr 28, 2014 at 5:01 PM, Wolfram Sang <wsa@the-dreams.de> wrote:
> From: Wolfram Sang <wsa+renesas@sang-engineering.com>
>
> We keep the UART naming backwards compatible with the legacy version.
>
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
> ---
>  arch/arm/boot/dts/r7s72100-genmai-reference.dts | 18 +++++++++++++++++-
>  1 file changed, 17 insertions(+), 1 deletion(-)
>
> diff --git a/arch/arm/boot/dts/r7s72100-genmai-reference.dts b/arch/arm/boot/dts/r7s72100-genmai-reference.dts
> index 941e72ce7c82..facff0271716 100644
> --- a/arch/arm/boot/dts/r7s72100-genmai-reference.dts
> +++ b/arch/arm/boot/dts/r7s72100-genmai-reference.dts
> @@ -1,7 +1,8 @@
>  /*
>   * Device Tree Source for the Genmai board
>   *
> - * Copyright (C) 2013 Renesas Solutions Corp.
> + * Copyright (C) 2013-14 Renesas Solutions Corp.
> + * Copyright (C) 2014 Wolfram Sang, Sang Engineering <wsa@sang-engineering.com>
>   *
>   * This file is licensed under the terms of the GNU General Public License
>   * version 2.  This program is licensed "as is" without any warranty of any
> @@ -15,6 +16,17 @@
>         model = "Genmai";
>         compatible = "renesas,genmai-reference", "renesas,r7s72100";
>
> +       aliases {
> +               serial0 = &scif0;
> +               serial1 = &scif1;
> +               serial2 = &scif2;
> +               serial3 = &scif3;
> +               serial4 = &scif4;
> +               serial5 = &scif5;
> +               serial6 = &scif6;
> +               serial7 = &scif7;
> +       };
> +
>         chosen {
>                 bootargs = "console=ttySC2,115200 ignore_loglevel rw root=/dev/nfs ip=dhcp";
>         };

Hi Wolfram,

Thanks for your updated series. For this patch I only have a minor
comment. I believe we only want to enable the serial port that is used
on the board. At the same time we want to keep the same ordering as
the legacy code. I believe you keep the same order already and only
enable ttySC2, but I wonder if you really need all the aliases above?
Perhaps it is possible to keep just serial2?

Cheers,

/ magnus
