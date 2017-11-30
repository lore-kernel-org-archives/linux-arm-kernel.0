From: pombredanne@nexb.com (Philippe Ombredanne)
Date: Thu, 30 Nov 2017 14:49:28 +0100
Subject: [PATCH v2] clk: stm32-h7: fix copyright
In-Reply-To: <CA+M3ks4pva9Kg+gj44KeUrDcKf9tn5O-0VkTv5uUebJ=812E3Q@mail.gmail.com>
References: <20171130084108.23083-1-benjamin.gaignard@st.com>
 <CAOFm3uG_7kChnvxW0SbHSMP5q_KSZeaNxjkKb774ZmcwukJ_Mw@mail.gmail.com>
 <CA+M3ks41cBBqDrEGFZm5yGO0j8funfTAaTf_u2cJoD1p3XpQUQ@mail.gmail.com>
 <CAOFm3uGMHrNyov=BkrXbJQeHnMgZCHK7ogTru8Bj9An7aTz9DQ@mail.gmail.com>
 <CA+M3ks4pva9Kg+gj44KeUrDcKf9tn5O-0VkTv5uUebJ=812E3Q@mail.gmail.com>
Message-ID: <CAOFm3uHsZCz=6tXsgVCtrk33X-AQB7EQKzmqf6MguKasoAH+Tg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Benjamin:

On Thu, Nov 30, 2017 at 2:05 PM, Benjamin Gaignard
<benjamin.gaignard@linaro.org> wrote:
> 2017-11-30 13:56 GMT+01:00 Philippe Ombredanne <pombredanne@nexb.com>:
>> On Thu, Nov 30, 2017 at 1:47 PM, Benjamin Gaignard
>> <benjamin.gaignard@linaro.org> wrote:
>>> 2017-11-30 12:28 GMT+01:00 Philippe Ombredanne <pombredanne@nexb.com>:
>>>> On Thu, Nov 30, 2017 at 9:41 AM, Benjamin Gaignard
>>>> <benjamin.gaignard@linaro.org> wrote:
>>>>> Uniformize STMicroelectronics copyrights header
>>>>> Add SPDX identifier
>>>>>
>>>>> Signed-off-by: Benjamin Gaignard <benjamin.gaignard@st.com>
>>>>> Acked-by: Alexandre TORGUE <alexandre.torgue@st.com>
>>>>> CC: Gabriel Fernandez <gabriel.fernandez@st.com>
>>>>> ---
>>>>>  drivers/clk/clk-stm32h7.c | 19 +++----------------
>>>>>  1 file changed, 3 insertions(+), 16 deletions(-)
>>>>>
>>>>> diff --git a/drivers/clk/clk-stm32h7.c b/drivers/clk/clk-stm32h7.c
>>>>> index 61c3e40507d3..db2b162c0d4c 100644
>>>>> --- a/drivers/clk/clk-stm32h7.c
>>>>> +++ b/drivers/clk/clk-stm32h7.c
>>>>> @@ -1,20 +1,7 @@
>>>>> +// SPDX-License-Identifier: GPL-2.0
>>>>>  /*
>>>>> - * Copyright (C) Gabriel Fernandez 2017
>>>>> - * Author: Gabriel Fernandez <gabriel.fernandez@st.com>
>>>>> - *
>>>>> - * License terms: GPL V2.0.
>>>>> - *
>>>>> - * This program is free software; you can redistribute it and/or modify it
>>>>> - * under the terms and conditions of the GNU General Public License,
>>>>> - * version 2, as published by the Free Software Foundation.
>>>>> - *
>>>>> - * This program is distributed in the hope it will be useful, but WITHOUT
>>>>> - * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
>>>>> - * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
>>>>> - * more details.
>>>>> - *
>>>>> - * You should have received a copy of the GNU General Public License along with
>>>>> - * this program.  If not, see <http://www.gnu.org/licenses/>.
>>>>> + * Copyright (C) STMicroelectronics 2017
>>>>> + * Author: Gabriel Fernandez <gabriel.fernandez@st.com> for STMicroelectronics.
>>>>>   */
>>>>>
>>>>>  #include <linux/clk.h>
>>>>
>>>> Awesome! Don't you like it when you remove this type of things?
>>>
>>> Yes but is also means that many other STM files need to be updated...
>>
>> Sure thing. I have a FLOSS tool to help with this FWIW. I would be
>> glad to help as needed.
>
> Do you have a link to this tool ?

https://github.com/nexB/scancode-toolkit

And the experimental 833-espedexify [1] branch has a new option such
that if a single license is detected exactly and is clearly a well
defined SPDX license, it can also delete the boilerplate and inject
the correct SPDX identifier at once (though not at the canonical first
line place, and not being too smart about the comment style that is
hardcoded to //)

NB: I only spent a couple hours on this new license text decrapifier
option [2] and it is very (too) strict, making too many checks before
deciding to remove boilerplate  ... but that would be my pleasure to
make it work for you and iron the quirks. I am not qualified to
contribute code to the kernel (though I dabble enough in C to have a
few odd patches of mine in strace) BUT I grok Python and a few thing
about licensing alright.

FWIW, this is the tool that has been used to help greg k-h and tglx
injecting the first pass of SPDX ids and that should be useful to do
more of it. As a weird twist of fate, it does not do (yet) a great job
at the detection of normalized SPDX-License-Identifiers .... but then
the whole point is that once you have these a good ole grep is all you
should need, right?  But it is otherwise best in class for license
detection and uses eventually a very simple algo: a good ole diff with
a few twists.

It is routinely used by several large and small projects, orgs and
companies for license detection and compliance and is supposed to be
the least worst of the tools in that domain. At least I am working on
hard to make it so.

And bonus: any bug reported or ticket or question reported by a kernel
contributor gets VIP treatment, whatever this means :)

[1] https://github.com/nexB/scancode-toolkit/tree/833-espedexify
[2] https://github.com/nexB/scancode-toolkit/blob/833-espedexify/src/scancode/plugin_espedexify.py

-- 
Cordially
Philippe Ombredanne
