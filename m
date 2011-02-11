From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 11 Feb 2011 22:38:44 +0000
Subject: [PATCH RFC] ARM: MPCore v6_early_abort enhancement
In-Reply-To: <20110211215421.GA29361@mvista.com>
References: <20110211215421.GA29361@mvista.com>
Message-ID: <20110211223844.GB31356@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Feb 12, 2011 at 12:54:21AM +0300, Valentine Barshak wrote:
> SWP instruction sets bit 11 in DFSR, in case of data fault on SMP MPCore.
> So v6_early_abort doesn't need erratum 326103 workaround for MPCore.

NAK.  When building a SMP kernel which also supports v6 CPUs, this will
cause v6 CPUs to break.
