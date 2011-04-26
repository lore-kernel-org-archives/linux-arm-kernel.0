From: plagnioj@jcrosoft.com (Jean-Christophe PLAGNIOL-VILLARD)
Date: Tue, 26 Apr 2011 06:35:52 +0200
Subject: [PATCH v2 02/23] at91: Make Ethernet device common
In-Reply-To: <4DB5D686.5050208@bluewatersys.com>
References: <1303364535-11557-1-git-send-email-ryan@bluewatersys.com>
	<1303364535-11557-3-git-send-email-ryan@bluewatersys.com>
	<0D753D10438DA54287A00B027084269764D24302A7@AUSP01VMBX24.collaborationhost.net>
	<4DB5D686.5050208@bluewatersys.com>
Message-ID: <20110426043552.GH12904@game.jcrosoft.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08:16 Tue 26 Apr     , Ryan Mallon wrote:
> On 04/22/2011 11:02 AM, H Hartley Sweeten wrote:
> > On Wednesday, April 20, 2011 10:42 PM, Ryan Mallon wrote:
> >>
> >> Replace the individual Ethernet device code for each at91 variant with
> >> a single implementation in devices.
> >>
> >> Signed-off-by: Ryan Mallon <ryan@bluewatersys.com>
> >> ---
> >>
> >>  arch/arm/mach-at91/at572d940hf.c         |    4 +
> >>  arch/arm/mach-at91/at572d940hf_devices.c |   83 +++++++----------------
> >>  arch/arm/mach-at91/at91cap9.c            |    4 +
> >>  arch/arm/mach-at91/at91cap9_devices.c    |  103 ++++++++++------------------
> >>  arch/arm/mach-at91/at91rm9200.c          |    4 +
> >>  arch/arm/mach-at91/at91rm9200_devices.c  |  103 ++++++++++------------------
> >>  arch/arm/mach-at91/at91sam9260.c         |    4 +
> >>  arch/arm/mach-at91/at91sam9260_devices.c |  104 +++++++++++------------------
> >>  arch/arm/mach-at91/at91sam9263.c         |    4 +
> >>  arch/arm/mach-at91/at91sam9263_devices.c |  102 ++++++++++------------------
> >>  arch/arm/mach-at91/at91sam9g45.c         |    4 +
> >>  arch/arm/mach-at91/at91sam9g45_devices.c |  108 +++++++++++-------------------
> >>  arch/arm/mach-at91/devices.c             |   61 +++++++++++++++++
> >>  arch/arm/mach-at91/devices.h             |   10 +++
> >>  14 files changed, 309 insertions(+), 389 deletions(-)
> >>
> >> diff --git a/arch/arm/mach-at91/at572d940hf.c b/arch/arm/mach-at91/at572d940hf.c
> >> index a6b9c68..48c1ec2 100644
> >> --- a/arch/arm/mach-at91/at572d940hf.c
> >> +++ b/arch/arm/mach-at91/at572d940hf.c
> >> @@ -34,6 +34,8 @@
> >>  #include "generic.h"
> >>  #include "clock.h"
> >>  
> >> +extern void at572d940hf_init_devices(void);
> > 
> > You might consider moving this, and all the other similar externs, to the generic.h
> > header.  That's where all the other platform init functions are defined.
> 
> I put the externs in the .c files since that is the only place they are
> actually called from. What is the general consensus on this?
no I do not want to 1000 of export function again

with the new soc we do not need it anymore

Best Regards,
J.
