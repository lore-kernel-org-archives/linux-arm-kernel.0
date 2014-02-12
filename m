From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 12 Feb 2014 19:07:56 +0100
Subject: [PATCH v2 0/9] ARM: multi-platform kconfig cleanup and mach-virt
 removal
In-Reply-To: <20140212171621.GI29132@mudshark.cambridge.arm.com>
References: <1392153119-23248-1-git-send-email-robherring2@gmail.com>
 <52FBAB51.4050401@arm.com>
 <20140212171621.GI29132@mudshark.cambridge.arm.com>
Message-ID: <44914279.FnJrZdyuux@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 12 February 2014 17:16:21 Will Deacon wrote:
> On Wed, Feb 12, 2014 at 05:11:45PM +0000, Marc Zyngier wrote:
> > On 12/02/14 16:53, Arnd Bergmann wrote:
> > > 
> > > On the topic of V6, we don't support CPU_V6T2 at all, though I assume that
> > > there is an ARM1156 core tile for integrator and realview, and we support
> > > running the V6/V6K parts with MMU turned off. Would all revisions of ARM1156
> > > work with CPU_V6K and !MMU?
> > 
> > CPU_V6 and !MMU should work. V6K might, but that requires close
> > inspection (WFE, SEV shouldn't be used in UP context)...
> 
> Well I can boot Debian on my 1136 r0p1 (no v6k) using a v6/v7 kernel, so the
> lack of MMU shouldn't change that.

I was more worried about ARM1156 not being a strict superset of V6K, i.e.
stuff other than the MMU missing from it that the kernel would rely on.

	Arnd
