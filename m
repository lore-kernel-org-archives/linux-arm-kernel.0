From: xuwei5@hisilicon.com (Wei Xu)
Date: Thu, 25 Jun 2015 08:57:35 +0100
Subject: [GIT PULL]Hisilicon hip04 soc and D01 board DT updates for v4.2
In-Reply-To: <CAMAWPa8LZsmcc-fvcM7UcvJ1+QR8hQjUkY1QcFU+MW2s1nxj2Q@mail.gmail.com>
References: <554CC781.9010705@hisilicon.com>	<CANMBJr6bOu9-w_gODrJO_4-VczXOo024wnyhAtndFGTGrWUs6g@mail.gmail.com>	<5554E035.6020004@hisilicon.com>	<2091000.vbEIJY2sm3@wuerfel>
 <CAMAWPa8LZsmcc-fvcM7UcvJ1+QR8hQjUkY1QcFU+MW2s1nxj2Q@mail.gmail.com>
Message-ID: <558BB46F.8030406@hisilicon.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 6/25/2015 1:24 AM, Kevin Hilman wrote:
> On Fri, May 15, 2015 at 2:28 AM, Arnd Bergmann <arnd@arndb.de> wrote:
>> On Thursday 14 May 2015 18:49:41 Wei Xu wrote:
>>> On 5/14/2015 2:55 PM, Tyler Baker wrote:
>>>> On 14 May 2015 at 06:36, Tyler Baker <tyler.baker@linaro.org> wrote:
>>>>> On 14 May 2015 at 01:49, Wei Xu <xuwei5@hisilicon.com> wrote:
>>>>>> On 5/13/2015 8:20 PM, Tyler Baker wrote:
>>>>>>> On 12 May 2015 at 08:09, Wei Xu <xuwei5@hisilicon.com> wrote:
>>>>>>> When this was pulled into arm-soc, the kernelci.org bot reported
>>>>>>> hip04-d01 boot failures[1]. Before bisecting, I decided to wait a day
>>>>>>> and double check the status of -next in case there were needed
>>>>>>> dependencies from other trees. However, now there are the same
>>>>>>> hip04-d01 boot failures in next-20150513[2]. My robot has bisected[3]
>>>>>>> these boot failures down to...
>>>>>>>
>>>>>>> 828fcfe3c84ade68ecc3f1ba78baebc1654977f3 is the first bad commit
>>>>>>> commit 828fcfe3c84ade68ecc3f1ba78baebc1654977f3
>>>>>>> Author: Zhou Wang <wangzhou.bry@gmail.com>
>>>>>>> Date:   Wed Mar 25 14:57:45 2015 +0800
>>>>>>>
>>>>>>>     ARM: dts: hip04: add GPIO pieces
>>>>>>>
>>>>>>>     Hisilicon Soc hip04 has four GPIO controllers, each one has 32
>>>>>>>     GPIOs and can be configured to be an interrupt controller.The GPIO
>>>>>>>     controllers are compatible with the snps,dw-apb-gpio driver.
>>>>>>>     This patch add the corresponding device tree nodes.
>>>>>>>
>>>>>>>     Acked-by: Linus Walleij <linus.walleij@linaro.org>
>>>>>>>     Signed-off-by: Zhou Wang <wangzhou1@hisilicon.com>
>>>>>>>     Signed-off-by: Wei Xu <xuwei5@hisilicon.com>
>>>>>>
>>>>>>
>>>>>> It is a little strange.
>>>>>> I checked to this commit "28837bc3e732610ebc7c88ce205dbe43245b1cb8"
>>>>>> at "git://git.kernel.org/pub/scm/linux/kernel/git/arm/arm-soc.git".
>>>>>> and compiled with "hisi_defconfig".
>>>>>>
>>>>>> It is booting OK and the log is as below.
>>>>>> And I have also uploaded the binary at "https://github.com/hisilicon/boards/tree/master/D01/for-tyler".
>>>>>> Could you please confirm it again?
>>>>>
>>>>> It appears we are using different image formats to boot. The link
>>>>> above shows .kernel, .monitor, .text...can I split the kernel//dtb out
>>>>> from .kernel?
>>>>>
>>>>> I am using zImage and hip04-d01.dtb directly[1] with UEFI to TFTP
>>>>> boot. Could you try this method?
>>>
>>>> For good measure, I tried booting next-20150514 on the D01 hardware in
>>>> the Linaro lab to confirm the same failure I see locally. It fails to
>>>> boot as well[1].
>>>
>>> Thanks!
>>> I have tried your binary files and found it is stuck in the UEFI.
>>> I will continue to investigate this issue.
>>>
>>> Hi Arnd,
>>>
>>> Could you please revert that branch?
>>> After I resolve this issue I will send another pull request.
>>> Sorry to bother you!
>>> Thanks!
>>>
>>
>> I have applied the patch below on the for-next branch now, to revert everything
>> from this pull request. I have not changed the contents of the next/dt branch
>> for now, and am still waiting for a bug fix. Once you know what caused the
>> problem, please send a fix that applies on top of the next/dt branch in arm-soc,
>> and I'll reactivate it.

Hi Kevin,

> 
> FYI... I'm not aware of any fixes  for this, so I'll be removing this
> branch from the next/dt branch of arm-soc before sending to Linus.
>

OK.
We are still investigating this issue.
Once we resolved it, I will send out a new patch.
Thanks!

Best Regards,
Wei


> Kevin
> 
> .
> 
