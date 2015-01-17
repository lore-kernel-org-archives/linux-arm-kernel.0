From: wens@csie.org (Chen-Yu Tsai)
Date: Sat, 17 Jan 2015 18:37:50 +0800
Subject: sun9i pll4 upstream kernel code seems wrong
In-Reply-To: <54BA2C96.7050102@redhat.com>
References: <54BA2C96.7050102@redhat.com>
Message-ID: <CAGb2v66j8=VNkX_C=aEEO0cq53ELGnkZoNSk=wCy8n5j0w0mWw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Sat, Jan 17, 2015 at 5:34 PM, Hans de Goede <hdegoede@redhat.com> wrote:
> Hi ChenYu,
>
> Looking at drivers/clk/sunxi/clk-sun9i-core.c:
>
> sun9i_a80_get_pll4_factors(), and comparing it with
> the A80 user manual, things seem way off, this seems
> more accurate (although also possibly not quite)
> for pll1 / pll2 then for pll4, and the comment at
> the top does mention PLL1 once.

PLL1 was mentioned as I forgot to change that one in
the comment. I copied the comment section from others.

Other than that, I'm not sure what part is off. The
code was done without the user manual, only with the
SDK bits. I think in the SDK the minimum value of 12
for N factor was not mentioned. But other than that,
it should work fine.

Note the "div" variable uses a base frequency of 6,
not 24. I used a spreadsheet to do some calculations
to see if the code does output the right numbers.
Unfortunately I don't have either the notes or the
spreadsheet I used back then. It would take me a bit
of time to check.

> Note according to the datasheet pll4 should be treated
> as an inmutable pll fixed at 960 MHz, so maybe we should
> just drop the get_factors function for it ?

Is that acceptable? Or is there a readonly flag we should
set for the clock?

Regards,
ChenYu

> Luckily the struct clk_factors_config sun9i_a80_pll4_config
> is correct, so as long as we do not try to change the
> rate the current upstream code for pll4 does work.
>
> Regards,
>
> Hans
