From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 8 Feb 2011 17:47:18 +0100
Subject: [PATCH v2] ARM: Define wfi() macro for v6 processors
In-Reply-To: <20110208162515.GB6188@n2100.arm.linux.org.uk>
References: <1297162885-2975-1-git-send-email-dave.martin@linaro.org>
	<201102081615.15713.arnd@arndb.de>
	<20110208162515.GB6188@n2100.arm.linux.org.uk>
Message-ID: <201102081747.18674.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 08 February 2011 17:25:16 Russell King - ARM Linux wrote:
> On Tue, Feb 08, 2011 at 04:15:15PM +0100, Arnd Bergmann wrote:
> > But that doesn't work if you build a combined v5/v6/v7 kernel, because
> > v5 supports neither form, right? I think to do that, it needs the
> > same kind of abstraction that we have for a number of other things
> > like cache management in arch/arm/mm/.
> 
> The options are kernels which support v3-v5 or v6-v7.  There's too big
> a change between v5 and v6 to combine those into one kernel.

Ah, good to know. I never realized this with the common binary discussions.
Building for the versatile/realview platform makes it possible to select
any of ARM926 and the v6/v6k/v7 CPUs, as well as ARM7TDMI in the same
kernel config, so I assumed that this was actually a valid configuration
aside from bugs.

Would an attempt to make a combined v5/v6 kernel result in unacceptably
bad code, or is this just too much work for anyone to be bothered with
and little practical value?

	Arnd
