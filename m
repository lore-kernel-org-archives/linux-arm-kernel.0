From: broonie@kernel.org (Mark Brown)
Date: Sun, 11 Aug 2013 19:24:44 +0100
Subject: [PATCH 1/2] Convert power recovery pin to a fixed regulator
In-Reply-To: <1376231210-6484-2-git-send-email-jm@lentin.co.uk>
References: <1376231210-6484-1-git-send-email-jm@lentin.co.uk>
 <1376231210-6484-2-git-send-email-jm@lentin.co.uk>
Message-ID: <20130811182444.GG6427@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Aug 11, 2013 at 03:26:49PM +0100, Jamie Lentin wrote:
> dnskw_gpio_register() is broken, and probably has been for a while,
> since dnskw_init() is called too early to register GPIOs. Instead use a
> fixed regulator to turn the pin high, which knows to defer the
> registration until later.

So, this is really abuse of the regulator API since it knows how to set
a GPIO.  Perhaps the reset controller might be a better fit, or pinctrl
defaults?
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130811/d37d8977/attachment.sig>
