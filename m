From: linus.walleij@linaro.org (Linus Walleij)
Date: Fri, 14 Mar 2014 10:20:55 +0100
Subject: [PATCH v4 4/6] pinctrl: st: Use ARRAY_SIZE instead of raw value
 for number of delays
In-Reply-To: <1394634313.28839.57.camel@joe-AO722>
References: <1394614210-15698-1-git-send-email-maxime.coquelin@st.com>
 <1394614210-15698-5-git-send-email-maxime.coquelin@st.com>
 <1394634313.28839.57.camel@joe-AO722>
Message-ID: <CACRpkda0Z15zC=d8xe+KyHqgmTCHbnUjL14fBmtscpR-2kHtFQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 12, 2014 at 3:25 PM, Joe Perches <joe@perches.com> wrote:
> On Wed, 2014-03-12 at 09:50 +0100, Maxime COQUELIN wrote:
>> This patch replaces the raw values with ARRAY_SIZE for assigning the
>> ninput_delays and noutput_delays fields of STiH416's st_pctl_data struct.
>
> trivial note:
>
>> diff --git a/drivers/pinctrl/pinctrl-st.c b/drivers/pinctrl/pinctrl-st.c
> []
>> @@ -384,9 +384,9 @@ static unsigned int stih416_delays[] = {0, 300, 500, 750, 1000, 1250, 1500,
>>  static const struct st_pctl_data  stih416_data = {
>>       .rt_style       = st_retime_style_dedicated,
>>       .input_delays   = stih416_delays,
>> -     .ninput_delays  = 14,
>> +     .ninput_delays  = ARRAY_SIZE(stih416_delays),
>>       .output_delays  = stih416_delays,
>> -     .noutput_delays = 14,
>> +     .noutput_delays = ARRAY_SIZE(stih416_delays),
>>       .alt = 0, .oe = 40, .pu = 50, .od = 60, .rt = 100,
>>  };
>>
>
> drivers/pinctrl/pinctrl-st.c-   unsigned int    *input_delays;
> drivers/pinctrl/pinctrl-st.c-   unsigned int    *output_delays;
>
> It may be better to change these to const unsigned int *
> and change
>
> static unsigned int stih416_delays[] = {
>
> to static const

Good point. Patches accepted :-)

Yours,
Linus Walleij
