From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Mon, 1 Dec 2014 17:55:53 +0100
Subject: [GIT PULL] Allwinner DT for 3.19, bis
In-Reply-To: <201411281347.45210.arnd@arndb.de>
References: <20141123163413.GA5585@lukather> <201411281347.45210.arnd@arndb.de>
Message-ID: <20141201165553.GL25249@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Fri, Nov 28, 2014 at 01:47:44PM +0100, Arnd Bergmann wrote:
> On Sunday 23 November 2014, Maxime Ripard wrote:
> > Arnd, Kevin, Olof,
> > 
> > Here is the DT pull request for the Allwinner changes that replaces
> > the previous one.
> > 
> > The patch that was breaking the arm-soc boot has been dropped, and
> > will go through the clock tree.
> > 
> 
> Ok. I see that the change between the old and the new branch was the
> removal of two patches, so in order to preserve a nicer history,
> I undid my earlier revert of the entire branch (which was still on
> top) and instead just reverted the two patches, making sure that the
> contents are the same as your new branch afterwards.
> 
> I've also checked that the new branch makes the boot farm happy.
> 
> The part that is still bugging me is that you have apparently done
> an incompatible change to the DT binding without even mentioning
> which machines are affected or explaining why the compatibility
> break was preferrable.

This used to be one of the first clock that was merged, and we merged
it as two separates components (mux and divider), that are actually in
the same register.

This way of working made it so we had to share a lock across several
drivers and wasn't really reporting how the hardware was setup.

This was something that was on our todo-list for a while now, so,
yeah...

Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20141201/e91ad7bc/attachment.sig>
