From: linux@baker-net.org.uk (Adam Baker)
Date: Wed, 25 Apr 2012 23:45:07 +0100
Subject: [patch v2 3/3] kirkwood: Add iconnect support
In-Reply-To: <20120418213147.502692381@rtp-net.org>
References: <20120418211638.691400727@rtp-net.org>
 <20120418213147.502692381@rtp-net.org>
Message-ID: <201204252345.07721.linux@baker-net.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 18 April 2012, Arnaud Patard wrote:
> Add support for Iomega Iconnect system.
> 
> Signed-off-by: Arnaud Patard <arnaud.patard@rtp-net.org>
> 

Arnaud,

I have so far been unable to get a kernel to boot with your patches. I just 
get
 
Uncompressing Linux... done, booting the kernel.

then nothing even with earlyprintk in the cmd line.

I applied the patches to a recent clone of Linus' tree as they depend on other 
device tree work that isn't in the latest stable kernel - I haven't yet 
verified if that tree boots as if it were a RD88F6281 with your changes 
disabled so that is probably my next step.

I've also hit the issue of the stock U-Boot not supporting DTB so am running 
with
CONFIG_ARM_APPENDED_DTB=y
CONFIG_ARM_ATAG_DTB_COMPAT=y
Have you been using the latter option or are you just using the settings in 
your dtb file? I'm assuming that you are running with an initrd, so far I've 
been trying to run without one hence I was hoping to be able to set the rootfs 
location on the kernel command line.

Regards

AdamBaker
