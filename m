From: andrew@lunn.ch (Andrew Lunn)
Date: Sun, 3 Jul 2016 20:49:45 +0200
Subject: [RFC 0/1] ARM: print MHz in /proc/cpuinfo
In-Reply-To: <20160703165431.GL1041@n2100.armlinux.org.uk>
References: <1465333713-14339-1-git-send-email-jon.mason@broadcom.com>
 <20160607221809.GP1041@n2100.armlinux.org.uk>
 <32b30c50-4712-568e-4044-9f533ca497b2@jonmasters.org>
 <20160703165431.GL1041@n2100.armlinux.org.uk>
Message-ID: <20160703184945.GB9421@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Jul 03, 2016 at 05:54:31PM +0100, Russell King - ARM Linux wrote:
> On Sat, Jul 02, 2016 at 07:58:00PM -0400, Jon Masters wrote:
> > Agreed. But we'll still be coming back to ensure this information is
> > presented to users. I pointed out to ARM about 3-4 years ago that this
> > was going to bite us. It is now biting us, and we will ensure that
> > useless data is provided where it is on x86 for identical experience by
> > users. That is unless or until x86 users do something else always. Our
> > (separate) case will use DMI or ACPI for the same kind of data.
> 
> Right, so having read all your email, there's no reason why we couldn't
> just print:
> 
> cpu MHz  : 99999999.999

Since it is a float, how about using the value NaN? I think that
nicely summaries it is a useless value.

However, i agree, we first need a technical justification for needing
a value at all.

Jon: What happened when you posted a patch removing this value from
x86? That is clearly an alternative to adding it to ARM, especially if
everybody agrees it is a useless value.

  Andrew
