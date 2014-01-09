From: alex.elder@linaro.org (Alex Elder)
Date: Thu, 09 Jan 2014 07:09:03 -0600
Subject: [GIT PULL] bcm driver updates for 3.14
In-Reply-To: <CAEPRUYpZTTX8bB68V5WMzBroj+arADsbbmXVSgBtn0At1SmRmw@mail.gmail.com>
References: <CAEPRUYpgHhrVCoRAzF_WbQZGTpwSahQq8G40+9=pf36-n9V_hg@mail.gmail.com>	<20140109060432.GC8285@quad.lixom.net>
 <CAEPRUYpZTTX8bB68V5WMzBroj+arADsbbmXVSgBtn0At1SmRmw@mail.gmail.com>
Message-ID: <52CE9F6F.8000507@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/09/2014 01:52 AM, Christian Daudt wrote:
> On Wed, Jan 8, 2014 at 10:04 PM, Olof Johansson <olof@lixom.net> wrote:
>> On Sun, Jan 05, 2014 at 10:58:36PM -0800, Christian Daudt wrote:
>>> The following changes since commit 319e2e3f63c348a9b66db4667efa73178e18b17d:
>>>
>>>   Linux 3.13-rc4 (2013-12-15 12:31:33 -0800)
>>>
>>> are available in the git repository at:
>>>
>>>   git://github.com/broadcom/bcm11351.git tags/bcm-for-3.14-drivers
>>
>> Hi,
>>
>> Is there a reason you're sending this through arm-soc instead of through Mike's
>> clk tree? I don't see any dependencies on SoC code so I think it can go
>> independently through clk?
>>
>>
>> -Olof
> The reason for the clk patches is that the file
> include/dt-bindings/clock/bcm281xx.h is  used both by the driver and
> the by the bcm11351.dtsi file (which has other mods going through
> arm-soc). But now that you mentioned it, I looked and didn't find the
> patch that modifies dts to include it. Alex - did I miss it?

Yes you did.  Or I guess I may have, or may not have communicated
the situation adequately.

There were four commits:
    clk: bcm281xx: define kona clock binding
    clk: bcm281xx: add initial clock framework support
    clk: bcm281xx: define U32_MAX conditionally for now
and
    ARM: dts: bcm281xx: define real clocks

The first one is in your tagged branch "bcm-for-3.14-dt".
The second two are in "bcm-for-3.14-drivers".  The last one
is missing.

HOWEVER there's more to it than that.  My DT change depended
on both code and DT changes from Tim Kryger--from another
series you were trying to coordinate taking through your tree.
    https://lkml.org/lkml/2013/12/5/508
And because those seem to be missing from your tree we can't
just use the DT patch as-is.  As I understand it we have been
waiting for one unresponsive maintainer on that series (but
I haven't been following closely).

For what it's worth, the DT patch is available here:
    git://git.linaro.org/landing-teams/working/broadcom/kernel.git
as the last commit in branch "pull/csd-kona-clocks".

But to get this resolved we have to either:
- include Tim's series in the pull request;
- update my DT file to *not* define clocks affected by
  Tim's series;
- or make a trivial update to my code so it does *not*
  disable unused clocks.

(Or maybe something else.)

I'm here to help and can respond quickly.  Christian and Tim are
on the US West coast so it'll be a few hours before they're around
to help out.

					-Alex
