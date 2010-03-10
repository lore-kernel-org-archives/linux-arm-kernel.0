From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 10 Mar 2010 17:46:50 +0000
Subject: [PATCH 2.6.34] ARM: SAMSUNG: Fix build after "ARM: Eliminate
	decompressor -Dstatic= PIC hack"
In-Reply-To: <20100310174228.GA5060@rakim.wolfsonmicro.main>
References: <1267469542-19633-1-git-send-email-broonie@opensource.wolfsonmicro.com>
	<20100310171736.GJ6850@sirena.org.uk>
	<20100310172503.GB12345@n2100.arm.linux.org.uk>
	<20100310174228.GA5060@rakim.wolfsonmicro.main>
Message-ID: <20100310174650.GD12345@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 10, 2010 at 05:42:28PM +0000, Mark Brown wrote:
> On Wed, Mar 10, 2010 at 05:25:03PM +0000, Russell King - ARM Linux wrote:
> > On Wed, Mar 10, 2010 at 05:17:37PM +0000, Mark Brown wrote:
> 
> > > This is now required in mainline (2.6.34-rc1 fails to build) - given the
> > > severity and lack of response I'm just going to go ahead and send it to
> > > the patch tracker, hope that's OK.
> 
> > Why is error() being declared in this header file?
> 
> IIRC (it's a little while since I grovelled through) it's being used by
> some of the S3C specific code for error reporting as well and the
> declaration/definition from the generic code wasn't visible at the
> point that code was built.  Clearly not having this second, platform
> specific declaration would be a better approach but due to the urgency
> and closeness to release I went with a minimally invasive one line edit
> in order to reduce the risk of possible side effects.

Let's do the job properly this time then and put a declaration in
compressed/misc.c
