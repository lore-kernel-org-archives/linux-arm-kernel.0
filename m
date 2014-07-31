From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Thu, 31 Jul 2014 20:44:31 +0200
Subject: [PATCH] arm64: dmi: Add SMBIOS/DMI support
In-Reply-To: <20140731161528.GH4179@bivouac.eciton.net>
References: <1406810830-6099-1-git-send-email-ard.biesheuvel@linaro.org>
 <CAKv+Gu9hwupNAxuOTNnsY8Spxkh3J6DwYF7Ym493PuZ-6phzXA@mail.gmail.com>
 <53DA509A.8070304@linaro.org>
 <CAKv+Gu8Nq7-mhFPRqRw6sxDxZAz5kyLvDBwC_0E3qZp9ZpxPig@mail.gmail.com>
 <53DA660D.3070504@linaro.org> <20140731155338.GC26853@arm.com>
 <20140731161528.GH4179@bivouac.eciton.net>
Message-ID: <CAKv+Gu-WrvqyE-TF3ybG1VN1f=rAATAo6oBUeTmzX8KD1auA9w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 31 July 2014 18:15, Leif Lindholm <leif.lindholm@linaro.org> wrote:
> On Thu, Jul 31, 2014 at 04:53:38PM +0100, Will Deacon wrote:
>> > >>      The patch works well on FVP model, and here are the boot log and
>> > >> dmidecode+lshw result:
>> > >>
>> > > Thanks Yi!
>> > >
>> > > Can we help Will out if he wants to test this himself?
>> >      @Will: which platform do you have on hand?  I am using FVP model
>> > for testing.
>> >      First, you need to merge SMBIOS support into UEFI.
>> >      Then, compile and install the dmidecode(open source) on the linux
>> > ,and run it.
>>
>> I've got some stuff from Leif for testing this, but what I'm really after is
>> something that would have spotted this problem. Are there any compliance
>> tests, for example?
>
> The patch as previously submitted (and accepted) was functional on all
> platforms it has been tested on. It is technically not compliant with
> the UEFI specification, but it works with the images we had.
> The worst-case failure would have been the lookup function returning
> NULL and the SMBIOS tables being unavailable even though they existed.
>

Indeed. It would be bad for us to rely on non-compliant but wide
spread behavior, so I think it is a good thing to shake out these bugs
now, even if they haven't caused any problems.

> What you are asking for would be a test for UEFI, not for the kernel.
> (And this one might be useful to add to the fwts if it's not already
> part of it.)
>

Yes, it would be good if we could test for patterns like this, (i.e.,
config tables with EFI_MEMORY_RUNTIME set).
