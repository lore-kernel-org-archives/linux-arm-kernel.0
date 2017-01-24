From: will.deacon@arm.com (Will Deacon)
Date: Tue, 24 Jan 2017 15:58:49 +0000
Subject: [PATCH] drivers: firmware: psci: Use __pa_symbol for cpu_resume
In-Reply-To: <20170124153351.GF7572@leverpostej>
References: <1485271819-2977-1-git-send-email-geert+renesas@glider.be>
 <20170124153351.GF7572@leverpostej>
Message-ID: <20170124155849.GH1728@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 24, 2017 at 03:33:51PM +0000, Mark Rutland wrote:
> On Tue, Jan 24, 2017 at 04:30:19PM +0100, Geert Uytterhoeven wrote:
> > If CONFIG_DEBUG_VIRTUAL=y, during s2ram:
> > 
> >     virt_to_phys used for non-linear address: ffffff80085db280 (cpu_resume+0x0/0x20)
> >     ------------[ cut here ]------------
> >     WARNING: CPU: 0 PID: 1628 at arch/arm64/mm/physaddr.c:14 __virt_to_phys+0x28/0x60
> >     ...
> >     [<ffffff800809abb4>] __virt_to_phys+0x28/0x60
> >     [<ffffff80084a0c38>] psci_system_suspend+0x20/0x44
> >     [<ffffff8008095b28>] cpu_suspend+0x3c/0x68
> >     [<ffffff80084a0b48>] psci_system_suspend_enter+0x18/0x20
> >     [<ffffff80080ea3e0>] suspend_devices_and_enter+0x3f8/0x7e8
> >     [<ffffff80080ead14>] pm_suspend+0x544/0x5f4
> > 
> > Fixes: 1a08e3d9e0ac4577 ("drivers: firmware: psci: Use __pa_symbol for kernel symbol")
> > Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> 
> Argh, I should have spotted this. :(
> 
> Acked-by: Mark Rutland <mark.rutland@arm.com>
> 
> This should go via the arm64 tree -- Will, could you pick this up? 

Yup, I'll queue this along with the other __pa_symbol fix.

Cheers,

Will
