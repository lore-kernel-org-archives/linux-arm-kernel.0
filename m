From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Wed, 18 May 2016 10:36:33 +0200
Subject: [PATCH v2 1/2] efi: esrt: use memremap not ioremap to access ESRT
 table in memory
In-Reply-To: <20160304062524.GA19010@dhcp-128-65.nay.redhat.com>
References: <20160218104407.GC2651@codeblueprint.co.uk>
 <CAKv+Gu_AW7PKJJOd2mbEu3LKJe+gNaPHnH=sgO=YXM_KWFyKxw@mail.gmail.com>
 <20160218132824.GE2651@codeblueprint.co.uk>
 <CAKv+Gu-s1pzYBzuDG-Z7s3gyo8dPOfeidZQ+rim-uAWZCBcKQQ@mail.gmail.com>
 <20160218134324.GG2651@codeblueprint.co.uk>
 <CAKv+Gu875r9RkDC723kNsG4XC0eSE9RPPmSFZrD0sx0QxS+V4g@mail.gmail.com>
 <20160218141544.GH2651@codeblueprint.co.uk>
 <20160218191624.GA1515@redhat.com>
 <20160226144114.GA7475@codeblueprint.co.uk>
 <20160301233040.GA31476@codeblueprint.co.uk>
 <20160304062524.GA19010@dhcp-128-65.nay.redhat.com>
Message-ID: <CAKv+Gu_ekP+44FJjR7BY_MFqx2jQgc6Tk9W4SBL__ttdvQ55VQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 4 March 2016 at 07:25, Dave Young <dyoung@redhat.com> wrote:
>> I have a very rough draft of patches that implement this strategy on
>> the 'experiemntal/efi-memmap' branch in the EFI tree if anyone is
>> curious and wants to take a look. The series will be sent out soon.
>>
>> I wouldn't necessarily try running them or anything as there's a few
>> things that I know are broken; ia64 build, EFI mixed mode boot,
>> probably arm64 regressions.
>
> Matt, I tried :). I see a build warning about print phys_addr_t without
> %pa anotation and booting with ioremap error messages about slot not found
> , and ioremap region leak messages.
>
> Looking forward to your formal posts.
>

So what is the status here? I know Sai is working on x86 support for
the memory attributes table, so it would make sense settle this matter
as well.
