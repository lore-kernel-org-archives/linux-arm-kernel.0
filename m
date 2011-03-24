From: dmitry.torokhov@gmail.com (Dmitry Torokhov)
Date: Thu, 24 Mar 2011 00:57:27 -0700
Subject: [PATCH] Input: tca6416-keypad: Change to module_init()
In-Reply-To: <AANLkTincDenFBzk0sF48c=oJknAVnNnXjNr-uFOj5KQ7@mail.gmail.com>
References: <20110322153226.GC30303@linux-sh.org>
	<AANLkTimyxdcJ-eEke9x7X1zdiJNbFtncfv0=NzKjtAme@mail.gmail.com>
	<20110322155730.GD30303@linux-sh.org>
	<AANLkTi=Fjc2f837ifH152Rh8W0PfiZvViYaLe=8XZo4Z@mail.gmail.com>
	<20110322163144.GC2202@sirena.org.uk>
	<AANLkTiniBVWhSiNZMRYbO857D_Vj03KxH4qYqkVo-11J@mail.gmail.com>
	<20110322165907.GG22583@opensource.wolfsonmicro.com>
	<AANLkTin1jG36-EsvAk9o-KxdxaBBhx=5Rf+JMidjYqsT@mail.gmail.com>
	<20110323162021.GA26594@opensource.wolfsonmicro.com>
	<AANLkTincDenFBzk0sF48c=oJknAVnNnXjNr-uFOj5KQ7@mail.gmail.com>
Message-ID: <20110324075727.GB8990@core.coreip.homeip.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 24, 2011 at 12:38:21PM +0900, Magnus Damm wrote:
> On Thu, Mar 24, 2011 at 1:20 AM, Mark Brown
> <broonie@opensource.wolfsonmicro.com> wrote:
> > On Thu, Mar 24, 2011 at 01:04:31AM +0900, Magnus Damm wrote:
> >
> >> Sounds nice. Hopefully that will allow us to use module_init() in
> >> drivers instead of other initcall levels depending on bus type.
> >
> > None of this is anything to do with the bus type - it's to do with the
> > function of the devices within the system. ?Things that are required for
> > early init of the kernel get bumped up the list.
> 
> Hm, sorry for being unclear - I should have used the words "other
> initcall levels depending on the init order of the parent hardware
> bus". I'm referring to the state of things now without any patches
> from Grant.
> 
> I understand that early init code often are using different initcall
> levels to make sure they are getting initialized before other code.
> Initcalls can also be used to work around link order issues.
> 
> I can't however see the reason why a keypad driver needs to be
> initialized early on. I may be wrong, but I thought user space was the
> only consumer of input devices?
> 

SysRq is kind of a consumer, so there sometimes a desire to get keyboard
working as soon as possible. But even SysRq is initialized ad module_init
level, so I tend to agree that tca should simply use module_init.

-- 
Dmitry
