From: shc_work@mail.ru (Alexander Shiyan)
Date: Sun, 9 Dec 2012 13:55:51 +0400
Subject: Question2: Determine subarch type
In-Reply-To: <20121209095137.GF14363@n2100.arm.linux.org.uk>
References: <20121209105117.1f96e5c80560a8431a9eecee@mail.ru>
 <20121209095137.GF14363@n2100.arm.linux.org.uk>
Message-ID: <20121209135551.f26ed91782f759add2cdf603@mail.ru>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, 9 Dec 2012 09:51:38 +0000
Russell King - ARM Linux <linux@arm.linux.org.uk> wrote:

> On Sun, Dec 09, 2012 at 10:51:17AM +0400, Alexander Shiyan wrote:
> > How can we determine the sub-architecture type from the driver code?
> > For example, we are building a multi-platform kernel for subarch A and B.
> > One of the drivers should be used for subarch A only, and can not be used for
> > subarch B. So, we need to avoid load this driver for other sub-architectures.
> > Of course, we can check all machines in the subarch with machine_is_xx() macro,
> > but I think that this is not the best way to do it.
> > Do we have another way to do this?
> 
> You control this by only registering the appropriate struct devices rather
> than controlling this in the driver.

Yes, but if driver is compiled as module?

-- 
Alexander Shiyan <shc_work@mail.ru>
