From: greg@kroah.com (Greg KH)
Date: Mon, 16 May 2011 13:32:11 -0700
Subject: USB issue on Freescale's i.MX35 3-stack board
In-Reply-To: <56132A77AB93C141BF06E6B96CA6CFEA23CF08@039-SN1MPN1-004.039d.mgd.msft.net>
References: <56132A77AB93C141BF06E6B96CA6CFEA23CF08@039-SN1MPN1-004.039d.mgd.msft.net>
Message-ID: <20110516203211.GA17698@kroah.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, May 16, 2011 at 02:15:36PM +0000, Nguyen Dinh-R00091 wrote:
> Hi,
> 
> On the Freescale i.MX35 3DS board, there is a total of 256MB of DDR2
> and the configuration is 128MB on Chip-select 0 and 128MB on
> chip-select 1. So physically, the memory is not contiguous, so we boot
> up the system with these mem= parameters(mem=128M at 0x80000000
> mem=128M at 0x90000000). The system seems to be operating fine and passes
> stress testing using memtester and oprofile, except for USB.
> 
> Running a USB copy stress test on USB mass storage between a USB HDD
> and an SD/MMC card causes the system to hang. The hang can occur at
> any time between 10 minutes to 2 hours. The hang is much harder to
> re-create if logs or delays are introduced.

What kernel version are you using, and what host controller drivers?

thanks,

greg k-h
