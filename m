From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Sun, 18 Dec 2016 23:40:53 +0000
Subject: [PATCH] ARM: disallow ARM_THUMB for ARMv4 builds
In-Reply-To: <CAKv+Gu_KTB+EyQw6-DHEAgswCDvxJTpwH0pJ+ZqB4vz30jrNLA@mail.gmail.com>
References: <20161216091457.2452987-1-arnd@arndb.de>
 <CAKv+Gu93Gtkh7spA-HUHNKSmDjhK_nuwR9KaDu8=S2GDyhUJCA@mail.gmail.com>
 <4112999.Nl7pxYH1YF@wuerfel>
 <CAKv+Gu_1zbAB45SQ=702_v3H=RetLFsgknmp52iTSV9M4GSqHg@mail.gmail.com>
 <20161218141630.GP14217@n2100.armlinux.org.uk>
 <CAKv+Gu_KTB+EyQw6-DHEAgswCDvxJTpwH0pJ+ZqB4vz30jrNLA@mail.gmail.com>
Message-ID: <20161218234053.GQ14217@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Dec 18, 2016 at 03:04:24PM +0000, Ard Biesheuvel wrote:
> The only issue I spotted is that the kuser_get_tls routine has only
> two instruction slots for the return sequence, but we can easily work
> around that by moving the TLS hardware instruction around in the
> template (and update the memcpy accordingly in kuser_init()

You can't actually - everything in this page is ABI, and moving
that breaks the ABI.

One thing I'm toying with is splitting out the kuser helpers.  That
means we can build it according to the configuration, and select the
appropriate version at run time.  Work in progress.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
