From: haojian.zhuang@gmail.com (Haojian Zhuang)
Date: Sun, 10 Nov 2013 16:30:31 +0800
Subject: [PATCH v2 09/27] mtd: nand: pxa3xx: Split FIFO size from
 to-be-read FIFO count
In-Reply-To: <20131104121305.GD2516@localhost>
References: <1382137374-21251-1-git-send-email-ezequiel.garcia@free-electrons.com>
 <1382137374-21251-10-git-send-email-ezequiel.garcia@free-electrons.com>
 <20131103223646.GC5896@gmail.com> <20131104121305.GD2516@localhost>
Message-ID: <527F4427.2090409@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/04/2013 08:13 PM, Ezequiel Garcia wrote:
> On Sun, Nov 03, 2013 at 05:36:50PM -0500, Huang Shijie wrote:
>> On Fri, Oct 18, 2013 at 08:02:36PM -0300, Ezequiel Garcia wrote:
>>>
>>> -	switch (host->page_size) {
>>> +	switch (info->fifo_size) {
>>>   	case 2048:
>> 	
>> there is a item in the builtin_flash_types:
>> { "4GiB 8-bit",    0xd7ec, 128, 4096,  8,  8, 8192, &timing[1] },
>>
>> The original host->page_size could be 4096, how can the old code support
>> this nand with page-size is 4096?
>>
>
> Ah, nice catch. I completely missed that line!
>
> I've rechecked the PXA3xx spec. but it makes no mention to supporting
> 4096 (and it doesn't mention the FIFO buffer's size).
>
> On the other side, and AFAIK, the 'splitted' command semantics in the
> NFCv2 (the one I'm working on) was added specifically to support
> page-size of 4096 and 8192.
>
> In other words, I'm not sure how could the old code support 4096!
> The support was adding long ago, in this commit:
>
> commit d3490dfdbc453a16bc7f3cff731c9f7851735ab3
> Author: Haojian Zhuang <haojian.zhuang@marvell.com>
> Date:   Thu Sep 10 14:33:30 2009 +0800
>
> pxa3xx_nand: add new nand chip support
>
> Support samsung 2GbX8 and 32GbX8 nand flash.
> Support micron 4GbX8 and 4GbX16 nand flash.
>
> Signed-off-by: Haojian Zhuang <haojian.zhuang@marvell.com>
> Signed-off-by: Eric Miao <eric.y.miao@gmail.com>
>
> So, maybe they can provide some answers. Haojian? Eric?
>

Hi Ezequiel,

I can't remember all details. The main problem is that I failed to find 
the flash datasheet.

Regards
Haojian
