From: viresh.kumar@linaro.org (viresh kumar)
Date: Mon, 9 Jul 2012 13:34:03 +0100
Subject: [PATCH 5/6] Clk: SPEAr1340: fix sys clock parent source and
 corresponding mask value
In-Reply-To: <4FFAC8D2.4080601@st.com>
References: <1341829866-26091-1-git-send-email-shiraz.hashim@st.com>
 <1341829866-26091-5-git-send-email-shiraz.hashim@st.com>
 <CAOh2x=n9dOaxW7hibg3M5XYTtbMkyrvUMt0ORKzWLULxUNtXEg@mail.gmail.com>
 <4FFAC8D2.4080601@st.com>
Message-ID: <CAOh2x=k5Tx2Gjrk1uRod-N-6gvYSeEKiZgms8gQfJ61TL8RXCQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 9, 2012 at 1:04 PM, vipul kumar samar
<vipulkumar.samar@st.com> wrote:
> On 7/9/2012 4:34 PM, viresh kumar wrote:
>>
>> On Mon, Jul 9, 2012 at 11:31 AM, Shiraz Hashim<shiraz.hashim@st.com>
>> wrote:
>>>
>>> From: Vipul Kumar Samar<vipulkumar.samar@st.com>
>>>
>>> sys_clk have multiple parents and selection of parent is depends on
>>
>>
>> s/ is//

I hope you haven't missed this comment :)

>>>   static const char *vco_parents[] = { "osc_24m_clk", "osc_25m_clk", };
>>> -static const char *sys_parents[] = { "none", "pll1_clk", "none", "none",
>>> -       "sys_synth_clk", "none", "pll2_clk", "pll3_clk", };
>>> +static const char *sys_parents[] = { "pll1_clk", "pll1_clk", "pll1_clk",
>>> +       "pll1_clk", "sys_synth_clk", "sys_synth_clk", "pll2_clk",
>>> "pll3_clk", };
>>
>>
>> Don't know what would be the implication of this?
>>
>> @Mike: Can you please tell us what should we do in such cases?
>>
>
> Is there any other solution for such cases ???

That's what i have asked mike for :)
Probably you can go through the clock framework code and check how these
names are used. Shouldn't be too complex to understand.

--
viresh
