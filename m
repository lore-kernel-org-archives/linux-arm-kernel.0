From: jic23@cam.ac.uk (J.I. Cameron)
Date: 07 Mar 2010 17:19:08 +0000
Subject: Compile problem due to compressor changes,
	UART referenced in section .txt
Message-ID: <Prayer.1.3.2.1003071719080.2280@hermes-2.csi.cam.ac.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear  All,

Ran into the following problem on a pxa stargate2 platform (I think it will
effect a number of others).

`UART' referenced in section `.text' of arch/arm/boot/compressed/misc.o: 
defined in discarded section `.data' of arch/arm/boot/compressed/misc.o 
`UART' referenced in section `.text' of arch/arm/boot/compressed/misc.o: 
defined in discarded section `.data' of arch/arm/boot/compressed/misc.o

There is a hack in mach-pxa/include/mach/uncompress.h
that changes the primary uart for some platforms:

static inline void arch_decomp_setup(void)
{
	if (machine_is_littleton() || machine_is_intelmote2()
	    || machine_is_csb726() || machine_is_stargate2()
	  || machine_is_cm_x300() || machine_is_balloon3())
	UART = STUART;
}

Simply changing the initial assignment of UART and commenting this function
out acts as a work around.  I'm not entirely sure how to fix the problem
properly.

Jonathan
