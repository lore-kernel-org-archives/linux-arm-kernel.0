From: broonie@kernel.org (Mark Brown)
Date: Wed, 11 Sep 2013 16:35:47 +0100
Subject: [PATCH 27/38] iio: pressure-core: st: Give some indication if
 device probing was successful
In-Reply-To: <20130911072955.GG11227@lee--X1>
References: <1378817379-8238-1-git-send-email-lee.jones@linaro.org>
 <1378817379-8238-28-git-send-email-lee.jones@linaro.org>
 <43055af7-991f-4122-b308-a3dcddbbb72a@email.android.com>
 <20130911071053.GD11227@lee--X1> <52301963.5030006@metafoo.de>
 <20130911072955.GG11227@lee--X1>
Message-ID: <20130911153547.GU29403@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Sep 11, 2013 at 08:29:55AM +0100, Lee Jones wrote:

> Only if you print out every regulator, clock, GPIO pin and things of
> this nature. Key hardware blocks such as; SD, Flash, USB, Eth, HDMI,
> Audio, UART, GPIO and I2C controllers and Sensors I think deserve a
> one line "I'm here and working" message.

The usual rule people apply with this stuff is if the driver has read
back information it can display from the hardware (eg, a revision) then
that's OK.  Things that are likely to crash the system if they fail tend
to also be OK (this is why the regualtor API is quite chatty for
example, a lot of the things it does can cause an immediate crash).
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130911/235abe2c/attachment.sig>
