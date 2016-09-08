From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Thu, 8 Sep 2016 10:53:47 +0200
Subject: [PATCH v2 2/7] clk: sunxi-ng: div: Allow to set a maximum
In-Reply-To: <CAGb2v66C9GJ5Svm+7NE2cStc5KiNgoriB329K4fhZJMTSbZ8Kw@mail.gmail.com>
References: <20160906121837.7517-1-maxime.ripard@free-electrons.com>
 <20160906121837.7517-3-maxime.ripard@free-electrons.com>
 <CAGb2v66C9GJ5Svm+7NE2cStc5KiNgoriB329K4fhZJMTSbZ8Kw@mail.gmail.com>
Message-ID: <20160908085347.GK8913@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Sep 07, 2016 at 12:20:10AM +0800, Chen-Yu Tsai wrote:
> On Tue, Sep 6, 2016 at 8:18 PM, Maxime Ripard
> <maxime.ripard@free-electrons.com> wrote:
> > Some dividers might have a maximum value that is lower than the width of
> > the register.
> >
> > Add a field to _ccu_div to handle those case properly. If the field is set
> > to 0, the code will assume that the maximum value is the maximum one that
> > can be used with the field register width.
> 
> This is a bit confusing. What is the maximum referring to? The raw value
> in the register? Or the actual divider?

The maximum divider, not the value in the register.

> Personally I'd go with the maximum valid value of the register. You
> could get rid of the special power-of-2 handling code you added.

I think I prefer to have the actual divider value. This is what is
documented in the datasheet, and it's entirely independant of the
actual factor being used, or the offset (is it register + 1, or simply
register)

I have the feeling that it's something we want to be abstracted away
from the data side of things.

> Either way I think the message and the field name should be more explicit.

Understood.

Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160908/f40f88c9/attachment.sig>
