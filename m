From: maxime.coquelin@st.com (Maxime Coquelin)
Date: Fri, 7 Mar 2014 09:34:36 +0100
Subject: [PATCH 3/5] pinctrl: st: Enhance the controller to manage
 unavailable registers
In-Reply-To: <CACRpkdYczgJiDQEfkiiJdXVtm-42_rRSedf6HGd7Eoq0ttWJ3A@mail.gmail.com>
References: <1393589841-6634-1-git-send-email-maxime.coquelin@st.com>	<1393589841-6634-4-git-send-email-maxime.coquelin@st.com>
 <CACRpkdYczgJiDQEfkiiJdXVtm-42_rRSedf6HGd7Eoq0ttWJ3A@mail.gmail.com>
Message-ID: <5319849C.2000804@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 03/07/2014 04:10 AM, Linus Walleij wrote:
> On Fri, Feb 28, 2014 at 8:17 PM, Maxime COQUELIN <maxime.coquelin@st.com> wrote:
>
>> From: Giuseppe Cavallaro <peppe.cavallaro@st.com>
>>
>> This patch adds a new logic inside the st pinctrl to manage
>> an unsupported scenario: some sysconfig are not available!
>>
>> This is the case of STiH407 where, although documented, the
>> following registers from SYSCFG_FLASH have been removed from the SoC.
>>
>> SYSTEM_CONFIG3040
>>     Output Enable pad control for all PIO Alternate Functions
>> and
>> SYSTEM_ CONFIG3050
>>     Pull Up pad control for all PIO Alternate Functions
>>
>> Without managing this condition an imprecise external abort
>> will be detect.
>>
>> To do this the patch also reviews the st_parse_syscfgs
>> and other routines to manipulate the registers only if
>> actually available.
>> In any case, for example the st_parse_syscfgs detected
>> an error condition but no action was made in the
>> st_pctl_probe_dt.
>>
>> Signed-off-by: Maxime Coquelin <maxime.coquelin@st.com>
>> Signed-off-by: Giuseppe Cavallaro <peppe.cavallaro@st.com>
>
> Hm this does not apply to my tree at all. It appears this is not
> a stand-alone, patch, so it depends on some other patch to
> pinctrl-sti?

Yes, it depends on patch 2 of the series (which is based on v3.14-rc4).
This is my mistake, the title of patch 2 is wrong:
ARM: STi: add pinctrl support for the STiH407 SoC

Should be:

pinctrl: st: add pinctrl support for the STiH407 SoC

I will resend the pinctrl patches rebased on your tree.

Thanks,
Maxime

>
> Yours,
> Linus Walleij
>
