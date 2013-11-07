From: axel.lin@ingics.com (Axel Lin)
Date: Thu, 7 Nov 2013 10:47:24 +0800
Subject: kernel BUG at kernel/kallsyms.c:222!
In-Reply-To: <CACVXFVO=QA-R1+twCL9fc_3vASg6Ap-3ezi=tU1MV1pdPYrfWw@mail.gmail.com>
References: <1383789208.5970.1.camel@phoenix>
 <CACVXFVMn6RSXchQ8u47F35_J+YSnp1bwF1tr-8uCEYwvFsOfgQ@mail.gmail.com>
 <CAFRkauAEt-YhBt11opj_GVCLrxGsTSd2LowWGmukTSmGuJkd3A@mail.gmail.com>
 <CACVXFVO=QA-R1+twCL9fc_3vASg6Ap-3ezi=tU1MV1pdPYrfWw@mail.gmail.com>
Message-ID: <CAFRkauAdR3=ByE0_B3OsqOBjmbz2a02EXb+6g-vn=1TJ7AZc8Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2013/11/7 Ming Lei <tom.leiming@gmail.com>:
> On Thu, Nov 7, 2013 at 10:18 AM, Axel Lin <axel.lin@ingics.com> wrote:
>> 2013/11/7 Ming Lei <tom.leiming@gmail.com>:
>>> Could you share what is the value of CONFIG_PAGE_OFFSET
>>> on your noMMU platform?
>>
>> $ grep  CONFIG_PAGE_OFFSET .config
>> CONFIG_PAGE_OFFSET=0xC0000000
>
> It seems that the PAGE_OFFSET is _not_ the start of kernel memory
> in linear address space on your platform, I think it may not be a correct
> usage, even for uClinux.

hi Ming,
Seems CONFIG_PAGE_OFFSET is not configurabe in "make menuconfig".
And I found CONFIG_PAGE_OFFSET=0xC0000000 for all below configs...
$ make at91_dt_defconfig; grep  CONFIG_PAGE_OFFSET .config
$ make ep93xx_defconfig; grep  CONFIG_PAGE_OFFSET .config
$ make imx_v4_v5_defconfig; grep CONFIG_PAGE_OFFSET .config
$ make mxs_defconfig; grep CONFIG_PAGE_OFFSET .config
$ make omap2plus_defconfig; grep CONFIG_PAGE_OFFSET .config
$ make s3c6400_defconfig; grep CONFIG_PAGE_OFFSET .config
$ make at91x40_defconfig; grep CONFIG_PAGE_OFFSET .config
( at91x40_defconfig is also arm7tdmi )

Regards,
Axel
