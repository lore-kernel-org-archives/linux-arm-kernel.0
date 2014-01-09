From: matt.porter@linaro.org (Matt Porter)
Date: Thu, 9 Jan 2014 09:50:07 -0500
Subject: [GIT PULL] bcm driver updates for 3.14
In-Reply-To: <52CE9F6F.8000507@linaro.org>
References: <CAEPRUYpgHhrVCoRAzF_WbQZGTpwSahQq8G40+9=pf36-n9V_hg@mail.gmail.com>
 <20140109060432.GC8285@quad.lixom.net>
 <CAEPRUYpZTTX8bB68V5WMzBroj+arADsbbmXVSgBtn0At1SmRmw@mail.gmail.com>
 <52CE9F6F.8000507@linaro.org>
Message-ID: <20140109145007.GV10935@beef>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 09, 2014 at 07:09:03AM -0600, Alex Elder wrote:
> On 01/09/2014 01:52 AM, Christian Daudt wrote:
> > On Wed, Jan 8, 2014 at 10:04 PM, Olof Johansson <olof@lixom.net> wrote:
> >> On Sun, Jan 05, 2014 at 10:58:36PM -0800, Christian Daudt wrote:
> >>> The following changes since commit 319e2e3f63c348a9b66db4667efa73178e18b17d:
> >>>
> >>>   Linux 3.13-rc4 (2013-12-15 12:31:33 -0800)
> >>>
> >>> are available in the git repository at:
> >>>
> >>>   git://github.com/broadcom/bcm11351.git tags/bcm-for-3.14-drivers
> >>
> >> Hi,
> >>
> >> Is there a reason you're sending this through arm-soc instead of through Mike's
> >> clk tree? I don't see any dependencies on SoC code so I think it can go
> >> independently through clk?
> >>
> >>
> >> -Olof
> > The reason for the clk patches is that the file
> > include/dt-bindings/clock/bcm281xx.h is  used both by the driver and
> > the by the bcm11351.dtsi file (which has other mods going through
> > arm-soc). But now that you mentioned it, I looked and didn't find the
> > patch that modifies dts to include it. Alex - did I miss it?
> 
> Yes you did.  Or I guess I may have, or may not have communicated
> the situation adequately.
> 
> There were four commits:
>     clk: bcm281xx: define kona clock binding
>     clk: bcm281xx: add initial clock framework support
>     clk: bcm281xx: define U32_MAX conditionally for now
> and
>     ARM: dts: bcm281xx: define real clocks
> 
> The first one is in your tagged branch "bcm-for-3.14-dt".
> The second two are in "bcm-for-3.14-drivers".  The last one
> is missing.
> 
> HOWEVER there's more to it than that.  My DT change depended
> on both code and DT changes from Tim Kryger--from another
> series you were trying to coordinate taking through your tree.
>     https://lkml.org/lkml/2013/12/5/508
> And because those seem to be missing from your tree we can't
> just use the DT patch as-is.  As I understand it we have been
> waiting for one unresponsive maintainer on that series (but
> I haven't been following closely).

To clarify, we've been expecting an ack from Chris Ball on the sdhci
patch all along. When that didn't come, the
"ARM: dts: bcm281xx: define real clocks" had to be dropped. The fallout
is that the original reason for taking the clk driver through arm-soc
for 3.14 is no longer valid.

Ideally we'd love an 11th hour ack and be able to use the common clock
driver in 3.14 but we can carry that to 3.15.

-Matt
