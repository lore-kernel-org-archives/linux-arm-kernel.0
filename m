From: julien.grall@arm.com (Julien Grall)
Date: Tue, 26 Apr 2016 18:52:00 +0100
Subject: [PATCH v6 05/10] irqchip/gic-v3: Prefix all pr_* messages by
 "GICv3: "
In-Reply-To: <570E190C.8020203@linaro.org>
References: <1460388780-914-1-git-send-email-julien.grall@arm.com>
 <1460388780-914-6-git-send-email-julien.grall@arm.com>
 <570E190C.8020203@linaro.org>
Message-ID: <571FAAC0.3070706@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Hanjun,

Sorry for the late answer.

On 13/04/16 11:01, Hanjun Guo wrote:
> On 2016/4/11 23:32, Julien Grall wrote:
>> Currently, most of the pr_* messages in the GICv3 driver don't have a
>> prefix.  Add one to make clear where the messages come from.
>>
>> Signed-off-by: Julien Grall <julien.grall@arm.com>
>>
>> ---
>>      Changes in v6:
>>          - Patch added
>> ---
>>   drivers/irqchip/irq-gic-v3.c | 2 ++
>>   1 file changed, 2 insertions(+)
>>
>> diff --git a/drivers/irqchip/irq-gic-v3.c b/drivers/irqchip/irq-gic-v3.c
>> index 5b7d3c2..6dc6f03 100644
>> --- a/drivers/irqchip/irq-gic-v3.c
>> +++ b/drivers/irqchip/irq-gic-v3.c
>> @@ -15,6 +15,8 @@
>>    * along with this program.  If not, see
>> <http://www.gnu.org/licenses/>.
>>    */
>>
>> +#define pr_fmt(fmt)    "GICv3: " fmt
>
> I don't think this patch is needed, as GICv3 and GICv2 will
> not be probed at the same time, did I miss something?

True, however this make slightly easier to know which driver is in-use 
and avoid to prefix all the messages with "GIC:" or "GICv3:".

>
> Further more, there are prefixes in pr_fmt in this
> patch using GIC:, with your patch added, it will print:
>
> GIV3: GIC: .....
>
> which is not a good idea.

I think it is better than having message without prefix at all.

Regards,

-- 
Julien Grall
