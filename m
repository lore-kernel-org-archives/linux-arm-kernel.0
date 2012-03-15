From: omar.ramirez@ti.com (Ramirez Luna, Omar)
Date: Thu, 15 Mar 2012 10:21:29 -0500
Subject: [PATCH v2 5/8] ARM: OMAP2+: hwmod: ensure that SYSCONFIG bits are
 reprogrammed after a reset
In-Reply-To: <alpine.DEB.2.00.1203150024260.7269@utopia.booyaka.com>
References: <20120228053524.16278.59430.stgit@dusk>
 <20120228053657.16278.76132.stgit@dusk>
 <CAB-zwWhAa3PprwDLzWLkBFUHPeJO3HN3M9mAZF=ohGTvP43jYA@mail.gmail.com>
 <alpine.DEB.2.00.1203150024260.7269@utopia.booyaka.com>
Message-ID: <CAB-zwWh3tcz5xUkzthH_AAsmeXfMieUW-SCQnAaXyfSg8khqvg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 15, 2012 at 1:25 AM, Paul Walmsley <paul@pwsan.com> wrote:
> Hola Omar,

Hola :)

> On Wed, 14 Mar 2012, Ramirez Luna, Omar wrote:
>
>> If we reached here the reset lines will be asserted, and then the code
>> below touches sysc registers on a module under reset.
>
> Do you know of any case where this would be a problem? ?Seems like it
> would only affect IP blocks that have both hard reset lines and SYSCONFIG
> registers, and as far as I know, we don't have any of those defined?

MMU (not yet mainlined) has both, a reset line and a sysconfig.

I have been holding the hwmod for some time, but now that
rpmsg/remoteproc is going to mainline it could make use of it along
with omap3isp, however now I need to define functions to handle the
reset lines (although I was fine with hwmod handling it).

AFAIKnew, hwmod handling the reset line was fine (IMHO), the only 2 things were:
- For the drivers to somehow make use of shutdown/enable if they
needed they hwmod under reset and out.
- The annoying: hwmod XX failed to hardreset because of the wrong
reset sequence but causing no functional issues.

Regards,

Omar
