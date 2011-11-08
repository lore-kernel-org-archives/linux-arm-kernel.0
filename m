From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 8 Nov 2011 13:37:44 +0000
Subject: Error for machine_is_m28evk
In-Reply-To: <20111108125346.GA7563@S2100-06.ap.freescale.net>
References: <CAOMZO5C4=ELWef8keoT8u0H8jTPRGQ5BA_8xYyKge++s+wdNqw@mail.gmail.com>
 <4EB8CC7B.5060503@denx.de> <20111108075349.GK2854@pengutronix.de>
 <CAB4PhKeKdGLa74W-n1DNbUcszWMf3nymqqhuzdZoj_oQG+YNsg@mail.gmail.com>
 <20111108085350.GX12913@n2100.arm.linux.org.uk>
 <20111108125346.GA7563@S2100-06.ap.freescale.net>
Message-ID: <20111108133744.GE12913@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 08, 2011 at 08:53:47PM +0800, Shawn Guo wrote:
> On Tue, Nov 08, 2011 at 08:53:50AM +0000, Russell King - ARM Linux wrote:
> [...]
> > 
> > Maybe the answer is to just update the file anyway, and ignore peoples
> > complaints that their entries aren't present until they come to their
> > senses and start COMMUNICATING properly about issues they have with
> > their fscked up entry in the database.
> > 
> So I assume that you will update mach-types for -rc2.  Otherwise,
> please let me know, and I will send a patch to disable m28evk build
> from mxs_defconfig for -rc2.

Well, I chickened out of doing it in September.  We're now in November,
and even more entries will be deleted (because they've been lost off
the back end of the 12 month rule.)

Maybe it would be much easier to reduce the 12 month rule down to 4
months (to cover one kernel cycle and a little bit more) so that people
then know that they _have_ to talk to me.  Or maybe we just don't include
anything at all which doesn't appear in mainline.

Or maybe I get Arnd to run a script over the arm-soc tree regularly and
send me an email, which'll mean I'll have to _manually_ update the
database with what's in mainline.  (With the new security arrangements
with kernel.org, I can't even get *easy* access to the arm-soc tree to
just run a script over it to find what's been added.)

This task was soo much easier when most stuff was flowing through my
tree, because I'd then have the majority of new platforms, and therefore
know what was required.

Whatever way you look at it, this is a hard problem to solve given the
distributed nature of git trees.

Well, I guess we're at -rc1, and _now_ would be a good time to delete
the entries and stuff it in to linux-next.  That will give people a chance
to notice that they're gone - though:

(a) I have _ZERO_ confidence that people still won't shout at me for not
    telling them personally that I've deleted their entry.
(b) with the loss of facilities like kautobuild (no one noticed for six
    months that simtec had shut it down...), we have lost any kind of
    automated detection for these kinds of issues.

So, I guess I'm just going to not give a damn about stuff which gets
removed.  Which includes ALSA using machine_is_xxx() for platforms which
aren't currently merged.
