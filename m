From: wens@csie.org (Chen-Yu Tsai)
Date: Mon, 26 Oct 2015 16:02:18 +0800
Subject: [linux-sunxi] [PATCH v4 1/1] dts: sun6i: yones toptech bs1078 v2:
 Add AXP221 support to dts
In-Reply-To: <1445806172-25998-1-git-send-email-lyu@micile.com>
References: <1445806172-25998-1-git-send-email-lyu@micile.com>
Message-ID: <CAGb2v65vdA9Ug8td9zwq3eECm6moUcgSSQXGnAtE04tLp3KvhQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Mon, Oct 26, 2015 at 4:49 AM, Lawrence Yu <lyu@micile.com> wrote:
> Enable the axp221 PMIC chip in the dts file.
>
> Allows board to power off correctly from the poweroff command
>
> This board requires dc1sw to be enabled in order to provide a power source
> for the 5V DCDC converter that powers USB2.
>
> This board uses dldo1 for 3.3V wifi power
>
> This board requires dldo3 to be enabled at 2.8V in order to provide voltage
> to the pullup resistors for the i2c0 bus.
>
> ---
> Changes since v3
>
> - Changed reg_dc1sw to be a node reference
> - Moved regulator nodes to correct alphabetical position before uart0
>
> Changes since v2
>
> - Rename regulator vcc-dc1sw to vcc-lcd-usb2
> - Rename regulator vcc-csi to vddio-csi
> - Remove regulator-always-on from dldo3
> - Remove comment about LCD backlight and USB2 from reg_dc1sw
> - Remove comment about dc1sw providing power to LCD backlight in patch
>   description
>
> Changes since v1
>
> - Use axp22x.dtsi to standardize the register names
> - Change wifi power regulator to dldo1 instead of incorrect aldo1
> - Remove unnecessary gpio pin PH27 for wifi power, since this board uses
>   the axp221 chip to control power to the wifi chip.
>
> Signed-off-by: Lawrence Yu <lyu@micile.com>

Normally one puts this at the end of the commit message, then "---",
then changelogs and any additional messages for the maintainer. :)

Overall this version looks good.

Acked-by: Chen-Yu Tsai <wens@csie.org>

Please send additional patches for reordering stuff, simplefb regulators,
and possibly cpu regulator (so you get full cpufreq support).

P.S. Your patch is not showing up on LAKML patchwork. Not subscribed?
