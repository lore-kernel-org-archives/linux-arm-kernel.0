From: gregkh@linuxfoundation.org (Greg Kroah-Hartman)
Date: Wed, 30 Oct 2013 06:24:32 -0700
Subject: [PATCH 1/2] misc: atmel_pwm: add deferred-probing support
In-Reply-To: <20131030112551.GB29813@localhost>
References: <1382459560-26596-1-git-send-email-jhovold@gmail.com>
 <1382459560-26596-2-git-send-email-jhovold@gmail.com>
 <20131030112551.GB29813@localhost>
Message-ID: <20131030132432.GB30447@kroah.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Oct 30, 2013 at 12:25:51PM +0100, Johan Hovold wrote:
> On Tue, Oct 22, 2013 at 06:32:39PM +0200, Johan Hovold wrote:
> > Two drivers (atmel-pwm-bl and leds-atmel-pwm) currently depend on the
> > atmel_pwm driver to have bound to any pwm-device before their devices
> > are probed.
> > 
> > Support deferred probing of such devices by making sure to return
> > -EPROBE_DEFER from pwm_channel_alloc when no pwm-device has yet been
> > bound.
> > 
> > Signed-off-by: Johan Hovold <jhovold@gmail.com>
> 
> This patch, 5c6d6fd1 ("misc: atmel_pwm: add deferred-probing support"),
> and 9d3fde86 ("backlight: atmel-pwm-bl: fix deferred probe from __init")
> in linux-next should probably be considered for inclusion in stable.
> 
> Without them the atmel-pwm-bl driver may always fail to probe depending
> on link order.

Ok, I'll watch this for when it hits Linus's tree, thanks for letting me
know.

greg k-h
