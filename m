From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 2 Sep 2014 17:24:52 +0100
Subject: Formal license ambiguity in arch/arm/boot/dts/sun?i-a*.dts
In-Reply-To: <5405D74B.8090409@redhat.com>
References: <201408031959.27607.arnd@arndb.de> <20140804192510.GF3952@lukather>
 <20140804212317.GL30282@n2100.arm.linux.org.uk>
 <20140807132023.GG15297@lukather> <20140902102206.GU15297@lukather>
 <20140902104002.GN30401@n2100.arm.linux.org.uk>
 <20140902122716.GV15297@lukather> <5405B986.2080407@redhat.com>
 <20140902125116.GW15297@lukather> <5405D74B.8090409@redhat.com>
Message-ID: <20140902162452.GS30401@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Sep 02, 2014 at 04:42:19PM +0200, Hans de Goede wrote:
> Hi,
> 
> On 09/02/2014 02:51 PM, Maxime Ripard wrote:
> > On Tue, Sep 02, 2014 at 02:35:18PM +0200, Hans de Goede wrote:
> >>> So I guess like Chen-Yu suggested that we should change the license of
> >>> the DTSI first, and then the DTS. Otherwise, it wouldn't work very
> >>> well, I guess you can't really relicense a GPL-only file.
> >>
> >> IANAL, but mixing MIT (which I suggest use as the other license) and GPL
> >> files in one binary (the generated dtb file) is fine AFAIK, this happens
> >> all the time. The resulting binary is simple GPL licensed. So it would
> >> make sense to start with dual licensing new boards right away even before
> >> the dtsi has been relicensed. It won't make any practical difference
> >> until the dtsi is relicensed, but it means less work later on.
> > 
> > So you're allowed to licence derivative work of a GPL-licenced file
> > under both the GPL and another licence?
> 
> Since the board files do not start as copies of the dtsi file, but
> merely include it they are not derivative (IANAL), the resulting
> dtb file however very much is and as such is GPL only.

I'd also agree with the second half of what you said.

Let's take an example.  If a .dts file is licensed GPL and X11, but
a .dtsi it includes is licensed under the GPL, then the resulting
binary is definitely GPL-only - no questions asked.

If all the .dts and .dtsi files which are used to generate the .dtb
become licensed under the GPL and X11 licenses, then the resulting
.dtb itself becomes dual licensed.

If a .dtsi file is licensed under GPL and X11, but the .dts file is
only under the GPL, the result is GPL-only.

So, it's like a bitwise AND, with each license type being an
individual bit.

The first half is a more risky claim to make though - is the .dts file
itself something that could have been developed without the .dtsi?
Given that most .dts files reference things in the .dtsi files, I
believe the answer to that is no - which makes the .dts file a
derivative of the .dtsi.

What that would seem to imply is that the .dts files can't be dual
licensed until the .dtsi files it uses are dual licensed.

So, the "safe" approach here is to get the .dtsi files dual-licensed
first. :)

-- 
FTTC broadband for 0.8mile line: currently at 9.5Mbps down 400kbps up
according to speedtest.net.
