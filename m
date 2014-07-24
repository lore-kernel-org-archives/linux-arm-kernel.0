From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Thu, 24 Jul 2014 13:20:36 +0200
Subject: [PATCH 00/14] clk: sunxi: Improve MMC clocks support
In-Reply-To: <53CA4CCA.5040303@redhat.com>
References: <1405588134-2396-1-git-send-email-maxime.ripard@free-electrons.com>
 <53CA4CCA.5040303@redhat.com>
Message-ID: <20140724112036.GS20328@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Hans,

On Sat, Jul 19, 2014 at 12:47:38PM +0200, Hans de Goede wrote:
> Hi,
> 
> On 07/17/2014 11:08 AM, Maxime Ripard wrote:
> >Hi everyone,
> >
> >Here is an attempt at improving the MMC clock support in the Allwinner
> >SoCs.
> >
> >Until now, the MMC clocks were having a custom phase function that was
> >directly setting an obscure value in the right register, because we
> >were not really having any idea of what these values were.
> >
> >Now that we have more informations, we can introduce a common function
> >call to get and set the phase of a particular clock, and use this in
> >both our provider and our client.
> >
> >Another issue we had so far on the A13 was that, out of reset, the
> >PLL6 driving the MMC was running too high to be working. We can solve
> >that by adding two new properties in the DT to setup the rate
> >constraints we might have on a clock.
> 
> Looks good to me, thanks for working on this.
> 
> Question have you dumped the raw mmc0 clk reg before and after this
> patch set to verify that the end result is the same ?

I did at 100MHz, but I was missing other test cases, so more testing
at the various other frequencies we might run at would be very much
welcome (and some cross-testing).

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140724/57a6cf15/attachment.sig>
