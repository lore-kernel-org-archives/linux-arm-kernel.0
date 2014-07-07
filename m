From: fkan@apm.com (Feng Kan)
Date: Mon, 7 Jul 2014 11:52:52 -0700
Subject: [PATCH V5 2/3] Documentation: gpio: Add APM X-Gene SoC GPIO
 controller DTS binding
In-Reply-To: <CACRpkdZ18SsRBBbngSVyxR0GFkC0kLD4OHm9RJmgZDLXbqvOBQ@mail.gmail.com>
References: <1403823587-23404-1-git-send-email-fkan@apm.com>
 <1403823587-23404-3-git-send-email-fkan@apm.com>
 <20140630125339.GA21390@leverpostej>
 <CACRpkdZ18SsRBBbngSVyxR0GFkC0kLD4OHm9RJmgZDLXbqvOBQ@mail.gmail.com>
Message-ID: <CAL85gmD017shZfHGvewyH5FO9vsSFSNGo=vTL68sosvuvODa_A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 4, 2014 at 2:28 PM, Linus Walleij <linus.walleij@linaro.org> wrote:
> On Mon, Jun 30, 2014 at 2:53 PM, Mark Rutland <mark.rutland@arm.com> wrote:
>> On Thu, Jun 26, 2014 at 11:59:46PM +0100, Feng Kan wrote:
>
>>> +- #gpio-cells: Should be two.
>>> +     - first cell is the pin number
>>> +     - second cell is used to specify optional parameters (unused)
>>
>> Why is there an unused cell?
>>
>> Why not just make this a single cell if the binding defines no valid
>> parameters?
>
> I don't get this either. The only reason would be that this cell
> should contain flags (such as open collector) the code for using
> it being inplemented later.

Yes, open drain configuration and mux via pinctrl was something I
planned for later.
There was another reason for this as well, part of the gpio code I read
was confusing me. So I look through the other gpio documentations and
found an example that did this as well.

int of_gpio_simple_xlate(struct gpio_chip *gc,
                         const struct of_phandle_args *gpiospec, u32 *flags)
{
        /*
         * We're discouraging gpio_cells < 2, since that way you'll have to
         * write your own xlate function (that will have to retrive the GPIO
         * number and the flags from a single gpio cell -- this is possible,
         * but not recommended).
         */

Thanks, and please advise me on what to do next.
>
> If the controller is too primitive to use such flags it should be onecell.
>
> Yours,
> Linus Walleij
