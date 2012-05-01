From: linux@baker-net.org.uk (Adam Baker)
Date: Tue, 1 May 2012 23:55:38 +0100
Subject: [patch v2 3/3] kirkwood: Add iconnect support
In-Reply-To: <878vhdbtk1.fsf@lebrac.rtp-net.org>
References: <20120418211638.691400727@rtp-net.org>
 <201204300011.17388.linux@baker-net.org.uk>
 <878vhdbtk1.fsf@lebrac.rtp-net.org>
Message-ID: <201205012355.38598.linux@baker-net.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 30 April 2012, Arnaud Patard wrote:
> Adam Baker <linux@baker-net.org.uk> writes:
> 
> Hi,
> 
> > On Thursday 26 April 2012, Arnaud Patard wrote:
> >> Adam Baker <linux@baker-net.org.uk> writes:
> >> 
> >> Hi,
> >> 
> >> > On Wednesday 18 April 2012, Arnaud Patard wrote:
> >> >> Add support for Iomega Iconnect system.
> >> >> 
> >> >> Signed-off-by: Arnaud Patard <arnaud.patard@rtp-net.org>
> >> > 
> >> > Arnaud,
> >> > 
> >> > I have so far been unable to get a kernel to boot with your patches. I
> >> > just get
> >> > 
> >> > Uncompressing Linux... done, booting the kernel.
> >> 
> >> hm. sounds weird. Are you sure that you have the DTB appended to your
> >> kernel image ?
> > 
> > Yes, if I don't append the DTB and I set ArcNumber to 1682 then it boots
> > using the ref board setup, if the DTB is appended then it doesn't boot
> > (I configured the kernel to support iconnect, dreamplug and RD-88F6281)
> 
> hm. ok. Can you provide your uImage/kernel config/modules/ and which
> sources you've used... so that I can try to reproduce / boot your kernel?
> 

Arnaud has spotted that my kernel config was missing CONFIG_SERIAL_OF_PLATFORM 
which is why I was getting no output from it. After fixing that I've got a 
working system, therefore

Tested-By: Adam Baker <linux@baker-net.org.uk>

I have verified that all of the LED options work, that the reset and OTB 
buttons generate the expected codes (I think the reason Iomega chose odd SW_ 
values is simply those are the first 2 defined values in linux/input.h) and that 
the mtd partitions start at the correct offsets for what they claim to contain 
(although the last one might make more sense called root rather than boot). 
I've verified that the WLAN interface works but not tested wired ethernet.

Unfortunately CONFIG_SERIAL_OF_PLATFORM has dependencies so it wouldn't be a 
good idea for CONFIG_MACH_ICONNECT_DT to select it. There could be some value 
in it making the default value for CONFIG_SERIAL_OF_PLATFORM=y.

Regards

Adam
