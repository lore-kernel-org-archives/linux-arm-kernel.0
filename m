From: olof@lixom.net (Olof Johansson)
Date: Tue, 31 Aug 2010 23:08:01 -0500
Subject: [PATCH 9/9] ARM: Add SWP/SWPB emulation for ARMv7 processors (v5)
In-Reply-To: <20100831135855.21304.5457.stgit@e102109-lin.cambridge.arm.com>
References: <20100831135435.21304.38960.stgit@e102109-lin.cambridge.arm.com>
	<20100831135855.21304.5457.stgit@e102109-lin.cambridge.arm.com>
Message-ID: <20100901040801.GA10431@lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Tue, Aug 31, 2010 at 02:58:56PM +0100, Catalin Marinas wrote:
> From: Leif Lindholm <leif.lindholm@arm.com>
> 
> The SWP instruction was deprecated in the ARMv6 architecture, superseded
> by the LDREX/STREX family of instructions for
> load-linked/store-conditional operations. The ARMv7 multiprocessing
> extensions mandate that SWP/SWPB instructions are treated as undefined
> from reset, with the ability to enable them through the System Control
> Register SW bit.
> 
> This patch adds the alternative solution to emulate the SWP and SWPB
> instructions using LDREX/STREX sequences, and log statistics to
> /proc/cpu/swp_emulation. To correctly deal with copy-on-write, it also

Sounds like debugfs would be a better place to export this through?
That's what PPC does.


-Olof
