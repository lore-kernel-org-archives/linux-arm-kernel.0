From: padma.kvr@gmail.com (Padma Venkat)
Date: Sat, 2 Feb 2013 08:00:54 +0530
Subject: [PATCH V2 4/4] DMA: PL330: Modify pl330 filter based on new
 generic dma dt bindings.
In-Reply-To: <201302011523.25771.arnd@arndb.de>
References: <1359723116-18173-1-git-send-email-padma.v@samsung.com>
 <1359723116-18173-5-git-send-email-padma.v@samsung.com>
 <201302011523.25771.arnd@arndb.de>
Message-ID: <CAAgF-Bf55eN2WOgU5nQa=nF76fHvBHR7NdmvoBpF-n4ke6rd1g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd,

On Fri, Feb 1, 2013 at 8:53 PM, Arnd Bergmann <arnd@arndb.de> wrote:
> On Friday 01 February 2013, Padmavathi Venna wrote:
>> This patch modify the filter function to filter the required channel
>> based on new filter params.
>>
>> Signed-off-by: Padmavathi Venna <padma.v@samsung.com>
>
> The result of this looks good, but I fear that changing the filter function
> like this wil break all drivers that currently use the plat-samsung/dma-ops.c
> code. For migration purposes, I think the best way is to change
> samsung_dmadev_request() to match the new filter_param format.
>
> After that is done, you can migrate all the drivers using samsung_dma_get_ops
> over to the new dma_request_slave_channel interface without breaking
> anything when only part of the series is applied.
>
>         Arnd

Please check the below link where I made the dma request compatible to
both DT and non-DT

http://git.kernel.org/?p=linux/kernel/git/broonie/sound.git;a=commit;h=e7ba5f1d0f6292e1b99c63cc4bb74c70232e9065
http://git.kernel.org/?p=linux/kernel/git/broonie/sound.git;a=commit;h=b5be04d35dbb2e00ab27a97bfd26e17019e857ef

Please let me know if any changes required.

Thanks for the suggestions.
Padma
