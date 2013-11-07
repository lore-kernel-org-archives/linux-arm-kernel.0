From: tom.leiming@gmail.com (Ming Lei)
Date: Thu, 7 Nov 2013 10:36:04 +0800
Subject: kernel BUG at kernel/kallsyms.c:222!
In-Reply-To: <CAFRkauAEt-YhBt11opj_GVCLrxGsTSd2LowWGmukTSmGuJkd3A@mail.gmail.com>
References: <1383789208.5970.1.camel@phoenix>
 <CACVXFVMn6RSXchQ8u47F35_J+YSnp1bwF1tr-8uCEYwvFsOfgQ@mail.gmail.com>
 <CAFRkauAEt-YhBt11opj_GVCLrxGsTSd2LowWGmukTSmGuJkd3A@mail.gmail.com>
Message-ID: <CACVXFVO=QA-R1+twCL9fc_3vASg6Ap-3ezi=tU1MV1pdPYrfWw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 7, 2013 at 10:18 AM, Axel Lin <axel.lin@ingics.com> wrote:
> 2013/11/7 Ming Lei <tom.leiming@gmail.com>:
>> Could you share what is the value of CONFIG_PAGE_OFFSET
>> on your noMMU platform?
>
> $ grep  CONFIG_PAGE_OFFSET .config
> CONFIG_PAGE_OFFSET=0xC0000000

It seems that the PAGE_OFFSET is _not_ the start of kernel memory
in linear address space on your platform, I think it may not be a correct
usage, even for uClinux.


Thanks,
-- 
Ming Lei
