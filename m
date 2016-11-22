From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Tue, 22 Nov 2016 11:54:57 +0000
Subject: [RFC PATCH 09/11] ARM: NOMMU: define SECTION_xxx macros
In-Reply-To: <58343121.4030906@arm.com>
References: <1479806768-39911-1-git-send-email-vladimir.murzin@arm.com>
 <1479806768-39911-10-git-send-email-vladimir.murzin@arm.com>
 <20161122100713.GW1041@n2100.armlinux.org.uk>
 <58343121.4030906@arm.com>
Message-ID: <20161122115456.GX1041@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 22, 2016 at 11:50:57AM +0000, Vladimir Murzin wrote:
> On 22/11/16 10:07, Russell King - ARM Linux wrote:
> > On Tue, Nov 22, 2016 at 09:26:06AM +0000, Vladimir Murzin wrote:
> >> Pickup defines from pgtable-2level.h to make NOMMU build happy.
> > 
> > This needs more detail.
> > 
> 
> It comes from
> 
>   CC      arch/arm/kernel/setup.o
> arch/arm/kernel/setup.c: In function 'reserve_crashkernel':
> arch/arm/kernel/setup.c:1001:25: error: 'SECTION_SIZE' undeclared (first use in this function)
>              crash_size, SECTION_SIZE);
>                          ^
> arch/arm/kernel/setup.c:1001:25: note: each undeclared identifier is reported only once for each function it appears in
> make[1]: *** [arch/arm/kernel/setup.o] Error 1
> make: *** [arch/arm/kernel] Error 2

Hmm, I decided not to use CRASH_ALIGN there because I didn't want to
break anyone's existing setup unnecessarily, however arguably it
should be CRASH_ALIGN to ensure that the new kernel is properly
positioned.

I wonder if we can get away with changing that, rather than
unnecessarily introducing these otherwise meaningless definitions
for R-class.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
