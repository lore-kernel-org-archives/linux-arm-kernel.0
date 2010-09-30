From: shiraz.hashim@st.com (Shiraz Hashim)
Date: Thu, 30 Sep 2010 15:07:08 +0530
Subject: [PATCH 52/74] ST SPEAr13xx: Adding CPU hotplug support added
	for SMP platforms
In-Reply-To: <AANLkTimzKd14U0k10Pjgb9UBWB2gixivvja8Qh_zMMLR@mail.gmail.com>
References: <cover.1283161023.git.viresh.kumar@st.com>	<1980a48cb88189ce617fbfa2742d3259dd400b7b.1283161023.git.viresh.kumar@st.com>
	<AANLkTimzKd14U0k10Pjgb9UBWB2gixivvja8Qh_zMMLR@mail.gmail.com>
Message-ID: <4CA45A44.80604@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Sundar,

Sorry for replying so late :).

On 9/3/2010 11:30 AM, Sundar wrote:
> Hi,
> 
> On Mon, Aug 30, 2010 at 4:09 PM, Viresh KUMAR <viresh.kumar@st.com> wrote:
>> From: Deepak Sikri <deepak.sikri@st.com>
>>
>> Signed-off-by: Deepak Sikri <deepak.sikri@st.com>
>> Signed-off-by: shiraz hashim <shiraz.hashim@st.com>
>> Signed-off-by: Viresh Kumar <viresh.kumar@st.com>
>> ---
> 
>> +       flush_cache_all();
>> +       asm volatile(
>> +       "       mcr     p15, 0, %1, c7, c5, 0\n"
>> +       "       mcr     p15, 0, %1, c7, c10, 4\n"
> 
> Isnt this a Cortex-A9 platform? If yes, then this is not implemented
> on the Cortex-A9 if I am right.
> You should use a dsb() here.

yes, I would place dsb here.

>> +               /*
>> +                * here's the WFI
>> +                */
>> +               asm(".word      0xe320f003\n"
>> +                   :
> 
> Also, why not a simple asm volatile("wfi" : : : "memory"); instead of
> hard coded values.

Would add a wfi() macro in asm/system.h including sev() as suggested by
Russell. This statement would be replaced by a simple wfi().

regards
Shiraz
