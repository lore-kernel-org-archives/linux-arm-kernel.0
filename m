From: gregkh@linuxfoundation.org (Greg Kroah-Hartman)
Date: Thu, 19 Jun 2014 17:36:03 -0700
Subject: [PATCH v4 09/13] serial: amba-pl011: Pass FIQ information to KGDB.
In-Reply-To: <1403174303-25456-10-git-send-email-daniel.thompson@linaro.org>
References: <1401961994-18033-1-git-send-email-daniel.thompson@linaro.org>
 <1403174303-25456-1-git-send-email-daniel.thompson@linaro.org>
 <1403174303-25456-10-git-send-email-daniel.thompson@linaro.org>
Message-ID: <20140620003603.GA30850@kroah.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jun 19, 2014 at 11:38:19AM +0100, Daniel Thompson wrote:
> If the AMBA bus has provided the pl011 with a FIQ resource (i.e. a
> second IRQ) then speculatively register it with KGDB when the polling
> driver is initialized.
> 
> By providing this information to KGDB the serial driver offers
> "permission" for KGDB to route the UART interrupt signal from the
> drivers own handler to KGDBs FIQ handler (which will eventually use the
> UART's polled I/O callbacks to interact with the user). This permission
> also implies the amba-pl011 driver has already unmasked RX interrupts
> (otherwise the FIQ handler will never trigger).
> 
> Signed-off-by: Daniel Thompson <daniel.thompson@linaro.org>
> Cc: Russell King <linux@arm.linux.org.uk>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Jiri Slaby <jslaby@suse.cz>
> Cc: linux-serial at vger.kernel.org
> ---

Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
