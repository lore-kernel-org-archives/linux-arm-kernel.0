From: josh.coombs@gmail.com (Josh Coombs)
Date: Thu, 14 Jun 2012 18:16:14 -0400
Subject: Converting kirkwood-goflexnet to DTS
In-Reply-To: <20120614141706.GA6676@lunn.ch>
References: <20120614141706.GA6676@lunn.ch>
Message-ID: <CAMW5UfaPLUt3mub-rpZGKYG5GzjMntvrCOwu-q3r-twm-AgD=g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Finally some progress.  Using the printk patch along with earlyprintk
and the config tweaks as suggested, my kernel at least now shows why
it's dying:

--------------------------
## Booting kernel from Legacy Image at 00800000 ...
   Image Name:   Linux-3.5.0-rc2-ARCH
   Image Type:   ARM Linux Kernel Image (uncompressed)
   Data Size:    3015272 Bytes = 2.9 MiB
   Load Address: 00008000
   Entry Point:  00008000
   Verifying Checksum ... OK
   Loading Kernel Image ... OK
OK

Starting kernel ...

Uncompressing Linux... done, booting the kernel.

Error: unrecognized/unsupported machine ID (r1 = 0x00000c11).

Available machine support:

ID (hex)        NAME
ffffffff        Marvell Kirkwood (Flattened Device Tree)

Please check your kernel config and/or bootloader.
--------------------------

Obviously, I've missed something with my work as my machine is not
showing up as a supported unit in that list.  At least the machine ID
being detected is correct, so that's a plus.

I should be able to crack this and have another test kernel in 4
hours, I'm hoping with good results.

Josh C
