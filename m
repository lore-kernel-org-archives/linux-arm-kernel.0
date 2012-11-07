From: voice.shen@atmel.com (Bo Shen)
Date: Wed, 07 Nov 2012 15:38:24 +0800
Subject: [RFC patch v3 3/4] ASoC: atmel-ssc-dai: register dai and pcm
 directly
In-Reply-To: <20121106113908.GC10080@opensource.wolfsonmicro.com>
References: <1352181474-19597-1-git-send-email-voice.shen@atmel.com>
 <1352181474-19597-3-git-send-email-voice.shen@atmel.com>
 <20121106084814.GC5044@opensource.wolfsonmicro.com>
 <5098D930.8030403@atmel.com>
 <20121106113908.GC10080@opensource.wolfsonmicro.com>
Message-ID: <509A0FF0.7030501@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/6/2012 19:39, Mark Brown wrote:
> On Tue, Nov 06, 2012 at 05:32:32PM +0800, Bo Shen wrote:
>> On 11/6/2012 16:48, Mark Brown wrote:
>>> On Tue, Nov 06, 2012 at 01:57:53PM +0800, Bo Shen wrote:
>
>>> No, this isn't converting things to device tree which presumably is the
>>> goal here and obviously just doing the rename doesn't accomplish an
>>> enormous amount.  What I said was that you should instantiate the ASoC
>>> adaption when the machine driver needs to use them.  You shouldn't even
>>> need a separate device for this.
>
>> Maybe this is not the best solution, but just abstract audio as a
>> separate device. The other's still keep as a ssc library.
>
> It's not abstracting things, that's the whole problem.  It's putting the
> internals of how the Linux audio stack is organised into the device
> tree.  The point is that the SSC should be a library to all users.

OK. I will keep the SSC as a library for all users.

>>> Please do look at other platforms with similar hardware and do something
>>> similar to them.
>
>> I take some reference (e.g: freescale, marvell, invidia soc, this
>> RFC implement is similar with them), but don't find the similar
>> hardware with us. Please help provide the information who's HW is
>> similar with us. Thanks.
>
> A *huge* range of SoCs have generic serial ports - off the top of my
> head this includes at least OMAP, PXA and Freescale.  The same issue
> also applies to DMA controllers which affects almost all SoCs.

Thanks for this information, I will try to implement the SSC framework 
like this. If it is finished, I will send out v4 patch series.

Thanks again.

BRs,
Bo Shen
