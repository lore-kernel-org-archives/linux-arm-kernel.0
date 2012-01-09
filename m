From: plagnioj@jcrosoft.com (Jean-Christophe PLAGNIOL-VILLARD)
Date: Mon, 9 Jan 2012 18:09:09 +0100
Subject: [PATCH 1/2] at91 : move pm.h header to arch/arm/include/asm
In-Reply-To: <20120109164855.GK2854@game.jcrosoft.org>
References: <1325864915-794-1-git-send-email-daniel.lezcano@linaro.org>
 <201201061730.33525.arnd.bergmann@linaro.org>
 <4F0ACD35.1000600@linaro.org>
 <20120109112920.GJ21765@n2100.arm.linux.org.uk>
 <4F0AF198.1030803@linaro.org>
 <20120109144443.GQ21765@n2100.arm.linux.org.uk>
 <20120109164855.GK2854@game.jcrosoft.org>
Message-ID: <20120109170909.GL2854@game.jcrosoft.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 17:48 Mon 09 Jan     , Jean-Christophe PLAGNIOL-VILLARD wrote:
> On 14:44 Mon 09 Jan     , Russell King - ARM Linux wrote:
> > On Mon, Jan 09, 2012 at 02:54:32PM +0100, Daniel Lezcano wrote:
> > > On 01/09/2012 12:29 PM, Russell King - ARM Linux wrote:
> > > > On Mon, Jan 09, 2012 at 12:19:17PM +0100, Daniel Lezcano wrote:
> > > >> Actually, the header moves from :
> > > >>
> > > >> 	arch/arm/mach-at91/pm.h
> > > >> to:
> > > >> 	arch/arm/include/asm/at91_pm.h.
> > > >>
> > > >> This place and the renaming of the file complies with the comments of
> > > >> Russell,
> > > > 
> > > > No it doesn't.  There's absolutely no way in hell I want arch/arm/include/asm
> > > > to be littered with hundreds of crappy platform specific header files.
> > > 
> > > Ok. Actually there are 9 pm.h files but I agree with a domino effect we
> > > can have more header files brought to this directory like "control.h",
> > > "powerdomain.h", etc ...
> > > 
> > > Does it make sense to merge all the pm.h file in a single pm.h which
> > > will be located in arch/arm/include/asm ?
> > 
> > No it doesn't.  If moving something out of arch/arm means that we have to
> > buggerize the header files, then moving it out of arch/arm is the wrong
> > thing to do.  What the need to bugger about with header files is telling
> > you is that the code you're moving (in its existing form) is intimitely
> > tied to the SoC.
> > 
> > There's two solutions to that: either leave it where it is, or first
> > sort out why it's intimitely tied, and what can be done to remove its
> > dependence on the SoC.
> > 
> > I've finally taken a deeper look at what's going on here... 
> > 
> > arch/arm/mach-at91/pm.h is full of crap:
> I work on it but work on other clean up first
this code need to be clean with the pm_slowclock.S too to support multiple soc

and we need to drop the at91_sys_read/write stuff too

I work on this right now

Best Regards,
J.
