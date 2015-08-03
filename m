From: linus.walleij@linaro.org (Linus Walleij)
Date: Mon, 3 Aug 2015 09:08:39 +0200
Subject: [PATCH] ARM: ux500: fix ux500 secondary CPU boot regression
In-Reply-To: <20150731110353.GV7557@n2100.arm.linux.org.uk>
References: <1438331874-1682-1-git-send-email-linus.walleij@linaro.org>
 <20150731110353.GV7557@n2100.arm.linux.org.uk>
Message-ID: <CACRpkdbEMM17zHDoUwsPFC2c=8UU_oHa6S3=VkBw7_-Or=wGow@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 31, 2015 at 1:03 PM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> On Fri, Jul 31, 2015 at 10:37:54AM +0200, Linus Walleij wrote:
>> +     scu_desc.pfn = __phys_to_pfn(res.start);
>> +     scu_desc.length = resource_size(&res);
>> +     iotable_init(&scu_desc, 1);
>> +     /* As in devicemaps_init() */
>> +     local_flush_tlb_all();
>> +     flush_cache_all();
>
> I don't like stuff moving out of the well-defined methods where it should
> be done - it makes maintanence of the arch code harder to have platforms
> going off and doing their own stuff in random other methods.
>
> IOW, setting up mappings in this way should only be in the ->map_io method.

OK I have the better fix which is a bit more invasive (fixes device tree
and deletes the while pen hold/release and headsmp.S code chunk) but
then maybe we should just apply that instead.

Yours,
Linus Walleij
