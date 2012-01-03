From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 3 Jan 2012 11:03:37 +0000
Subject: Renaming MACH_TYPE_KINETIS_K60 into MACH_TYPE_KINETIS
In-Reply-To: <1325065882.1584.153.camel@skywanderer.emcraft.com>
References: <1325065882.1584.153.camel@skywanderer.emcraft.com>
Message-ID: <20120103110337.GM2914@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Dec 28, 2011 at 01:51:22PM +0400, Alexander Potashev wrote:
> Hi,
> 
> About three weeks ago I registered a machine type for the Freescale
> Kinetis K60 microcontroller. ( http://www.arm.linux.org.uk/developer/machines/list.php?id=3896 )
> 
> But later I realized that there should be a single machine type for all
> Freescale Kinetis MCUs (K10 through K70), because those MCUs are
> software-compatible. I tried to rename "kinetis_k60" to just "kinetis"
> at the page mentioned above, but the names of the CONFIG_* macro and the
> identifier name did not change.
> 
> I really do not want to register another machine type since it would be
> a mess having two machine types - one for Kinetis and another for
> Kinetis K60. Is it possible to change CONFIG_MACH_KINETIS_K60 to
> CONFIG_MACH_KINETIS and MACH_TYPE_KINETIS_K60 to MACH_TYPE_KINETIS in
> the database at http://www.arm.linux.org.uk/developer/machines/ ?

I notice that you sent me a very similar email on 24th December, which I
haven't responded to yet: given that it's the Christmas period, and
people take holidays, I think you're being a little hasty over your
resending.

In any case, yes, I can change it.  However, as has already been
pointed out, we're moving over to using device tree as the primary form
of platform differentiation.  With device tree, machine type numbers
are completely meaningless (and aren't actually used by the kernel.)

While I will fix the entry, I suspect that Arnd will now refuse to
merge any new SoC support for mainline which is not using the device
tree.
