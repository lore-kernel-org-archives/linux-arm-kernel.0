From: patrice.chotard@st.com (Patrice CHOTARD)
Date: Wed, 7 Mar 2018 07:59:40 +0000
Subject: [PATCH v2 2/3] ARM: dts: STi: Remove useless stdout-path for STi
 boards
In-Reply-To: <CAL_Jsq+-C5h1-xLOB39bhSsn9JR31UaEQL+cRwydD0a4w6sYNw@mail.gmail.com>
References: <1520323650-11030-1-git-send-email-patrice.chotard@st.com>
 <1520323650-11030-3-git-send-email-patrice.chotard@st.com>
 <CAL_Jsq+-C5h1-xLOB39bhSsn9JR31UaEQL+cRwydD0a4w6sYNw@mail.gmail.com>
Message-ID: <0bac9e25-0d63-2f11-b54a-0d6282fe19d3@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Rob

On 03/06/2018 02:26 PM, Rob Herring wrote:
> On Tue, Mar 6, 2018 at 2:07 AM,  <patrice.chotard@st.com> wrote:
>> From: Patrice Chotard <patrice.chotard@st.com>
>>
>> As serial interface is already specified into bootargs,
>> stdout-path can be removed.
> 
> Wrong way around. stdout-path is preferred over using console in bootargs.

Ah sorry, i misunderstood what you previously suggested. I will fix it.

Thanks

Patrice

> 
>>
>> Signed-off-by: Patrice Chotard <patrice.chotard@st.com>
>> ---
>>
>> v2: _ none
>>
>>   arch/arm/boot/dts/stih407-b2120.dts | 1 -
>>   arch/arm/boot/dts/stih410-b2120.dts | 1 -
>>   arch/arm/boot/dts/stih410-b2260.dts | 1 -
>>   arch/arm/boot/dts/stih418-b2199.dts | 1 -
>>   4 files changed, 4 deletions(-)
>>
>> diff --git a/arch/arm/boot/dts/stih407-b2120.dts b/arch/arm/boot/dts/stih407-b2120.dts
>> index 2c4d6033b448..074b4cd0ca89 100644
>> --- a/arch/arm/boot/dts/stih407-b2120.dts
>> +++ b/arch/arm/boot/dts/stih407-b2120.dts
>> @@ -15,7 +15,6 @@
>>
>>          chosen {
>>                  bootargs = "console=serial0,115200 clk_ignore_unused";
>> -               stdout-path = &sbc_serial0;
>>          };
>>
>>          memory at 40000000 {
>> diff --git a/arch/arm/boot/dts/stih410-b2120.dts b/arch/arm/boot/dts/stih410-b2120.dts
>> index 5422850641e8..eae3050984d0 100644
>> --- a/arch/arm/boot/dts/stih410-b2120.dts
>> +++ b/arch/arm/boot/dts/stih410-b2120.dts
>> @@ -15,7 +15,6 @@
>>
>>          chosen {
>>                  bootargs = "console=serial0,115200 clk_ignore_unused";
>> -               stdout-path = &sbc_serial0;
>>          };
>>
>>          memory at 40000000 {
>> diff --git a/arch/arm/boot/dts/stih410-b2260.dts b/arch/arm/boot/dts/stih410-b2260.dts
>> index ca347160e35d..c26e388bd1a4 100644
>> --- a/arch/arm/boot/dts/stih410-b2260.dts
>> +++ b/arch/arm/boot/dts/stih410-b2260.dts
>> @@ -16,7 +16,6 @@
>>
>>          chosen {
>>                  bootargs = "console=serial1,115200 clk_ignore_unused";
>> -               stdout-path = &uart1;
>>          };
>>
>>          memory at 40000000 {
>> diff --git a/arch/arm/boot/dts/stih418-b2199.dts b/arch/arm/boot/dts/stih418-b2199.dts
>> index dbf7bb704a1a..d948f774fee7 100644
>> --- a/arch/arm/boot/dts/stih418-b2199.dts
>> +++ b/arch/arm/boot/dts/stih418-b2199.dts
>> @@ -15,7 +15,6 @@
>>
>>          chosen {
>>                  bootargs = "console=serial0,115200 clk_ignore_unused";
>> -               stdout-path = &sbc_serial0;
>>          };
>>
>>          memory at 40000000 {
>> --
>> 1.9.1
>>
