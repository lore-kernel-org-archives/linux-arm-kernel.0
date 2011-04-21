From: hartleys@visionengravers.com (H Hartley Sweeten)
Date: Wed, 20 Apr 2011 19:54:15 -0500
Subject: Question: add convenience macros to create struct resource data?
Message-ID: <0D753D10438DA54287A00B027084269764D23AC194@AUSP01VMBX24.collaborationhost.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello all,

Does it make sense to introduce a couple convenience macros to ioport.h?

#define MEM_RESOURCE(_start,_size)		\
	.start	= (_start),			\
	.end	= (_start) + (_size) - 1,	\
	.flags	= IORESOURCE_MEM

#define IRQ_RESOURCE(_start)			\
	.start	= (_start),			\
	.end	= (_start),			\
	.flags	= IORESOURCE_IRQ

These could be used all over the tree to reduce the LOC.

Regards,
Hartley
