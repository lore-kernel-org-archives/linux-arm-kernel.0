From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Sun, 3 Jul 2016 17:54:31 +0100
Subject: [RFC 0/1] ARM: print MHz in /proc/cpuinfo
In-Reply-To: <32b30c50-4712-568e-4044-9f533ca497b2@jonmasters.org>
References: <1465333713-14339-1-git-send-email-jon.mason@broadcom.com>
 <20160607221809.GP1041@n2100.armlinux.org.uk>
 <32b30c50-4712-568e-4044-9f533ca497b2@jonmasters.org>
Message-ID: <20160703165431.GL1041@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Jul 02, 2016 at 07:58:00PM -0400, Jon Masters wrote:
> Agreed. But we'll still be coming back to ensure this information is
> presented to users. I pointed out to ARM about 3-4 years ago that this
> was going to bite us. It is now biting us, and we will ensure that
> useless data is provided where it is on x86 for identical experience by
> users. That is unless or until x86 users do something else always. Our
> (separate) case will use DMI or ACPI for the same kind of data.

Right, so having read all your email, there's no reason why we couldn't
just print:

cpu MHz  : 99999999.999

and be done with it.  Sure, it doesn't reflect the reality, but if people
are going to be idiots with it, why not play their game with it to show
how stupid it is.

I don't buy "it's biting us" - I see no evidence of it actually "biting"
anyone.  No one has reported any failures in the last 20 years due to
this missing - and even so as I've already said, it would _not_ be a
regression because that information has never been provided on 32-bit
ARM.

Moreover, I asked what these applications were that are affected by the
lack of us providing this number.  I'm still waiting to hear that, and
I noticed that even you skipped over providing that information which I
asked for, instead giving a hand-wavey answer based on marketing (spit)
people doing stupid things.

Please, try to come up with a _technical_ justification.  I really don't
want to make decisions based on marketing shite which I completely and
utterly despise.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
