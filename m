From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Mon, 01 Feb 2016 14:37:03 +0100
Subject: [PATCH v2 net 3/6] net: mvneta: Remove unused code
In-Reply-To: <56AF5E55.9030603@cogentembedded.com> (Sergei Shtylyov's message
 of "Mon, 1 Feb 2016 16:32:05 +0300")
References: <1454332067-16378-1-git-send-email-gregory.clement@free-electrons.com>
 <1454332067-16378-4-git-send-email-gregory.clement@free-electrons.com>
 <56AF5E55.9030603@cogentembedded.com>
Message-ID: <87d1sg7ds0.fsf@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Sergei,
 
 On lun., f?vr. 01 2016, Sergei Shtylyov <sergei.shtylyov@cogentembedded.com> wrote:

> Hello.
>
> On 2/1/2016 4:07 PM, Gregory CLEMENT wrote:
>
>> Since the commit 2dcf75e2793c ("net: mvneta: Associate RX queues with
>> each CPU") all the percpu irq are used and unmask at initialization, so
>
>    Unmasked, you mean?

yes and disabled would be more appropriate actually.

>
>> there is no point to unmask them first.
>
>    Mask, maybe (looking at the patch)?

not mask, but here again disable would be more appropriate. The code
removed disables the interrupt.


Thanks,

Gregory

>
>> Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
>> ---
>>   drivers/net/ethernet/marvell/mvneta.c | 8 --------
>>   1 file changed, 8 deletions(-)
>>
>> diff --git a/drivers/net/ethernet/marvell/mvneta.c b/drivers/net/ethernet/marvell/mvneta.c
>> index 3d6e3137f305..861b7e0d7d5f 100644
>> --- a/drivers/net/ethernet/marvell/mvneta.c
>> +++ b/drivers/net/ethernet/marvell/mvneta.c
>> @@ -3009,14 +3009,6 @@ static int mvneta_open(struct net_device *dev)
>>   		goto err_cleanup_txqs;
>>   	}
>>
>> -	/* Even though the documentation says that request_percpu_irq
>> -	 * doesn't enable the interrupts automatically, it actually
>> -	 * does so on the local CPU.
>> -	 *
>> -	 * Make sure it's disabled.
>> -	 */
>> -	mvneta_percpu_disable(pp);
>> -
>>   	/* Enable per-CPU interrupt on all the CPU to handle our RX
>>   	 * queue interrupts
>>   	 */
>
> MBR, Sergei
>

-- 
Gregory Clement, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
