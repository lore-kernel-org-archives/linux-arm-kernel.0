From: andrew@lunn.ch (Andrew Lunn)
Date: Fri, 15 Jun 2012 08:30:27 +0200
Subject: Converting kirkwood-goflexnet to DTS
Message-ID: <20120615063027.GA27717@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Josh

My guess is you have a problem with the DT blob.

How are you appending the DTS blob?

I have the kernel option:

CONFIG_ARM_APPENDED_DTB=y

I compile the .dts/.dtsi with:

$ make kirkwood-ts219-6282.dtb
  DTC     arch/arm/boot/kirkwood-ts219-6282.dtb
DTC: dts->dtb  on file "arch/arm/boot/dts/kirkwood-ts219-6282.dts"

and then attach the blob to the kernel and place it on my tftp server
with:

#!/bin/bash

tmp=$(tempfile)

cat arch/arm/boot/zImage > $tmp
cat arch/arm/boot/kirkwood-ts219-6282.dtb >> $tmp
mkimage -A arm -O linux -T kernel -C none -a 0x00008000 -e 0x00008000 -d $tmp /srv/tftp/uImage-dev
rm $tmp

And then load and boot it using u-boot.

    Andrew
