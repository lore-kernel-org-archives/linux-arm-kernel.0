From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Mon, 8 Apr 2013 11:15:30 +0100
Subject: [PATCH V3 4/5] spi: s3c64xx: Added provision for dedicated cs pin
In-Reply-To: <CAKrE-Kd+YAFmteDdh3odtV+YU1=OjoMuQV9usF4NmUse+TXhTg@mail.gmail.com>
References: <1363157014-9615-1-git-send-email-ks.giri@samsung.com>
 <1363157014-9615-5-git-send-email-ks.giri@samsung.com>
 <20130401125744.GG18636@opensource.wolfsonmicro.com>
 <CAKrE-Kd+YAFmteDdh3odtV+YU1=OjoMuQV9usF4NmUse+TXhTg@mail.gmail.com>
Message-ID: <20130408101530.GC9243@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Apr 08, 2013 at 03:21:03PM +0530, Girish KS wrote:
> On Mon, Apr 1, 2013 at 6:27 PM, Mark Brown

> > It's also a bit odd that we end up checking cs_gpio and then using line
> > in the code, it'd be more idiomatic if cs_gpio were the GPIO number.

> In the original driver it was assumed that the cs line is always a gpio pin.
> But the current controller that i am working on has no gpio pin for cs
> selection.
> All the lines to the device are internally connected. There is no
> option to select
> the cs signal. So cs-gpio property parsing has to skipped for this
> controller, that means
> cs_gpio cannot be a GPIO number. If it has to be a number then it has
> to be < 0 to say
> it is not gpio. Any >= 0 number implies it is a valid gpio (in reality
> for this controller it is not.)

Two options here, one is to just assume nobody will use GPIO 0 and the
other is to set the number appopriately during probe so that only probe
needs to worry about the issue.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130408/8343d432/attachment.sig>
