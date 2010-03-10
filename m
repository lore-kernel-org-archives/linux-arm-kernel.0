From: linus.ml.walleij@gmail.com (Linus Walleij)
Date: Wed, 10 Mar 2010 06:15:10 +0100
Subject: [PATCH 07/11] ST SPEAr: Added source files for SPEAr3xx machine
	family
In-Reply-To: <4B95F339.5040903@st.com>
References: <1267592861-26911-1-git-send-email-viresh.kumar@st.com>
	<1267592861-26911-2-git-send-email-viresh.kumar@st.com>
	<1267592861-26911-3-git-send-email-viresh.kumar@st.com>
	<1267592861-26911-4-git-send-email-viresh.kumar@st.com>
	<1267592861-26911-5-git-send-email-viresh.kumar@st.com>
	<1267592861-26911-6-git-send-email-viresh.kumar@st.com>
	<1267592861-26911-7-git-send-email-viresh.kumar@st.com>
	<1267592861-26911-8-git-send-email-viresh.kumar@st.com>
	<63386a3d1003082246g2752ccf4ob52d5bb01dfb264c@mail.gmail.com>
	<4B95F339.5040903@st.com>
Message-ID: <63386a3d1003092115ia91b7d9l64cc89ebd72d7e22@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2010/3/9 Viresh KUMAR <viresh.kumar@st.com>:

> On 3/9/2010 12:16 PM, Linus Walleij wrote:
>> Hi Viresh,
>>> (...)
>>> + ? ? ? .irq = {IRQ_UART, NO_IRQ},
>>> + ? ? ? .periphid = 0x00041011,
>>> +};
>>
>> You're hardcoding the PrimeCell ID to the ARM version, (...)
>
> Actually PL011 is customized by ST's nomadik platform. And hence above
> is true for nomadik only. We are using ARM's version of PL011 without
> any customization over it and so id for our case is still 0x00041011.

OK then you can probably just delete the .periphid line, the only thing that
will do is to override the number found in the ID registers with the same
number. If this doesn't work you certainly have a modified version anyway.

Linus
