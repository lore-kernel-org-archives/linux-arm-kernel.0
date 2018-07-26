From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Thu, 26 Jul 2018 15:12:05 +0100
Subject: [PATCH 6/6] ARM: spectre-v1: mitigate user accesses
In-Reply-To: <20180726124900.syqvsltidm4c2oud@lakrids.cambridge.arm.com>
References: <20180710141322.GL17271@n2100.armlinux.org.uk>
 <E1fctPA-0005vT-QX@rmk-PC.armlinux.org.uk>
 <20180726124900.syqvsltidm4c2oud@lakrids.cambridge.arm.com>
Message-ID: <20180726141205.GB17271@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 26, 2018 at 01:49:00PM +0100, Mark Rutland wrote:
> I'm a little worried that we might need to do something for
> __copy_{to,from}_user_memcpy(), since we could mis-speculate the
> uaccess_kernel() check (or other branches), and go straight to the
> unsanitized memcpy().

There is no __copy_from_user_memcpy function:

$ git grep copy_from_user_memcpy
$

Since this patch series is only addressing Spectre Variant 1 as
published in January, __copy_to_user_memcpy() is not relevant to it.

__copy_to_user_memcpy() is relevent for a future patch series
addressing more recently released CVEs.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 13.8Mbps down 630kbps up
According to speedtest.net: 13Mbps down 490kbps up
