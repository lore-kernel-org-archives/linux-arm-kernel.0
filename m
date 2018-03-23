From: andy.shevchenko@gmail.com (Andy Shevchenko)
Date: Fri, 23 Mar 2018 18:31:05 +0200
Subject: [PATCH v3 3/3] pinctrl: qcom: Don't allow protected pins to be
 requested
In-Reply-To: <152182210780.178046.13284917877743312593@swboyd.mtv.corp.google.com>
References: <20180321165848.89751-1-swboyd@chromium.org>
 <20180321165848.89751-4-swboyd@chromium.org>
 <97380342-c3aa-5d34-7b22-f6ebbab4bafe@codeaurora.org>
 <1521804964.23017.96.camel@linux.intel.com>
 <152182210780.178046.13284917877743312593@swboyd.mtv.corp.google.com>
Message-ID: <CAHp75VeTxGu-pxqde_egsqUkLBdZujoJv=0YEj9cv8ujnthyPA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Mar 23, 2018 at 6:21 PM, Stephen Boyd <swboyd@chromium.org> wrote:

>        bitmap_zero(chip->valid_mask, max_gpios);
>        for (i = 0; i < len; i++)
>                set_bit(tmp[i], chip->valid_mask);

Looking to this code I just realized it would be nice to have

{of,device}_property_read_bitmask() where bitmask_parse() is called.

Since it related to change a binding, I would really take couple of
days to hear other opinions.

In the above case, you need to supply a string, like

"1-5,16,18,25"

-- 
With Best Regards,
Andy Shevchenko
