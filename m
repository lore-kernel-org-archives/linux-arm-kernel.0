From: simon.guinot@sequanux.org (Simon Guinot)
Date: Mon, 23 Feb 2015 15:34:16 +0100
Subject: [PATCH] hwmon: (gpio-fan) allow to use alarm support alone from DT
In-Reply-To: <54EB33D4.1000804@roeck-us.net>
References: <1424696334-14767-1-git-send-email-simon.guinot@sequanux.org>
 <54EB33D4.1000804@roeck-us.net>
Message-ID: <20150223143416.GT1509@kw.sim.vm.gnt>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Feb 23, 2015 at 06:06:12AM -0800, Guenter Roeck wrote:
> On 02/23/2015 04:58 AM, Simon Guinot wrote:
> >On some boards, such as the LaCie 2Big Network v2 or 2Big NAS (based on
> >Marvell Kirkwood SoCs), an I2C fan controller is used but the alarm
> >signal is wired to a separate GPIO. Unfortunately, the gpio-fan driver
> >can't be used to handle GPIO alarm alone from DT: an error is returned
> >if the "gpios" DT property is missing.
> >
> >This patch allows to use the gpio-fan driver even if the "alarm-gpios"
> >DT property is defined alone.
> >
> 
> That is the wrong solution. The gpio alarm signal should be handled
> by the fan controller driver.

Hi Guenter,

Sure it should, but unfortunately it is not the case. I have several
boards using this mechanism (ie: a separate fan alarm GPIO). I think the
idea was to reduce the board cost...

Then this means I need a way to support this alarm signal and I can't
find a better one than using gpio-fan. Note that this was possible with
the original gpio-fan implementation (before the DT binding addition).

Let me know what you think.

Simon

> 
> Guenter
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 181 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150223/d5db44a8/attachment.sig>
