From: broonie@kernel.org (Mark Brown)
Date: Tue, 31 Jul 2018 16:52:46 +0100
Subject: next/master boot: 171 boots: 6 failed, 162 passed with 3 offline
 (next-20180724)
In-Reply-To: <20180725161151.GA340@sirena.org.uk>
References: <5b5757ee.1c69fb81.411a5.52e2@mx.google.com>
 <20180725161151.GA340@sirena.org.uk>
Message-ID: <20180731155246.GG5719@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 25, 2018 at 05:11:51PM +0100, Mark Brown wrote:
> On Tue, Jul 24, 2018 at 09:46:38AM -0700, kernelci.org bot wrote:

> For a little while now the RPi B has been failing to boot using the
> bcm2835 defconfig in -next:

...

> It's working fine on arm64, whatever's going on appears to be specific
> to this config (it's not getting booted with any other 32 bit configs).
> Full info and boot logs for one of the boards here:

>    https://kernelci.org/boot/id/5b58416759b514139596baae/

> it looks like it hangs somewhere shortly after or during initializing
> MMC so never makes it to the console, the tail of the failing logs looks
> like:

This went away for a day or two but it looks like it's back again I'm
afraid:

    https://kernelci.org/boot/id/5b604cd259b514364696baaa/

> 
> | 09:18:36.332120  [    1.459801] mmc1: queuing unknown CIS tuple 0x80 (7 bytes)
> | 09:18:36.345711  [    1.467585] mmcblk0: mmc0:59b4 USD   7.51 GiB 
> | 09:18:36.346169  [    1.474834]  mmcblk0: p1
> | 09:18:36.410184  [    1.539600] random: fast init done
> | 09:18:36.458065  [    1.578056] mmc1: new high speed SDIO card at address 0001
> | 09:20:39.745370  ShellCommand command timed out.: Sending # in case of corruption. Connection timeout 00:04:10, retry in 00:02:05
> | 09:20:39.846848  #
> 
> but like I say the same -next boots with arm64 defconfig.


-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 488 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180731/54d82109/attachment.sig>
