From: nm@ti.com (Nishanth Menon)
Date: Tue, 04 Jan 2011 14:37:23 -0600
Subject: [PATCH 0/2] OMAP: TWL: sparse fixes
In-Reply-To: <4D22503F.9060100@ti.com>
References: <1294081110-23695-1-git-send-email-nm@ti.com>
	<20110103223656.GA8414@n2100.arm.linux.org.uk>
	<4D22503F.9060100@ti.com>
Message-ID: <4D238503.6070103@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Nishanth Menon had written, on 01/03/2011 04:39 PM, the following:
> Russell King - ARM Linux had written, on 01/03/2011 04:36 PM, the 
> following:
>> On Mon, Jan 03, 2011 at 12:58:28PM -0600, Nishanth Menon wrote:
>>> Source:
>>> git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap-2.6.git
>>> branch: omap-for-linus
>>>
>>> Doing a rm arch/arm/mach-omap2/*.o;make C=1 arch/arm/mach-omap2/
>>> resulted in the following sparse warnings:
>>> http://pastebin.mozilla.org/907954
>>
>> FYI, you may like to try:
>>
>> make C=2 arch/arm/mach-omap2/
>>
>> instead of the two-step process:
>> | Do a kernel make with "make C=1" to run sparse on all the C files 
>> that get
>> | recompiled, or use "make C=2" to run sparse on the files whether 
>> they need to
>> | be recompiled or not.  The latter is a fast way to check the whole 
>> tree if you
>> | have already built it.
> Gee thanks. /me should update my old bash aliases :D
hmm.. minor nit (with codesourcery 2010.09-50 - 4.5.1):
rm arch/arm/mach-omap2/*.o;make C=1 arch/arm/mach-omap2/ 2>Kerr;make C=2 
arch/arm/mach-omap2/ 2>Kerr1;diff Kerr Kerr1
[..]
1,4d0
< arch/arm/mach-omap2/mux.c: In function 'omap_mux_get_by_name':
< arch/arm/mach-omap2/mux.c:163:17: warning: 'found_mode' may be used 
uninitialized in this function
< arch/arm/mach-omap2/clkt_clksel.c: In function 'omap2_clksel_set_parent':
< arch/arm/mach-omap2/clkt_clksel.c:100:35: warning: 'max_clkr' may be 
used uninitialized in this function

Kinda interesting to note that C=2 does'nt list all potential gcc 
warnings :( if one wanted a collated list of all warnings, rm .../*.o 
helps I guess.

-- 
Regards,
Nishanth Menon
