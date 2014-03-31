From: marex@denx.de (Marek Vasut)
Date: Mon, 31 Mar 2014 07:25:26 +0200
Subject: Warning at ahci_enable_ahci() during resume
In-Reply-To: <CAOMZO5BXMmtsqQAsfdPw5fkziNUABBYwab69gbdGDMM_9bmMFA@mail.gmail.com>
References: <CAOMZO5BXMmtsqQAsfdPw5fkziNUABBYwab69gbdGDMM_9bmMFA@mail.gmail.com>
Message-ID: <201403310725.26460.marex@denx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday, March 28, 2014 at 03:38:53 PM, Fabio Estevam wrote:
> Hi,
> 
> I am running linux-next 20140328 on a mx6qsabresd board and I am
> getting the following warning at ahci_enable_ahci() during a
> suspend/resume cycle:
> 
> /$ echo mem > /sys/power/state
> PM: Syncing filesystems ... done.
> Freezing user space processes ... (elapsed 0.001 seconds) done.
> Freezing remaining freezable tasks ... (elapsed 0.001 seconds) done.
> Suspending console(s) (use no_console_suspend to debug)
> 
> , and then I press the GPIO key to wake-up the system:

Looks like the AHCI link doesn't come up again. Can you check if the clock are 
enabled? Are the correct bits programmed into the MX6's AHCI registers? Also see 
imx_sata_enable() function for the bits which are programmed into the GPR 
registers too and check if they are there.

Best regards,
Marek Vasut
