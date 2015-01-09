From: catalin.marinas@arm.com (Catalin Marinas)
Date: Fri, 9 Jan 2015 15:13:43 +0000
Subject: [Linaro-acpi] [PATCH v5 18/18] Documentation: ACPI for ARM64
In-Reply-To: <3341506.a2BFqPNg3k@wuerfel>
References: <1413553034-20956-1-git-send-email-hanjun.guo@linaro.org>
 <1610983.9vqJdsL27R@wuerfel>
 <20150109103307.GC24408@e104818-lin.cambridge.arm.com>
 <3341506.a2BFqPNg3k@wuerfel>
Message-ID: <20150109151342.GE24408@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jan 09, 2015 at 10:55:51AM +0000, Arnd Bergmann wrote:
> On Friday 09 January 2015 10:33:07 Catalin Marinas wrote:
> > On Wed, Jan 07, 2015 at 07:48:48PM +0000, Arnd Bergmann wrote:
> 
> > > In other cases that's actually a good thing. One such example is the
> > > "Principles of ARM Memory Maps" document that tells hardware implementers
> > > to do a rather complex mapping "To support 36-bit x86 PAE compatible operating
> > > systems, such as Linux." but makes life much harder in the process than
> > > any of the random mappings we have seen in the wild.
> > 
> > Unfortunately, with any significant amount of RAM (say 16GB), this
> > document becomes pretty useless. It basically forces you to have a very
> > sparse physical address map from 0 to over 40-bit. I wouldn't apply the
> > ARM memory maps doc to server systems.
> 
> Are you sure? I was under the impression that this document was targetted
> specifically at servers.

Ah, sorry for the confusion, I haven't read the latest (apparently from
2012) update which covers 44 and 48-bit memory maps.

The only downside is that for more than 32GB of RAM (up to 512GB) it
requires a 40-bit memory map. Given the sparseness, we can't use
3-levels of page table with 4KB pages which can only cover 39-bit.
Anyway, not a major issue.

-- 
Catalin
