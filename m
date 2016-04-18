From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Mon, 18 Apr 2016 13:21:54 +0200
Subject: [PATCH v2 1/3] arm64: mm: make pr_cont() per line in Virtual
 kernel memory layout
In-Reply-To: <5714C1F1.6000504@arm.com>
References: <1460533772-13314-1-git-send-email-wangkefeng.wang@huawei.com>
 <1460948988-7477-1-git-send-email-wangkefeng.wang@huawei.com>
 <1460948988-7477-2-git-send-email-wangkefeng.wang@huawei.com>
 <5714C1F1.6000504@arm.com>
Message-ID: <CAKv+Gu-bOjOYRWVV7NfSfOJy9AtdKNmgrARdRHTT=HsGWVKoYA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 18 April 2016 at 13:16, James Morse <james.morse@arm.com> wrote:
> On 18/04/16 04:09, Kefeng Wang wrote:
>> Each line with single pr_cont() in Virtual kernel memory layout,
>> or the dump of the kernel memory layout in dmesg is not aligned
>> when PRINTK_TIME enabled, due to the missing time stamps.
>
> Looks good to me, but I can't reproduce the miss-aligned output on v4.6-rc4, I get:
>> [    0.000000] .text : 0xffffff8008080000 - 0xffffff8008887000   (  8220 KB)
>> [    0.000000] .rodata : 0xffffff8008887000 - 0xffffff8008bdc000 (  3412 KB)
>> [    0.000000] .init : 0xffffff8008bdc000 - 0xffffff8008cc3000   (   924 KB)
>> [    0.000000] .data : 0xffffff8008cc3000 - 0xffffff8008dd7200   (  1105 KB)
>
> without this patch, but it evidently happens for you. Do you have any special
> build options or kernel version? I'd like to understand if there is some
> kconfig/earlycon option that affects this!
>

Interestingly, for me it only occurs when running dmesg, and not when
observing the output from the console directly.
