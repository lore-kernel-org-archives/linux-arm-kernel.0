From: horms@verge.net.au (Simon Horman)
Date: Fri, 15 Jul 2016 13:13:44 +0900
Subject: [PATCH 1/2] arm: plug a zImage corner case
In-Reply-To: <E1bL9rj-0002Ow-6i@e0050434b2927.dyn.armlinux.org.uk>
References: <20160707102003.GO1041@n2100.armlinux.org.uk>
 <E1bL9rj-0002Ow-6i@e0050434b2927.dyn.armlinux.org.uk>
Message-ID: <20160715041343.GC28151@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 07, 2016 at 03:01:19PM +0100, Russell King wrote:
> If a zImage is built with ARM_APPENDED_DTB enabled, the zImage will
> look at the word following the zImage and check whether it contains
> the DTB magic number.
> 
> Generally, kexec will clear the destination pages before copying the
> zImage, but there is a corner case where the zImage is a multiple of
> the page size, where the following page will not be touched.  Should
> the first word in this page contain the DTB magic number, the data
> following will be interpreted as a DTB image.
> 
> In order to make this bullet-proof, we must always initialise the word
> following the zImage.  Arrange this by specifying the zImage memory
> size one word bigger than the buffer size.
> 
> Signed-off-by: Russell King <rmk@armlinux.org.uk>

Thanks, I have applied this and the next patch.
