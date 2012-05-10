From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Thu, 10 May 2012 10:34:43 +0100
Subject: [PATCH 2/2] regulator: Add support for MAX77686.
In-Reply-To: <CAKew6eWEYBP1zXXwLL4eWOhOKZ-HwAfUX_kg8cnsaDyUXVKSkQ@mail.gmail.com>
References: <1336580695-1184-1-git-send-email-yadi.brar@samsung.com>
 <1336580695-1184-3-git-send-email-yadi.brar@samsung.com>
 <20120509184709.GC32037@sirena.org.uk>
 <CAKew6eWEYBP1zXXwLL4eWOhOKZ-HwAfUX_kg8cnsaDyUXVKSkQ@mail.gmail.com>
Message-ID: <20120510093442.GK3908@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 10, 2012 at 12:54:24PM +0530, Yadwinder Singh Brar wrote:
> On Thu, May 10, 2012 at 12:17 AM, Mark Brown
> > On Wed, May 09, 2012 at 09:54:55PM +0530, Yadwinder Singh wrote:

> >> + ? ? [MAX77686_EN32KHZ_AP] = NULL,
> >> + ? ? [MAX77686_EN32KHZ_CP] = NULL,

> > Now that the generic clock API is in mainline these should be moved over
> > to use it.

> Sorry, I cann't get your point here. Please explain it little bit more.

These are not regulators, these are clocks.  They should use the clock
API.

> >> + ? ? if (pdata->ramp_delay) {
> >> + ? ? ? ? ? ? max77686->ramp_delay = pdata->ramp_delay;
> >> + ? ? ? ? ? ? max77686_update_reg(i2c, MAX77686_REG_BUCK2CTRL1,
> >> + ? ? ? ? ? ? ? ? ? ? RAMP_VALUE, RAMP_MASK);

> > This appears not to actually use the value passed in as platform_data.

> It gets corresponding index of ramp_rate value in ramp_rate_value
> table supported by hardware, from platform_data which we write to
> ramp_rate control bits of control registers.

Why is the driver unconditionally writing these register values here
rather than setting the ramp delay that was passed in?
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120510/52a8cef0/attachment-0001.sig>
