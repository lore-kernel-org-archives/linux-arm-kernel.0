From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 8 Mar 2010 10:14:45 +0000
Subject: Compile problem due to compressor changes, UART referenced in
	section .txt
In-Reply-To: <Prayer.1.3.2.1003071719080.2280@hermes-2.csi.cam.ac.uk>
References: <Prayer.1.3.2.1003071719080.2280@hermes-2.csi.cam.ac.uk>
Message-ID: <20100308101445.GA12363@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Mar 07, 2010 at 05:19:08PM +0000, J.I. Cameron wrote:
> Dear  All,
>
> Ran into the following problem on a pxa stargate2 platform (I think it will
> effect a number of others).
>
> `UART' referenced in section `.text' of arch/arm/boot/compressed/misc.o:  
> defined in discarded section `.data' of arch/arm/boot/compressed/misc.o  
> `UART' referenced in section `.text' of arch/arm/boot/compressed/misc.o:  
> defined in discarded section `.data' of arch/arm/boot/compressed/misc.o
>
> There is a hack in mach-pxa/include/mach/uncompress.h
> that changes the primary uart for some platforms:
>
> static inline void arch_decomp_setup(void)
> {
> 	if (machine_is_littleton() || machine_is_intelmote2()
> 	    || machine_is_csb726() || machine_is_stargate2()
> 	  || machine_is_cm_x300() || machine_is_balloon3())
> 	UART = STUART;

	else
		UART = FFUART;

and remove the initializer from UART.
