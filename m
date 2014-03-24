From: robherring2@gmail.com (Rob Herring)
Date: Mon, 24 Mar 2014 13:03:18 -0500
Subject: [ARM ATTEND] Following discussions
In-Reply-To: <20140324160615.GC3351@piout.net>
References: <20140324160615.GC3351@piout.net>
Message-ID: <CAL_Jsq+EiRhEaq3wDSjB-zCUsYD1oEi4iCFehUpyMT6YKk8TNQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Mar 24, 2014 at 11:06 AM, Alexandre Belloni
<alexandre.belloni@free-electrons.com> wrote:
> Hi,
>
> As I have been working on the i.mx28, Marvell Berlin and AT91 linux
> support, I'm interested in attending the ARM summit to follow the
> current status and learn about the current best practices.
>
> I've also been doing a lot of cleanup and I would like to discuss how to
> go about cleaning the style issues in the Device Trees like lists
> without elements bracketed individually, magic values used instead of
> macros and the likes.

The first step would be getting agreement that either of those are
really considered style issues. IMO, use of defines is purely
optional. For DT's that are pretty much static, there is little point
in going back and changing them now. Changing ALL numbers in dts files
to defines is not the direction either. Generally, numbers that come
from the h/w (addresses, irq numbers, etc.) should not be defines.
Things which are more just DT convention like irq trigger values or
clock numbers can be defines. The question to ask is does it improve
readability or just add another level of lookup when you need to know
the actual value.

Rob
