From: amelie.delaunay@st.com (Amelie DELAUNAY)
Date: Wed, 11 Jan 2017 14:39:06 +0100
Subject: [PATCHv4 3/8] rtc: add STM32 RTC driver
In-Reply-To: <20170111130438.GA9327@Red>
References: <1484138905-5903-1-git-send-email-amelie.delaunay@st.com>
 <20170111130438.GA9327@Red>
Message-ID: <b9ed4f2f-5d41-6041-0215-c3ff11843198@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Corentin,

Thanks for reviewing,

On 01/11/2017 02:04 PM, Corentin Labbe wrote:
> On Wed, Jan 11, 2017 at 01:48:25PM +0100, Amelie Delaunay wrote:
>> This patch adds support for the STM32 RTC.
>>
>> Signed-off-by: Amelie Delaunay <amelie.delaunay@st.com>
>> ---
>>  drivers/rtc/Kconfig     |  11 +
>>  drivers/rtc/Makefile    |   1 +
>>  drivers/rtc/rtc-stm32.c | 727 ++++++++++++++++++++++++++++++++++++++++++++++++
>>  3 files changed, 739 insertions(+)
>>  create mode 100644 drivers/rtc/rtc-stm32.c
>
> [...]
>> +/* STM32_PWR_CR */
>> +#define PWR_CR				0x00
>> +/* STM32_PWR_CR bit field */
>> +#define PWR_CR_DBP			BIT(8)
>> +
>> +static struct regmap *dbp;
>
> Hello
>
> Why using a global static struct ?
> You could alloc a private structure in probe for storing it and use platform_set_drvdata()
>
This is to stay closer to how this backup domain protection is managed 
in clk-stm32f4 driver, but I realize that I haven't the same 
constraints. I'll move this struct in my stm32_rtc private structure.

> Regards
>

Regards
