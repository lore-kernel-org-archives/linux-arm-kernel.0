From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 5 Nov 2012 09:42:04 +0000
Subject: [PATCH 1/1 v2] usb: at91_udc: fix typo on vubs pullup valid check
In-Reply-To: <20121105093451.GA20063@game.jcrosoft.org>
References: <20121105093451.GA20063@game.jcrosoft.org>
Message-ID: <20121105094204.GD28327@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Subject: usb: at91_udc: fix typo on vubs pullup valid check
                                    ^^^^
typo.

On Mon, Nov 05, 2012 at 10:34:52AM +0100, Jean-Christophe PLAGNIOL-VILLARD wrote:
> if the gpio is not valid complain
> 
> since 3285e0ec088febc5a88f57ddd78385a7da71476c
> ARM: at91/udc: use gpio_is_valid to check the gpio

Poor description.

"The check for a valid vbus pullup gpio in commit 3285e0ec088f (ARM: at91/udc:
use gpio_is_valid to check the gpio) is inverted.  Fix this."

would be much better because it describes what the the actual problem is.
Your description could mean that it's missing the error return path, or
maybe you're adding a log message to the failure case, or...
