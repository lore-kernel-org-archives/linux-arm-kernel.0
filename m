From: wens@csie.org (Chen-Yu Tsai)
Date: Wed, 7 Sep 2016 00:20:10 +0800
Subject: [PATCH v2 2/7] clk: sunxi-ng: div: Allow to set a maximum
In-Reply-To: <20160906121837.7517-3-maxime.ripard@free-electrons.com>
References: <20160906121837.7517-1-maxime.ripard@free-electrons.com>
 <20160906121837.7517-3-maxime.ripard@free-electrons.com>
Message-ID: <CAGb2v66C9GJ5Svm+7NE2cStc5KiNgoriB329K4fhZJMTSbZ8Kw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Sep 6, 2016 at 8:18 PM, Maxime Ripard
<maxime.ripard@free-electrons.com> wrote:
> Some dividers might have a maximum value that is lower than the width of
> the register.
>
> Add a field to _ccu_div to handle those case properly. If the field is set
> to 0, the code will assume that the maximum value is the maximum one that
> can be used with the field register width.

This is a bit confusing. What is the maximum referring to? The raw value
in the register? Or the actual divider?

Personally I'd go with the maximum valid value of the register. You
could get rid of the special power-of-2 handling code you added.

Either way I think the message and the field name should be more explicit.

>
> Otherwise, we'll use whatever value has been set.
>
> Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>

[...]

The code looks correct.


Regards
ChenYu
