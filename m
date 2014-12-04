From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 04 Dec 2014 16:06:22 +0100
Subject: [PATCH v7 08/11] arm/arm64: Unexport restart handlers
In-Reply-To: <54807505.2000406@roeck-us.net>
References: <1408495538-27480-1-git-send-email-linux@roeck-us.net>
 <CAMuHMdX-WsVErpiZ_EbFSGxeJEfpu3cRaZzitupiSAA2hXEJ8g@mail.gmail.com>
 <54807505.2000406@roeck-us.net>
Message-ID: <3875532.ABOh5kXkPb@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 04 December 2014 06:51:49 Guenter Roeck wrote:
> On 12/04/2014 06:44 AM, Geert Uytterhoeven wrote:
> > On Thu, Dec 4, 2014 at 3:26 PM, Guenter Roeck <linux@roeck-us.net> wrote:
> >> On 12/04/2014 05:36 AM, Geert Uytterhoeven wrote:
> >>> On Wed, Aug 20, 2014 at 2:45 AM, Guenter Roeck <linux@roeck-us.net> wrote:
> >>>> Implementing a restart handler in a module don't make sense
> >>>> as there would be no guarantee that the module is loaded when
> >>>> a restart is needed. Unexport arm_pm_restart to ensure that
> >>>> no one gets the idea to do it anyway.
> >>>
> >>> Why not? I was just going to do that, but I got greeted by:
> >>
> >> Because you should register a restart handler instead, like the other
> >> drivers in the same directory now do.
> >
> > That's a different thing. "there would be no guarantee that the module is
> > loaded when a restart is needed" is also valid for restart handlers...
> >
> 
> Not really, because you are supposed to unregister the restart handler
> on unload. Sure, you can instead clear arm_pm_reastart and leave the system
> with no means to restart ...

I agree with Geert that your commit message was confusing, it sounds like
you were referring to drivers that are not yet loaded, while the problem
that you are really address is drivers that have been unloaded later.

	Arnd
