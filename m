From: antoine.tenart@free-electrons.com (Antoine =?iso-8859-1?Q?T=E9nart?=)
Date: Tue, 22 Apr 2014 17:56:02 +0200
Subject: [PATCH RESEND 2/5] pinctrl: berlin: add a pinctrl driver for
 Marvell Berlin SoCs
In-Reply-To: <CACRpkdb1eijF-4e=KyhS=9S868NALdyJJaNnzjUubXnapWEeMg@mail.gmail.com>
References: <1397135274-10764-1-git-send-email-antoine.tenart@free-electrons.com>
 <1397135274-10764-3-git-send-email-antoine.tenart@free-electrons.com>
 <5347AFF4.3050607@gmail.com> <20140411123737.GA5903@kwain>
 <5347EF8A.8040600@gmail.com>
 <CACRpkdb1eijF-4e=KyhS=9S868NALdyJJaNnzjUubXnapWEeMg@mail.gmail.com>
Message-ID: <20140422155602.GA19762@kwain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Linus,

On Tue, Apr 22, 2014 at 02:52:10PM +0200, Linus Walleij wrote:
> On Fri, Apr 11, 2014 at 3:35 PM, Sebastian Hesselbarth
> <sebastian.hesselbarth@gmail.com> wrote:
> > On 04/11/2014 02:37 PM, Antoine T?nart wrote:
> >> On Fri, Apr 11, 2014 at 11:03:48AM +0200, Sebastian Hesselbarth wrote:
> >>> On 04/10/2014 03:07 PM, Antoine T?nart wrote:
> 
> >>> Having said that, the above assumes that each function is unique
> >>> but IIRC the idea of the function table was to group pins/groups
> >>> with the same function, e.g. function "gpio", groups 1,7,25,...
> >>
> >> Most of the functions you can use on the Berlin they will be unique and
> >> would
> >> only be used in one group, except for the 'gpio' one.
> >
> > Yeah, I had a similar discussion about it back then for mvebu. IIRC, the
> > correct answer is: Have a list of functions with groups assigned to it
> > no matter if there is only one group per function (or 40 per function as
> > it will be for gpio).
> >
> > Maybe Linus can give an update on how to deal with it?
> 
> Have you considered implementing pinmux_ops
> .gpio_request_enable(), .gpio_set_direction() and
> .gpio_disable_free() instead of defining groups for each
> and every GPIO?

The function 'gpio' can be found on different groups. But the Berlin pin muxing
does not allow to configure a pin individually. It is then not possible to mux
GPIO pins individually. For example the 'gpio' function of group 'GSM2' on the
BG2Q will mux GPIOs 17 *and* 18.

Groups does not have more than a single 'gpio' function.

Since the gpio_request_enable() comment says 'Implement this only if you can mux
every pin individually as GPIO', I did not considered implementing these
functions.

Antoine

-- 
Antoine T?nart, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
