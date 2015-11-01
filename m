From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Sun, 1 Nov 2015 10:35:40 +0100
Subject: [linux-sunxi] [PATCH v4 1/1] dts: sun6i: yones toptech bs1078
 v2: Add AXP221 support to dts
In-Reply-To: <CAGb2v65vdA9Ug8td9zwq3eECm6moUcgSSQXGnAtE04tLp3KvhQ@mail.gmail.com>
References: <1445806172-25998-1-git-send-email-lyu@micile.com>
 <CAGb2v65vdA9Ug8td9zwq3eECm6moUcgSSQXGnAtE04tLp3KvhQ@mail.gmail.com>
Message-ID: <20151101093540.GN6114@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Mon, Oct 26, 2015 at 04:02:18PM +0800, Chen-Yu Tsai wrote:
> Hi,
> 
> On Mon, Oct 26, 2015 at 4:49 AM, Lawrence Yu <lyu@micile.com> wrote:
> > Enable the axp221 PMIC chip in the dts file.
> >
> > Allows board to power off correctly from the poweroff command
> >
> > This board requires dc1sw to be enabled in order to provide a power source
> > for the 5V DCDC converter that powers USB2.
> >
> > This board uses dldo1 for 3.3V wifi power
> >
> > This board requires dldo3 to be enabled at 2.8V in order to provide voltage
> > to the pullup resistors for the i2c0 bus.
> >
> > ---
> > Changes since v3
> >
> > - Changed reg_dc1sw to be a node reference
> > - Moved regulator nodes to correct alphabetical position before uart0
> >
> > Changes since v2
> >
> > - Rename regulator vcc-dc1sw to vcc-lcd-usb2
> > - Rename regulator vcc-csi to vddio-csi
> > - Remove regulator-always-on from dldo3
> > - Remove comment about LCD backlight and USB2 from reg_dc1sw
> > - Remove comment about dc1sw providing power to LCD backlight in patch
> >   description
> >
> > Changes since v1
> >
> > - Use axp22x.dtsi to standardize the register names
> > - Change wifi power regulator to dldo1 instead of incorrect aldo1
> > - Remove unnecessary gpio pin PH27 for wifi power, since this board uses
> >   the axp221 chip to control power to the wifi chip.
> >
> > Signed-off-by: Lawrence Yu <lyu@micile.com>
> 
> Normally one puts this at the end of the commit message, then "---",
> then changelogs and any additional messages for the maintainer. :)
> 
> Overall this version looks good.
> 
> Acked-by: Chen-Yu Tsai <wens@csie.org>

I've fixed the SoB, and applied the patch. It's queued for 4.5, and I
won't push the branch before 4.4-rc1 is released.

> Please send additional patches for reordering stuff, simplefb regulators,
> and possibly cpu regulator (so you get full cpufreq support).
> 
> P.S. Your patch is not showing up on LAKML patchwork. Not subscribed?

Yeah, for some reason it wasn't showing up in my INBOX either (but
your reply did).

Thanks!
Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20151101/85950ab3/attachment.sig>
