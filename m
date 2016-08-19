From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Fri, 19 Aug 2016 14:28:45 +0100
Subject: [crypto] [marvell-cesa] Driver hangs on Armada 385 device
In-Reply-To: <20160819130846.GN1041@n2100.armlinux.org.uk>
References: <57b6f38c.23012e0a.374a0.56c6@mx.google.com>
 <20160819141251.5dcc835d@free-electrons.com>
 <20160819130846.GN1041@n2100.armlinux.org.uk>
Message-ID: <20160819132845.GP1041@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Aug 19, 2016 at 02:08:46PM +0100, Russell King - ARM Linux wrote:
> On Fri, Aug 19, 2016 at 02:12:51PM +0200, Thomas Petazzoni wrote:
> > Hello,
> > 
> > I'm adding Romain Perier in Cc, since he is actively working on the
> > CESA driver.
> 
> 4.7 here on Clearfog (Armada 388):
> 
> # cryptsetup benchmark --cipher aes-cbc
> # Tests are approximate using memory only (no storage IO).
> #  Algorithm | Key |  Encryption |  Decryption
>      aes-cbc   256b    67.1 MiB/s    68.3 MiB/s
> 
> /proc/interrupts:
>            CPU0       CPU1
>  42:       2144          0     GIC-0  51 Level     f1090000.crypto

With the coherency fix commit reverted (as mentioned in the bug report)
I get:

# cryptsetup benchmark --cipher aes-cbc
# Tests are approximate using memory only (no storage IO).
#  Algorithm | Key |  Encryption |  Decryption
     aes-cbc   256b    65.8 MiB/s    67.1 MiB/s

so not that different from before.  Run more than 10 times without issue.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
