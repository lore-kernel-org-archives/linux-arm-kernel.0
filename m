From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 19 Jun 2013 20:59:34 +0200
Subject: [PATCH v2 06/11] ARM:stixxxx: Add STiH415 SOC support
In-Reply-To: <51BAC6EC.8000703@st.com>
References: <1370855828-5318-1-git-send-email-srinivas.kandagatla@st.com>
 <1370856381-6644-1-git-send-email-srinivas.kandagatla@st.com>
 <CACRpkdZ-xnDO+bte4tyKDWwY4A_qWUhLru3dUmuY9MQwseP3uQ@mail.gmail.com>
 <51B6011E.1060909@st.com> <51BAC6EC.8000703@st.com>
Message-ID: <CACRpkdZDhR88Ezx0qVOk8bFtukSNsOtwQuQaFdn4u25OUYs+vA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jun 14, 2013 at 9:31 AM, Srinivas KANDAGATLA
<srinivas.kandagatla@st.com> wrote:
> On 10/06/13 17:38, Srinivas Kandagatla wrote:
>>> +++ b/arch/arm/boot/dts/stixxxx-pincfg.h
>>> >> @@ -0,0 +1,94 @@
>>> >> +#ifndef _STIXXXX_PINCFG_H_
>>> >> +#define _STIXXXX_PINCFG_H_
>>> >> +
>>> >> +/* Alternate functions */
>>> >> +#define ALT1   1
>>> >> +#define ALT2   2
>>> >> +#define ALT3   3
>>> >> +#define ALT4   4
>>> >> +#define ALT5   5
>>> >> +#define ALT6   6
>>> >> +#define ALT7   7
>>>
>>> Why is this part of the DT definitions? In the pinctrl world this
>>> is an intrinsic detail on how groups and functions are associated,
>>> not something that you hard-code into the device tree. The
>>> device tree should state how to combine functions with groups
>>> and those will be strings, not numerals.
>
> Hi Linus,
> I would like to get correct understanding of the point your raised here.
> I use these ALT function values in "st,function" property for pinctrl
> group as shown in this simple example:
>
> pinctrl_sbc_serial1:sbc_serial1 {
>        st,function = <ALT3>;
>        st,pins {
>               tx      = <&PIO2 6 OUT>;
>               rx      = <&PIO2 7 IN>;
>        };
> };
>
> If I do something like what rockchip pinctrl did the pinctrl group will
> look like.
>
> pinctrl_sbc_serial1:sbc_serial1 {
>        st,pins {
>               tx      = <&PIO2 6 OUT ALT3>;
>               rx      = <&PIO2 7 IN ALT3>;
>        };
> };
>
> Is this the right way to do it?

Basically there is no right way to do it since we haven't been able
to agree on a common way to represent pin controllers in the
device tree.

Those I have looked closer at tend to encode the selected
function/group as a string rather than a numeral though.

Yours,
Linus Walleij
