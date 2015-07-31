From: festevam@gmail.com (Fabio Estevam)
Date: Fri, 31 Jul 2015 09:04:09 -0300
Subject: [PATCH V3] tty: serial: imx.c: Reset UART before activating
 interrupts
In-Reply-To: <1438343953-31679-1-git-send-email-david@protonic.nl>
References: <1438343953-31679-1-git-send-email-david@protonic.nl>
Message-ID: <CAOMZO5DwHWjTsW4v01Tc0WoXKE5hk1-1dwCgPrg9_hNOd7XiKg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 31, 2015 at 8:59 AM, David Jander <david@protonic.nl> wrote:
> If the UART has been in use before this driver was loaded, IRQs might be
> active and get fired as soon as we set the handler, which will crash
> in the spin_lock_irqsave(&sport->port.lock, flags) because port.lock is
> not initialized until the port is added at the end of probe.
>
> Signed-off-by: David Jander <david@protonic.nl>

Tested-by: Fabio Estevam <fabio.estevam@freescale.com>

Thanks
