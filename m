From: catalin.marinas@arm.com (Catalin Marinas)
Date: Fri, 11 Jan 2013 16:50:53 +0000
Subject: [PATCHv2 08/11] arm: arch_timer: add arch_counter_set_user_access
In-Reply-To: <50F01646.4010203@ti.com>
References: <1357747640-18594-1-git-send-email-mark.rutland@arm.com>
 <1357747640-18594-9-git-send-email-mark.rutland@arm.com>
 <50F01646.4010203@ti.com>
Message-ID: <20130111165053.GB1794@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jan 11, 2013 at 01:40:22PM +0000, Santosh Shilimkar wrote:
> On Wednesday 09 January 2013 09:37 PM, Mark Rutland wrote:
> > Several bits in CNTKCTL reset to 0, including PL0VTEN. For platforms
> > using the generic timer which wish to have a fast gettimeofday vDSO
> > implementation, these bits must be set to 1 by the kernel. On other
> > platforms, the bootloader might enable userspace access when we don't
> > want it.
> >
> > This patch adds arch_counter_set_user_access, which sets the PL0 access
> > permissions to that required by the platform. For arm, this currently
> minor nit.
> s/arm/ARM

I think Mark meant arch/arm. Or we could call it AArch32 where we don't
use this feature.

-- 
Catalin
