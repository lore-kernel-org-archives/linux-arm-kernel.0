From: jason@lakedaemon.net (Jason Cooper)
Date: Sun, 24 Nov 2013 12:06:15 -0500
Subject: [PATCH 2/3] mmc: mvsdio: workaround for spurious irqs
In-Reply-To: <1384525354-901-3-git-send-email-sebastian.hesselbarth@gmail.com>
References: <1384525354-901-1-git-send-email-sebastian.hesselbarth@gmail.com>
 <1384525354-901-3-git-send-email-sebastian.hesselbarth@gmail.com>
Message-ID: <20131124170615.GI29241@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 15, 2013 at 03:22:33PM +0100, Sebastian Hesselbarth wrote:
> SDIO controllers found on Marvell Kirkwood SoCs seem to cause a late,
> spurious irq although all interrupts have been disabled. This irq
> doesn't do any harm, neither to HW nor driver. To avoid some
> "unexpected irq" warning later, we workaround above issue by bailing
> out of irq handler early, if we didn't expect any.
> 
> Signed-off-by: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
> ---
> Cc: Nicolas Pitre <nico@fluxnic.net>
> Cc: Chris Ball <cjb@laptop.org>
> Cc: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
> Cc: Jason Cooper <jason@lakedaemon.net>
> Cc: Andrew Lunn <andrew@lunn.ch>
> Cc: linux-mmc at vger.kernel.org
> Cc: linux-arm-kernel at lists.infradead.org
> Cc: linux-kernel at vger.kernel.org
> ---
>  drivers/mmc/host/mvsdio.c |   15 +++++++++++++++
>  1 files changed, 15 insertions(+), 0 deletions(-)

Acked-by: Jason Cooper <jason@lakedaemon.net>

thx,

Jason.
