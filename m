From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sun, 9 Dec 2012 09:51:38 +0000
Subject: Question2: Determine subarch type
In-Reply-To: <20121209105117.1f96e5c80560a8431a9eecee@mail.ru>
References: <20121209105117.1f96e5c80560a8431a9eecee@mail.ru>
Message-ID: <20121209095137.GF14363@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Dec 09, 2012 at 10:51:17AM +0400, Alexander Shiyan wrote:
> How can we determine the sub-architecture type from the driver code?
> For example, we are building a multi-platform kernel for subarch A and B.
> One of the drivers should be used for subarch A only, and can not be used for
> subarch B. So, we need to avoid load this driver for other sub-architectures.
> Of course, we can check all machines in the subarch with machine_is_xx() macro,
> but I think that this is not the best way to do it.
> Do we have another way to do this?

You control this by only registering the appropriate struct devices rather
than controlling this in the driver.
