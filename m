From: broonie@kernel.org (Mark Brown)
Date: Wed, 23 Dec 2015 11:41:26 +0000
Subject: [PATCH 3/6] regulator: lp872x: Remove warning about invalid DVS
 GPIO
In-Reply-To: <1450868319-20513-4-git-send-email-contact@paulk.fr>
References: <1450868319-20513-1-git-send-email-contact@paulk.fr>
 <1450868319-20513-4-git-send-email-contact@paulk.fr>
Message-ID: <20151223114126.GR16023@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Dec 23, 2015 at 11:58:36AM +0100, Paul Kocialkowski wrote:
> Some devices don't hook the DVS pin to a GPIO but to ground or VCC.
> In those cases, it is not a problem to have no DVS GPIO.

I would expect the driver at least needs to know how the pins or
strapped, or otherwise have configuration for ignoring the input on the
pins.  This just deletes the warnings, it doesn't have any handling for
this case that I can see.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20151223/f4e21bf8/attachment.sig>
