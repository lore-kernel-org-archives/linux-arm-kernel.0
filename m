From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 22 Jan 2013 09:43:30 +0000
Subject: [PATCH 4/4] ARM: apply the l2x0 Errata 769419 at run time
In-Reply-To: <20130122055916.GA22429@bnru10>
References: <20130121131709.GA29927@bnru10>
 <20130121161202.GR23505@n2100.arm.linux.org.uk>
 <20130122055916.GA22429@bnru10>
Message-ID: <20130122094330.GG23505@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 22, 2013 at 11:29:17AM +0530, Srinidhi Kasagar wrote:
> On Mon, Jan 21, 2013 at 17:12:02 +0100, Russell King - ARM Linux wrote:
> > Is it really worth this hastle, or would it just be better to keep the
> > ifdef there, using the configuration symbol as a way to indicate whether
> > we want this work-around included in the kernel, and always have the
> > wmb() there if the symbol is enabled?
> We can keep the ifdef there, my idea was to completely eliminate these
> CONFIG_PL310_ERRATA_*. The problem comes when you have a single defconfig
> for two platforms (ex, ST-E's 8500 and 8540) where one platform needs
> this and the other don't.

And the answer is... if you don't need it at all in the kernel, because
none of your platforms need it, you can eliminate it.  If one of your
platforms needs it, it's probably best to compile it in and make it
unconditional there.
