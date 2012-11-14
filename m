From: alexander.shishkin@linux.intel.com (Alexander Shishkin)
Date: Wed, 14 Nov 2012 15:22:46 +0200
Subject: [PATCH 1/6] usb: chipidea: usbmisc: unset global varibale usbmisc
 on driver remove
In-Reply-To: <1352894137-2050-2-git-send-email-m.grzeschik@pengutronix.de>
References: <1352894137-2050-1-git-send-email-m.grzeschik@pengutronix.de>
 <1352894137-2050-2-git-send-email-m.grzeschik@pengutronix.de>
Message-ID: <87sj8c71zt.fsf@ashishki-desk.ger.corp.intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Michael Grzeschik <m.grzeschik@pengutronix.de> writes:

> From: Marc Kleine-Budde <mkl@pengutronix.de>
>
> While there fix a potential race condition, first set usbmisc, then call
> usbmisc_set_ops().

This should be really two separate patches, both of which could use
more elaborate commit messages. That is, if you unset variable, what
kind of scenario it prevents, what exactly is the potential race
condition, etc. Saves time for everybody.

>
> Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
> Signed-off-by: Michael Grzeschik <m.grzeschik@pengutronix.de>
> ---
>  drivers/usb/chipidea/usbmisc_imx6q.c |    5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)

I'd also move the renaming patch in front of everything else, but that's
up to you.

Regards,
--
Alex
