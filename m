From: nico@fluxnic.net (Nicolas Pitre)
Date: Sat, 26 Jun 2010 14:22:03 -0400 (EDT)
Subject: [PATCH] [ARM] Introduce patching of phys_to_virt and vice versa
In-Reply-To: <20100626095420.GA10340@n2100.arm.linux.org.uk>
References: <1277542025-19881-1-git-send-email-eric.miao@canonical.com>
	<20100626095420.GA10340@n2100.arm.linux.org.uk>
Message-ID: <alpine.LFD.2.00.1006261408530.24097@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, 26 Jun 2010, Russell King - ARM Linux wrote:

> It needs to be documented that PATCH_PHYS_VIRT is only for non-XIP and
> non-Thumb2 kernels.  I suggest it goes in the help text for the config
> option, or a comment before the option.

The idea is to do the same for Thumb2 as well.

Obviously this is incompatible with XIP so should be documented as such.  
And I think we should try to make this option non user selectable if 
possible, but rather make it depend on the variable phys offset and 
linear memory layout options.


Nicolas
