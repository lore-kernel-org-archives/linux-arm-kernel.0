From: yamada.masahiro@socionext.com (Masahiro Yamada)
Date: Fri, 1 Apr 2016 11:55:09 +0900
Subject: [PATCH 2/2] ARM: delete "*Image is ready" log
In-Reply-To: <20160331165301.GM19428@n2100.arm.linux.org.uk>
References: <1459442582-23121-1-git-send-email-yamada.masahiro@socionext.com>
 <1459442582-23121-2-git-send-email-yamada.masahiro@socionext.com>
 <20160331165301.GM19428@n2100.arm.linux.org.uk>
Message-ID: <CAK7LNAS-ihNAv0Z2izM6uLqmGsK5yvE1zfXT9bkN3U7DB6v63g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Russell,

2016-04-01 1:53 GMT+09:00 Russell King - ARM Linux <linux@arm.linux.org.uk>:
> On Fri, Apr 01, 2016 at 01:43:02AM +0900, Masahiro Yamada wrote:
>> Commit 3939f3345050 ("ARM: 8418/1: add boot image dependencies to not
>> generate invalid images") fixed bad image generation in case of
>> parallel building, but as a side effect, Kbuild now descends into
>> arch/arm/boot/ again and again, duplicating the same log messages.
>> This is clumsy.
>>
>> In the example below (incremental build),
>>   "Kernel: arch/arm/boot/Image is ready" is displayed three times.
>>   "Kernel: arch/arm/boot/zImage is ready" is displayed twice.
>
> I disagree.  Image and zImage are the final targets that users are
> interested in, we should tell people that they've been successfully
> created.

Do you mean the Kbuild standard log style like follows is insufficient?

  OBJCOPY arch/arm/boot/Image
  OBJCOPY arch/arm/boot/zImage
  UIMAGE  arch/arm/boot/uImage


-- 
Best Regards
Masahiro Yamada
