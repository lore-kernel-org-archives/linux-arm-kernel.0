From: eric.y.miao@gmail.com (Eric Miao)
Date: Wed, 23 Jun 2010 19:52:12 +0800
Subject: [PATCH 0/6] Cleanup of mach/io.h
Message-ID: <1277293938-25804-1-git-send-email-eric.y.miao@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Some definitions can be made common, like IO_SPACE_LIMIT, some can
be removed, e.g. __mem_isa(), and some can be made into a machine
specific call, e.g. arch_adjust_zones()

Many mach/io.h can actually be safely removed, except for the
following definitions:

	__io()

and
	__arch_ioremap(), __arch_iounmap() and so on

__io() in the end can be made generic into something like:

#define __io(x)		((x) - physical_address_of_IO_space +
			       virtual_base)

and __arch_ioremap(), __arch_iounmap() made into machine specific
function (again?)
