From: will.deacon@arm.com (Will Deacon)
Date: Fri, 6 Feb 2015 18:55:27 +0000
Subject: [PATCH] kvmtool: don't use PCI config space IRQ line field
In-Reply-To: <1423064390-15269-1-git-send-email-andre.przywara@arm.com>
References: <4324891.mqG6Yyfi6J@wuerfel>
 <1423064390-15269-1-git-send-email-andre.przywara@arm.com>
Message-ID: <20150206185527.GC24099@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 04, 2015 at 03:39:50PM +0000, Andre Przywara wrote:
> In PCI config space there is an interrupt line field (offset 0x3f),
> which is used to initially communicate the IRQ line number from
> firmware to the OS. _Hardware_ should never use this information,
> as the OS is free to write any information in there.

Is this true even with probe-only? I appreciate that this isn't a BAR,
but it still feels odd for Linux to write this in that case.

Will
