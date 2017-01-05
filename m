From: nsekhar@ti.com (Sekhar Nori)
Date: Thu, 5 Jan 2017 13:51:50 +0530
Subject: [PATCH v2 2/4] serial: 8250: Add new port type for TI
 DA8xx/OMAPL13x/AM17xx/AM18xx/C66x
In-Reply-To: <1483561814-21953-3-git-send-email-david@lechnology.com>
References: <1483561814-21953-1-git-send-email-david@lechnology.com>
 <1483561814-21953-3-git-send-email-david@lechnology.com>
Message-ID: <7b175d65-7193-32e4-999b-e3cdd0005c3a@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 05 January 2017 02:00 AM, David Lechner wrote:
> This adds a new UART port type for TI DA8xx/OMAPL13x/AM17xx/AM18xx/C66x.

The Keystone2 processors do include the C66x DSP. But the SoCs being
targeted with this patch are the ARM + DSP variants. Using 66AK2x is
more appropriate.

http://www.ti.com/lsds/ti/processors/dsp/c6000_dsp-arm/66ak2x/overview.page

Also, DA8xx includes DA830 which is pin-compatible with AM17x. So you
can shorten the list of supported processors to DA8xx/66AK2x.

> These SoCs have standard 8250 registers plus some extra non-standard
> registers.
> 
> The UART will not function unless the non-standard Power and Emulation
> Management Register (PWREMU_MGMT) is configured correctly. This is
> currently handled in arch/arm/mach-davinci/serial.c for non-device-tree
> boards. Making this part of the UART driver will allow UART to work on
> device-tree boards as well and the mach code can eventually be removed.
> 
> Signed-off-by: David Lechner <david@lechnology.com>

Looks good to me, apart from the minor change above.

Acked-by: Sekhar Nori <nsekhar@ti.com>

Thanks,
Sekhar
