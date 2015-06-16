From: merker@debian.org (Karsten Merker)
Date: Tue, 16 Jun 2015 21:11:08 +0200
Subject: [RFC PATCH V3] ARM: dts: sun6i: Add dts file for MSI Primo81 tablet
In-Reply-To: <20150616094026.GG11732@lukather>
References: <20150616094026.GG11732@lukather>
Message-ID: <1434481869-9432-1-git-send-email-merker@debian.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 16, 2015 at 11:40:27AM +0200, Maxime Ripard wrote:

> What I meant in my previous review was to use the syntax
> 
> &uart0 {
>        some-property;
> };
>   
> Instead of duplicating the tree structure like you're doing
> here. We've converted all the DT to that, so you can look around and
> see how it's done in other boards (note that the nodes should be
> sorted by alphabetical order).

Ah, sorry, I had misunderstood your original email in this regard.
Following is a reworked version of the patch.

Changelog:

Version 1
=========
- Original patch by Siarhei Siamashka

Version 2
=========
- Use symbolic instead of numeric pinctrl values.

- Change the include syntax from /include/ to #include to make
  the dts build with current kernels.

Version 3
=========
- Use labels for nodes with modifications in relation to the dtsi
  instead of replicating the tree structure.

- Remove the FSF address from the license header as done in
  http://lists.infradead.org/pipermail/linux-arm-kernel/2015-May/340437.html
  for the other dts files to remove a checkpatch warning.

- Add msi to the vendor prefix list.

- Remove earlyprintk from the default kernel commandline.

- Replace the console kernel commandline parameter by a
  /chosen/stdout-path node and add an alias serial0 -> uart0.

I have tagged this patch RFC as I am unsure what to do with the
/chosen/stdout-path node. For now, I have set Siarhei's original
choice (first serial port), but I am unsure whether this is the
right thing to do as the Primo81 does by default not have a
user-accessible serial port.  The only way to get a serial
console is to either break the case open and find some test
points that carry the RX/TX lines (which with the Primo81 case
poses a high risk of breaking the display glass), or to use an SD
card breakout board and change the pinmuxing for the SD card pins
to the "serial" function.  The latter would not work without
modifying the dts, so the SD-breakout case doesn't really count
for setting the default stdout-path in the general use case.

On the other hand, setting stdout-path to the serial port does
not seem to influence getting a a boot console on the LCD when
booting from a simplefb-capable u-boot, so there is probably no
harm in doing it.

Comments welcome :-).

Regards,
Karsten
-- 
Gem. Par. 28 Abs. 4 Bundesdatenschutzgesetz widerspreche ich der Nutzung
sowie der Weitergabe meiner personenbezogenen Daten f?r Zwecke der
Werbung sowie der Markt- oder Meinungsforschung.
