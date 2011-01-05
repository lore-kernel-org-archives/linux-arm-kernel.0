From: nm@ti.com (Nishanth Menon)
Date: Wed, 05 Jan 2011 07:32:58 -0600
Subject: [PATCH 0/2] OMAP: TWL: sparse fixes
In-Reply-To: <20110105002549.GA1445@n2100.arm.linux.org.uk>
References: <1294081110-23695-1-git-send-email-nm@ti.com>
	<20110103223656.GA8414@n2100.arm.linux.org.uk>
	<4D22503F.9060100@ti.com> <4D238503.6070103@ti.com>
	<20110105002549.GA1445@n2100.arm.linux.org.uk>
Message-ID: <4D24730A.3050905@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Russell King - ARM Linux wrote, on 01/04/2011 06:25 PM:
> On Tue, Jan 04, 2011 at 02:37:23PM -0600, Nishanth Menon wrote:
>> hmm.. minor nit (with codesourcery 2010.09-50 - 4.5.1):
>> rm arch/arm/mach-omap2/*.o;make C=1 arch/arm/mach-omap2/ 2>Kerr;make C=2
>> arch/arm/mach-omap2/ 2>Kerr1;diff Kerr Kerr1
>> [..]
>> 1,4d0
>> <  arch/arm/mach-omap2/mux.c: In function 'omap_mux_get_by_name':
>> <  arch/arm/mach-omap2/mux.c:163:17: warning: 'found_mode' may be used
>> uninitialized in this function
>> <  arch/arm/mach-omap2/clkt_clksel.c: In function 'omap2_clksel_set_parent':
>> <  arch/arm/mach-omap2/clkt_clksel.c:100:35: warning: 'max_clkr' may be
>> used uninitialized in this function
>>
>> Kinda interesting to note that C=2 does'nt list all potential gcc
>> warnings :( if one wanted a collated list of all warnings, rm .../*.o
>> helps I guess.
>
> C=2 only runs sparse - so if you're committing patches to fix sparse
> warnings, that's what you should be interested in.
>
> I'd suggest that fixing sparse warnings and GCC warnings in a single
> patch is probably not the best thing to do - GCC warnings are less
> subjective than sparse warnings.
I agree.

-- 
Regards,
Nishanth Menon
