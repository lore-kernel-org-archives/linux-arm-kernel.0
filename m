From: andrew@lunn.ch (Andrew Lunn)
Date: Thu, 9 Jan 2014 17:55:57 +0100
Subject: [PATCH RFC RFT 0/2] ARM: Kirkwood: Synology DT files
In-Reply-To: <52CE312B.3060108@killerwolves.net>
References: <1389052027-16819-1-git-send-email-andrew@lunn.ch>
 <52CE312B.3060108@killerwolves.net>
Message-ID: <20140109165557.GB9681@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 09, 2014 at 03:18:35PM +1000, Ben Peddell wrote:
> On 07/01/14 09:47, Andrew Lunn wrote:
> > Request for Testing:
> > 
> > This patch adds support for around 30 different boards. Most .dts
> > files support a couple of different models. I don't have any of this
> > hardware. None of this is tested.
> 
> Tested by Ben Peddell <klightspeed@killerwolves.net> (specifically kirkwood-ds210.dts on DS211j)

Hi Ben

Thanks for testing. I will fix the gpo and send a v2 sometime. I
should also check if there are any more gpo's i have as gpio's.
 
> To get running on the stock bootloader, I needed to extend the 
> initramfs to fill the entire rd.gz flash partition, configure the 
> kernel to use the dtb appended to it, configure it to ignore the 
> information passed to it by the bootloader, and add the following 
> nodes to the dts:
> 
> /chosen {
> 	linux,initrd-start = <0x800040>;
> 	linux,initrd-end   = <0x940000>;
> };

Do you know why these initrd properties are needed?  There is only one
other board in mainline that requires this. I also wonder what
implications this has. u-boot has the capability of reading the initrd
from disc to RAM and passing its location to the kernel. By hard
coding these values, are we blocking that?

Thanks
	Andrew
