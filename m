From: mark.rutland@arm.com (Mark Rutland)
Date: Fri, 27 Jul 2018 11:55:17 +0100
Subject: [PATCH 6/6] ARM: spectre-v1: mitigate user accesses
In-Reply-To: <20180726141205.GB17271@n2100.armlinux.org.uk>
References: <20180710141322.GL17271@n2100.armlinux.org.uk>
 <E1fctPA-0005vT-QX@rmk-PC.armlinux.org.uk>
 <20180726124900.syqvsltidm4c2oud@lakrids.cambridge.arm.com>
 <20180726141205.GB17271@n2100.armlinux.org.uk>
Message-ID: <20180727105517.w4kaktlwpger3a2y@lakrids.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 26, 2018 at 03:12:05PM +0100, Russell King - ARM Linux wrote:
> On Thu, Jul 26, 2018 at 01:49:00PM +0100, Mark Rutland wrote:
> > I'm a little worried that we might need to do something for
> > __copy_{to,from}_user_memcpy(), since we could mis-speculate the
> > uaccess_kernel() check (or other branches), and go straight to the
> > unsanitized memcpy().
> 
> There is no __copy_from_user_memcpy function:
> 
> $ git grep copy_from_user_memcpy
> $

My bad. I had seen __copy_to_user_memcpy and assumed that there was a
__copy_from_user_memcpy.

Sorry for the noise.

Othewise:

Acked-by: Mark Rutland <mark.rutland@arm.com>

Mark.
