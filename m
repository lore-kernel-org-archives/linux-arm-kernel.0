From: computersforpeace@gmail.com (Brian Norris)
Date: Fri, 15 Nov 2013 10:05:35 -0800
Subject: [PATCH v5 00/14] Armada 370/XP NAND support
In-Reply-To: <52862FED.20501@gmail.com>
References: <1384464339-6817-1-git-send-email-ezequiel.garcia@free-electrons.com>
 <20131114230436.GV9468@ld-irv-0074.broadcom.com>
 <20131114230540.GW9468@ld-irv-0074.broadcom.com>
 <20131114231528.GA9793@localhost> <5285D44C.7080501@gmail.com>
 <20131115130711.GA2496@localhost> <528625EA.8060406@gmail.com>
 <20131115142659.GB2496@localhost> <52862FED.20501@gmail.com>
Message-ID: <CAN8TOE88uoitm+8J6fXAnAWf1Rb4favyVqCvjCU+WHdBZ9m8cA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 15, 2013 at 6:30 AM, Daniel Mack <zonque@gmail.com> wrote:
> On 11/15/2013 03:27 PM, Ezequiel Garcia wrote:
>> On Fri, Nov 15, 2013 at 02:47:22PM +0100, Daniel Mack wrote:
>>> On 11/15/2013 02:07 PM, Ezequiel Garcia wrote:
>>>> On Fri, Nov 15, 2013 at 08:59:08AM +0100, Daniel Mack wrote:
>>>>> On 11/15/2013 12:15 AM, Ezequiel Garcia wrote:
>>>>>> On Thu, Nov 14, 2013 at 03:05:40PM -0800, Brian Norris wrote:
>>>>>>> + Daniel (missed the CC)
>>>>>>>
>>>>>>> On Thu, Nov 14, 2013 at 03:04:36PM -0800, Brian Norris wrote:
>>>>>>>> On Thu, Nov 14, 2013 at 06:25:25PM -0300, Ezequiel Garcia wrote:
>>>>>>>>> * Changes from v4
>>>>>>>>>
>>>>>>>>>   * Rebased on top of l2-mtd.git origin/next branch
>>>>>>>>>
>>>>>>>>>   * Fixed is_ready flag reset, renamed by a more descriptive
>>>>>>>>>     and readble "need_wait".
>>>>>>>>>
>>>>>>>>
>>>>>>>> ...
>>>>>>>>
>>>>>>>> I think this series is now good as-is. Pushing to l2-mtd.git/next.
>>>>>>>> Thanks for the efforts! I can submit my extra diff from patch 12 as a
>>>>>>>> separate patch for review.
>>>>>>>>
>>>>>>>> Do you have any available regression tests? Or was there somebody else
>>>>>>>> we could run this by for some Tested-by's? Daniel Mack, perhaps?
>>>>>>>
>>>>>>> Brian
>>>>>>
>>>>>> Yes, if Daniel (or anybody else) can push a Tested-by, that's better because
>>>>>> he's a "third-party" tester.
>>>>>
>>>>> Yes. Sorry, I could only partially follow all the discussions around
>>>>> these patch sets, but I can certainly do a quick regression test on my
>>>>> pxa3xx platform.
>>>>>
>>>>> Ezequiel, could you maybe point me to a repository where I can pull
>>>>> everything from you want me to have a look at?
>>>>>
>>>>
>>>> Latest work is at the next branch in l2-mtd.git:
>>>>
>>>> http://git.infradead.org/l2-mtd.git/shortlog/refs/heads/next
>>>>
>>>> You could try that, with Brian's latest patch:
>>>>
>>>> http://patchwork.ozlabs.org/patch/291408/
>>>
>>> Thanks Ezequiel! Tested with and without DMA on my PXA3xx platform and
>>> it seems to work just well. Awesome work :)
>>>
>>> [    2.675715] NAND device: Manufacturer ID: 0x20, Chip ID: 0xa1 (ST
>>> Micro NAND01GR3B2CZA6)
>>> [    2.683965] NAND device: 128MiB, SLC, page size: 2048, OOB size: 64
>>> [    2.690867] Scanning device for bad blocks
>>> [    2.977987] Bad eraseblock 528 at 0x000004200000
>>> [    2.983394] Bad eraseblock 529 at 0x000004220000
>>> [    3.251150] 4 ofpart partitions found on MTD device pxa3xx_nand-0
>>> [    3.257313] Creating 4 MTD partitions on "pxa3xx_nand-0":
>>> [    3.263051] 0x000000000000-0x0000000a0000 : "Bootloader"
>>> [    3.278845] 0x0000000a0000-0x0000000c0000 : "BootloaderEnvironment"
>>> [    3.296388] 0x0000000c0000-0x000000120000 : "BootloaderSplashScreen"
>>> [    3.314704] 0x000000120000-0x000008000000 : "UBI"
>>>
>>
>> Good news! Have you tried with Brian's patch [1]?
>
> Yes. l2-mtd 'next' branch + Brian's patch.
>
>> In that case, is this a Tested-by?
>>
>> [1] http://patchwork.ozlabs.org/patch/291408/
>
>   Tested-by: Daniel Mack <zonque@gmail.com>

Well, that last patch wouldn't be relevant to the PXA platform, but
I'll add your Tested-by to the whole series. Thanks!

Ezequiel, is that an "acked-by" for my last patch?

Brian
