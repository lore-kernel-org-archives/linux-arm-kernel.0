From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 19 Mar 2014 22:05:32 +0100
Subject: [PATCH 44/62] ARM: integrator: refine CPU selection
In-Reply-To: <20140319204946.GK7528@n2100.arm.linux.org.uk>
References: <1395257399-359545-1-git-send-email-arnd@arndb.de>
 <1395257399-359545-45-git-send-email-arnd@arndb.de>
 <20140319204946.GK7528@n2100.arm.linux.org.uk>
Message-ID: <8120199.tJr1GuP6ec@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 19 March 2014 20:49:47 Russell King - ARM Linux wrote:
> On Wed, Mar 19, 2014 at 08:29:41PM +0100, Arnd Bergmann wrote:
> > This adds a new Kconfig option for the Integrator platform to
> > choose between ARMv4/ARMv5 based CPUs and those based on ARMv6/ARMv7,
> > which is required because we cannot have both classes enabled in the
> > same kernel at compile time.
> 
> Wouldn't it just be easier to make the older CPUs depend on
> !CPU_V6 && !CPU_V7 rather than trying to hack this for each platform?

It's only two platforms: integrator and realview. Actually I took two
different approaches on these, and wanted to make up my mind first
which one is better. Any suggestion?

I have a mild preference to always using 'select' on the CPU_* symbol
from the platform, mostly for consistency. The downside is that it
gets a little messy for Integrator, but that's just one platform in
the end.

At some point, I think I got into circular dependencies when one CPU
depended on another one being disabled, but I don't remember exactly
what case that was.

	Arnd
