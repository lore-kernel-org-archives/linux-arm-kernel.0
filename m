From: voice.shen@atmel.com (Bo Shen)
Date: Tue, 06 Nov 2012 17:32:32 +0800
Subject: [RFC patch v3 3/4] ASoC: atmel-ssc-dai: register dai and pcm
 directly
In-Reply-To: <20121106084814.GC5044@opensource.wolfsonmicro.com>
References: <1352181474-19597-1-git-send-email-voice.shen@atmel.com>
 <1352181474-19597-3-git-send-email-voice.shen@atmel.com>
 <20121106084814.GC5044@opensource.wolfsonmicro.com>
Message-ID: <5098D930.8030403@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/6/2012 16:48, Mark Brown wrote:
> On Tue, Nov 06, 2012 at 01:57:53PM +0800, Bo Shen wrote:
>
>>   static struct platform_device at91sam9260_ssc_device = {
>> -	.name	= "at91rm9200_ssc",
>> +	.name	= "at91rm9200_ssc_dai",
>>   	.id	= 0,
>>   	.dev	= {
>
> No, this isn't converting things to device tree which presumably is the
> goal here and obviously just doing the rename doesn't accomplish an
> enormous amount.  What I said was that you should instantiate the ASoC
> adaption when the machine driver needs to use them.  You shouldn't even
> need a separate device for this.

Maybe this is not the best solution, but just abstract audio as a 
separate device. The other's still keep as a ssc library.

> Please do look at other platforms with similar hardware and do something
> similar to them.

I take some reference (e.g: freescale, marvell, invidia soc, this RFC 
implement is similar with them), but don't find the similar hardware 
with us. Please help provide the information who's HW is similar with 
us. Thanks.

BRs,
Bo Shen
