From: haojian.zhuang@gmail.com (Haojian Zhuang)
Date: Fri, 18 May 2012 10:15:28 +0800
Subject: [PATCH v2 0/9] support dt for mmp2
In-Reply-To: <4FB5907C.9080105@gmail.com>
References: <1336134626-12262-1-git-send-email-haojian.zhuang@gmail.com>
 <4FB5907C.9080105@gmail.com>
Message-ID: <CAN1soZwSs1LN8AVcrF4-EKbyxNngjrXwkKCEoJ5AqWPKRG+CXQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, May 18, 2012 at 7:57 AM, Rob Herring <robherring2@gmail.com> wrote:
> On 05/04/2012 07:30 AM, Haojian Zhuang wrote:
>> v2:
>> 1. remove MACH_MMP_LEGACY & MACH_MMP2_LEGACY
>> 2. use irq.c to replace irq-pxa168.c & irq-mmp2.c
>> 3. Avoid to use CONFIG_OF in entry-macro.S
>>
>
> I think you should combine all the DT board files in this series into 1
> DT board file. The only diff I can see between the files is auxdata and
> board strings. You don't have any platform_data for the auxdata, so I'm
> guessing you are using it for clkdev lookup. You can instead simply add
> addition clkdev lookup names for the DT device names. Any other reason
> for needing the old device name is pretty much wrong.
>
> Rob
>
I only tested limited devices. So platform data is not used really. While more
devices are added, platform data has to be used. So I reserve it first.

I need to add clkdev also into DT board files. It's in my TODO list.

Regards
Haojian
