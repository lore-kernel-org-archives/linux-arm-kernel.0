From: zhangfei.gao@linaro.org (zhangfei)
Date: Wed, 19 Jun 2013 08:37:14 +0800
Subject: [PATCH v3 2/2] i2c: designware: add two optional property
 tx/rx-fifo-size
In-Reply-To: <20130618162257.GF7718@katana>
References: <1370918230-24793-1-git-send-email-zhangfei.gao@linaro.org>
 <1370918230-24793-3-git-send-email-zhangfei.gao@linaro.org>
 <20130618162257.GF7718@katana>
Message-ID: <51C0FD3A.2060309@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 13-06-19 12:22 AM, Wolfram Sang wrote:
> On Tue, Jun 11, 2013 at 10:37:10AM +0800, Zhangfei Gao wrote:
>> rx-fifo-size and tx-fifo-size will be updated if provided from dts
>>
>> Signed-off-by: Zhangfei Gao <zhangfei.gao@linaro.org>
>> CC: Baruch Siach <baruch@tkos.co.il>
>> ---
>>   .../devicetree/bindings/i2c/i2c-designware.txt     |    7 +++++++
>>   drivers/i2c/busses/i2c-designware-platdrv.c        |    3 +++
>>   2 files changed, 10 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/i2c/i2c-designware.txt b/Documentation/devicetree/bindings/i2c/i2c-designware.txt
>> index e42a2ee..84717fe 100644
>> --- a/Documentation/devicetree/bindings/i2c/i2c-designware.txt
>> +++ b/Documentation/devicetree/bindings/i2c/i2c-designware.txt
>> @@ -6,6 +6,11 @@ Required properties :
>>    - reg : Offset and length of the register set for the device
>>    - interrupts : <IRQ> where IRQ is the interrupt number.
>>
>> +Optional properties:
>> +
>> + - rx-fifo-size : 1 cell, Rx fifo size
>> + - tx-fifo-size : 1 cell, Tx fifo size
>> +
>
> I'd think the bindings are okay, yet I wonder they are not more used in
> practice. So, an ack from a dt-expert would be appreciated.

Thanks Wolfram,
The patches also acked by Baruch, the original writer.

Some platform can not provide fifo info from register 
DW_IC_COMP_PARAM_1, hisilicon read such register is 0.


>> +	of_property_read_u32(np, "rx-fifo-size", &dev->rx_fifo_depth);
>> +	of_property_read_u32(np, "tx-fifo-size", &dev->tx_fifo_depth);
>
> Those can fail.

"rx-fifo-size and tx-fifo-size will be updated if provided from dts"
The thought is if dts have the optional properties, then update.
otherwise just use original value, read from register.

So I thought the read fail is fine?
