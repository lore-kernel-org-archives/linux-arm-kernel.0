From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Mon, 5 Sep 2016 09:50:42 +0200
Subject: [PATCH v3 0/2] AM335x-ICE: Add support for rotary switch
In-Reply-To: <5294e820-4946-a196-549f-76a349b6606d@ti.com>
References: <20160824075859.30979-1-vigneshr@ti.com>
 <c5385d42-14e4-d5ca-370e-5b04e37d873d@zonque.org>
 <5294e820-4946-a196-549f-76a349b6606d@ti.com>
Message-ID: <20160905075042.zeumdequro3bp3bj@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On Wed, Aug 24, 2016 at 02:45:17PM +0530, Vignesh R wrote:
> On Wednesday 24 August 2016 02:05 PM, Daniel Mack wrote:
> > On 08/24/2016 09:58 AM, Vignesh R wrote:
> >> This series adds support for rotary-switch on AM335x-ICE that is
> >> connected to TI PCA9536 I2C GPIO expander.
> >> First patch adds new generic driver to read status of group of GPIO
> >> lines and report the value as an input event. The second patch adds DT
> >> entries for the same.
> >>
> >> v2: https://lkml.org/lkml/2016/8/23/111
> >> v1: https://lkml.org/lkml/2016/8/12/7
> > 
> > Is there a reason why the rotary-encoder driver cannot handle this?
> > Commit 7dde4e74744 ("Input: rotary-encoder - support more than 2 gpios
> > as input") added support for that mode AFAIU.
> > 
> 
> Rotary encoder driver handles incremental encoders only and does not
> support absolute encoders. The rotary switch on am335x-ice is different
> from the incremental encoders in the
> sense that GPIO line status directly reflect the position(number)
> pointed by the dial of the encoder. So, there is no need to count steps
> or know the direction of rotation as it does not matter.

I'd still prefer to expand drivers/input/misc/rotary_encoder.c to handle
this. Yes, there is no reason to count steps or determine the direction
of a rotation in this case, but still there is much code to share and
IMHO it's ok that a driver that handles several types of similar devices
does too much for some special cases.

> I did try to enhance rotary-encoder driver to support absolute
> encoder[1] but the comment there was to write new driver that simply
> translates gpio-encoded value into ABS* event. Indeed, the new driver
> looks more simple and can handle more such hardwares.

Which type of hardware can be handled by your driver that the generic
rotary encoder cannot? I guess it's just a matter of a (simple) patch?

Best regards
Uwe

> [1] https://lkml.org/lkml/2016/5/19/98

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
