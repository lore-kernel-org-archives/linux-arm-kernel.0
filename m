From: josh.coombs@gmail.com (Josh Coombs)
Date: Fri, 15 Jun 2012 00:53:45 -0400
Subject: Converting kirkwood-goflexnet to DTS
In-Reply-To: <CAMW5UfaPLUt3mub-rpZGKYG5GzjMntvrCOwu-q3r-twm-AgD=g@mail.gmail.com>
References: <20120614141706.GA6676@lunn.ch>
 <CAMW5UfaPLUt3mub-rpZGKYG5GzjMntvrCOwu-q3r-twm-AgD=g@mail.gmail.com>
Message-ID: <CAMW5UfYwZkXzGbJTZ7tBr+eA5_+Jcri3FzsoaptXJV94j2okzw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jun 14, 2012 at 6:16 PM, Josh Coombs <josh.coombs@gmail.com> wrote:
> Finally some progress. ?Using the printk patch along with earlyprintk
> and the config tweaks as suggested, my kernel at least now shows why
> it's dying:
>
> --------------------------
> ## Booting kernel from Legacy Image at 00800000 ...
> ? Image Name: ? Linux-3.5.0-rc2-ARCH
> ? Image Type: ? ARM Linux Kernel Image (uncompressed)
> ? Data Size: ? ?3015272 Bytes = 2.9 MiB
> ? Load Address: 00008000
> ? Entry Point: ?00008000
> ? Verifying Checksum ... OK
> ? Loading Kernel Image ... OK
> OK
>
> Starting kernel ...
>
> Uncompressing Linux... done, booting the kernel.
>
> Error: unrecognized/unsupported machine ID (r1 = 0x00000c11).
>
> Available machine support:
>
> ID (hex) ? ? ? ?NAME
> ffffffff ? ? ? ?Marvell Kirkwood (Flattened Device Tree)
>
> Please check your kernel config and/or bootloader.
> --------------------------

I'm still stuck with the same error.  I'm working against 5.2rc2 with
the Orion/kirkwood printk.c patch.

I'm not 100% on proper etiquette here so rather than spam first and
get scolded, I've pastebined the relevant info.

My current patchset is here: http://pastie.org/4090298
The stripped kernel conf I'm using is here: http://pastie.org/4090323

I'm including all but the iconnect flattened tree board types in my
config, included DTS early testing, and am appending the DTS
definitions to the end of the kernel as I don't expect my uboot to
play nice, so I'm rather surprised to not see any of the boards show
up as supported with that boot error.  I feel like this has got to be
a kernel conf issue, or I'm missing a step in preparing a DTS based
kernel.

I also know my board definition will need cleanup to support both the
GoFlex Net and Home but went this way just to test the concept first.

Josh C
