From: cavokz@gmail.com (Domenico Andreoli)
Date: Sun, 12 Aug 2012 13:24:33 +0200
Subject: [PATCH V3] CS89x0 : Use ioread16/iowrite16 on all platforms
In-Reply-To: <20120517.190346.175685939436302276.davem@davemloft.net>
References: <1337274702-19536-1-git-send-email-jaccon.bastiaansen@gmail.com>
 <20120517.190346.175685939436302276.davem@davemloft.net>
Message-ID: <20120812112433.GA31699@glitch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 17, 2012 at 07:03:46PM -0400, David Miller wrote:
> From: Jaccon Bastiaansen <jaccon.bastiaansen@gmail.com>
> Date: Thu, 17 May 2012 19:11:42 +0200
> 
> > The use of the inw/outw functions by the cs89x0 platform driver
> > results in NULL pointer references on ARM platforms and
> > platforms that do not provide ISA-style programmed I/O accessors.
> > 
> > Using inw/outw also accesses the wrong address space on platforms
> > that have a PCI I/O space that is not identity-mapped into the
> > physical address space.
> > 
> > Signed-off-by: Jaccon Bastiaansen <jaccon.bastiaansen@gmail.com>
> 
> I could nit-pick more on this patch, but it's such a significant
> improvement I'm just going to apply this V3 as-is to net-next.

Is this going into v3.6 or v3.7?

cheers,
Domenico
