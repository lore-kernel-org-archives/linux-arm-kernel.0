From: patrice.chotard@st.com (Patrice CHOTARD)
Date: Mon, 15 Jan 2018 17:27:13 +0000
Subject: [PATCH 02/14] mmc: mmci: Don't pretend all variants to have
 MCI_STARBITERR flag
In-Reply-To: <CAPDyKFpqENchQs7c1BSJnorTgidbwHFAHByHJU3t9TV6uHurxA@mail.gmail.com>
References: <1515759368-16946-1-git-send-email-patrice.chotard@st.com>
 <1515759368-16946-3-git-send-email-patrice.chotard@st.com>
 <CAPDyKFpqENchQs7c1BSJnorTgidbwHFAHByHJU3t9TV6uHurxA@mail.gmail.com>
Message-ID: <5ffa4035-0cde-119e-b53e-1af6daab83cc@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Ulf

On 01/15/2018 01:32 PM, Ulf Hansson wrote:
> On 12 January 2018 at 13:15,  <patrice.chotard@st.com> wrote:
>> From: Patrice Chotard <patrice.chotard@st.com>
>>
>> This patch prepares for supporting the STM32 variant that
>> has no such bit in the status register.
>>
>> Signed-off-by: Andrea Merello <andrea.merello@gmail.com>
>> Signed-off-by: Patrice Chotard <patrice.chotard@st.com>
>> ---
>>   drivers/mmc/host/mmci.c | 16 ++++++++++++++--
>>   1 file changed, 14 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/mmc/host/mmci.c b/drivers/mmc/host/mmci.c
>> index 3125dc0..7e56f85 100644
>> --- a/drivers/mmc/host/mmci.c
>> +++ b/drivers/mmc/host/mmci.c
>> @@ -83,6 +83,8 @@
>>    * @qcom_dml: enables qcom specific dma glue for dma transfers.
>>    * @reversed_irq_handling: handle data irq before cmd irq.
>>    * @mmcimask1: true if variant have a MMCIMASK1 register.
>> + * @start_err: true is the variant has STARTBITERR bit inside MMCISTATUS
>> + *            register.
>>    */
>>   struct variant_data {
>>          unsigned int            clkreg;
>> @@ -113,6 +115,7 @@ struct variant_data {
>>          bool                    qcom_dml;
>>          bool                    reversed_irq_handling;
>>          bool                    mmcimask1;
>> +       bool                    start_err;
> 
> To be consistent with how we implement support for similar variant
> variations, I would prefer to have this being a u32. Something along
> the lines of how the "busy_detect_flag" is being used.

OK i will update this in v2

Thanks

Patrice

> 
> Otherwise this looks good to me.
> 
> [...]
> 
> Kind regards
> Uffe
> 
