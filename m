From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Mon, 20 Feb 2017 17:27:39 +0000
Subject: [PATCH v2 0/3] Extend rtc-armada38x support for Armada 7K/8K
In-Reply-To: <87tw7oaj24.fsf@free-electrons.com>
References: <20170217101907.8963-1-gregory.clement@free-electrons.com>
 <87tw7oaj24.fsf@free-electrons.com>
Message-ID: <20170220172739.GN21222@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Feb 20, 2017 at 06:06:11PM +0100, Gregory CLEMENT wrote:
> I saw on IRC than Russell managed to have a more coherent date with this
> series on his 8040 based board. For the record, as the U-Boot on this
> board didn't provide a "date reset" command for the RTC located on CP
> slave, then Russell needed to do the following:
> 
> devmem2 0xf428401c w 0
> devmem2 0xf4284018 w 0x2000
> followed by:
> date 021612342017; ntpdate ...; hwclock -uw
> 
> But this issue was related to the bootloader not to the kernel. The
> other potential issue seen by Russell was about the GIC mapping for the
> interrupt, but here again this mapping was done by the 1st stage
> bootloader.
> 
> Given this information would it be OK to applied this series?

No it is not.  As I already pointed out, the interrupt for the 8040 is
GIC_SPI 71 _not_ GIC_SPI 77 as you have it in this series.

Both CP110's on Armada 8040 have a default mapping of ICU 77 to GIC 71.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
