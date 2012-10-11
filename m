From: linux@prisktech.co.nz (Tony Prisk)
Date: Fri, 12 Oct 2012 07:17:30 +1300
Subject: [RFC PATCH] ARM: vt8500: Convert arch-vt8500 to multiplatform
In-Reply-To: <201210110747.46682.arnd@arndb.de>
References: <1349939831-12939-1-git-send-email-linux@prisktech.co.nz>
 <CABjd4YzdwXmAeTrULWOGdFBg8xKXK4FN7fGJegjFZYmmxhrP2A@mail.gmail.com>
 <201210110747.46682.arnd@arndb.de>
Message-ID: <1349979450.16017.3.camel@gitbox>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 2012-10-11 at 07:47 +0000, Arnd Bergmann wrote:
> On Thursday 11 October 2012, Alexey Charkov wrote:
> > Does this imply that early printk won't be supported any longer, or am
> > I missing something?
> 
> You are correct. However, there is work under way to bring it back.
> If you want to keep it around in the meantime, you could let the user
> enable VT8500 either in MULTIPLATFORM or standalone using some Kconfig
> logic like:
> 
> choice "Platform selection"
> 
> ...
> 
> config VT8500_SINGLE
> 	bool "Via/Wondermedia VT8500 / WM8505 / WM8650"
> 
> ...
> 
> endchoice
> 
> ...
> 
> config VT8500
> 	bool "Via/Wondermedia VT8500 / WM8505 / WM8650" if ARCH_MULTIPLATFORM
> 	default VT8500_SINGLE
> 
> 	Arnd

Alexey (or anyone else),

Do you want it kept in the meantime?

I think the easiest way to add/keep it would be to create:

ARCH_VT8500_SINGLE (arm/Kconfig) and ARCH_VT8500_MULTI
(arch-vt8500/Kconfig) and have them both select ARCH_VT8500 as an option
to make drivers available.

Regards
Tony P
