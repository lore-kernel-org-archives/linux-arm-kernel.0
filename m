From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 15 Feb 2013 21:58:23 +0000
Subject: [V2 0/8] usb: ehci: more bus glues as separate modules
In-Reply-To: <20130215180750.GA4525@kroah.com>
References: <1360923853-7875-1-git-send-email-manjunath.goudar@linaro.org>
 <201302151610.52523.arnd@arndb.de> <20130215180750.GA4525@kroah.com>
Message-ID: <201302152158.23446.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 15 February 2013, Greg KH wrote:
> > Alan, Greg: I realize that it's too late to take the entire series for
> > 3.9, but with the move of more ARM platforms to CONFIG_ARCH_MULTIPLATFORM,
> > it is now possible to enable OMAP, VT8500 and ORION concurrently, along
> > with the ones that are already moved out.
> > 
> > You should have a patch for OMAP, but that has not made it into linux-next
> > yet. It would be good to have at least two out the three I mentioned
> > merged into 3.9, in order to keep allyesconfig building, and take the
> > rest after the merge window, for integration into 3.10.
> 
> I have no idea what to do with ANY of these patches as they are all
> sent without proper changelog comments saying why they are needed, come
> in random series without proper ordering, get sent multiple times in the
> same series with no known differences between them, and probably other
> issues that I just don't even know about.
> 
> So I can't take these this late in the development process, sorry, that
> would be negligent of me.

Yes, as I said above I think we should only merge two of them for 3.9
in order to keep the bus glues that are now conflicting (omap, orion
and vt8500) working when you enable all of the EHCI back-ends.

These three are actually all pretty popular targets (vt8500 not yet so
much, but it's used in some of the new sub-$100 tablets and HDMI
stick computers), so I would actually expect that distros like
Debin will want to enable them all together.

The other patches are mainly there to solve the problem for all ARM
platforms so we don't have to deal with them one by one as we make
the remaining platforms multiplatform capable.

> Manjunath, please get this all working properly, as it is, I've deleted
> all of your patches from my "to-apply" queue for all of the above
> reasons.

Sorry for the time this is causing you, I'm still teaching Manjunath how
to follow all the processes and it took us a bit longer than expected
to get this far. I'll try to make this less painful for you with the rest
of the patches that should go into 3.10, and I'll send you the two
patches that I'd like to still see in 3.9 with a proper changelog
and in a form that applies on your usb-next branch.

	Arnd
