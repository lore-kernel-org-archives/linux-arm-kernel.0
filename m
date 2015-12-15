From: graeme.gregory@linaro.org (G Gregory)
Date: Tue, 15 Dec 2015 16:28:24 +0000
Subject: [Linaro-acpi] Touching the initrd before paging_init
In-Reply-To: <CAGCh1+=eyBstwL7aPTvmRDDEn0GDrf9gTkCKLDBwoNT916vUpg@mail.gmail.com>
References: <566D3090.9090509@redhat.com>
 <20151213165942.GN25034@bivouac.eciton.net>
 <23071B8C-D1F9-47A6-9DB4-B26842150B76@redhat.com>
 <566DEB04.2030806@redhat.com>
 <CAGCh1+nb-H-B28crGuTPUKXZrBN_XDn7fNHf4q8LZZOgyhtDmQ@mail.gmail.com>
 <566DEED6.3010704@redhat.com>
 <CAGCh1+k8jHzMK+pLbtBgg5=VdT=+3W+OjTGJLMDGjLqLvmQXnw@mail.gmail.com>
 <5670339A.7060307@redhat.com>
 <CAGCh1+=eyBstwL7aPTvmRDDEn0GDrf9gTkCKLDBwoNT916vUpg@mail.gmail.com>
Message-ID: <CAGCh1+=+SkaunFL1JE-d8jTb6-Xi+sjUEYoF5ZgcwV7GTj7ECQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 15 December 2015 at 16:13, G Gregory <graeme.gregory@linaro.org> wrote:
> On 15 December 2015 at 15:36, Jon Masters <jcm@redhat.com> wrote:
>> On 12/15/2015 06:19 AM, G Gregory wrote:
>>
>> <below refers to the GRUB-based approach not the initrd override>
>>
>>> Tried it, results were not great :-(
>>>
>>> set root='hd0,gpt2'
>>> insmod acpi
>>> acpi /DSDT.aml
>>> linux /Image-leg earlycon=pl011,0xe1010000 console=ttyAMA0 acpi=force root
>>> =/dev/sda2
>>
>> <snip>
>>
>>> [    0.000000] PC is at setup_arch+0xfc/0x564
>>> [    0.000000] LR is at setup_arch+0xf8/0x564
>>
>> <snip>
>>
>> So we unmask SError in setup_arch, which happens now later enough that
>> it'll come out of the UART where you can see it. However there are still
>> occasions on some of these early platforms where an unhandled SError can
>> exist as GRUB exits. I have seen that a number of times on Seattle if
>> there's a pending error from one of the IO IP blocks on the SoC You
>> might need a firmware update, but can you also confirm that this
>> happened reproducibly?
>>
> It is Seattle RevB I am using and it is repeatable. I have pre-release
> firmware on there!
>
Repeatable on ROD0084E as well.

Graeme
