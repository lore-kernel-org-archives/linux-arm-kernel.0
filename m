From: Dave.Martin@arm.com (Dave Martin)
Date: Thu, 10 Sep 2015 16:55:25 +0100
Subject: [RFC PATCH 01/10] arm64: feature registers: Documentation
In-Reply-To: <55CA16CA.8060609@arm.com>
References: <1437731037-25795-1-git-send-email-suzuki.poulose@arm.com>
 <1437731037-25795-2-git-send-email-suzuki.poulose@arm.com>
 <20150810160636.GB15394@e104818-lin.cambridge.arm.com>
 <55C8E12E.6030305@arm.com>
 <CAKv+Gu-9GTzjqyT=NeBKjcaL7q-uFMToqPpprkyD-faG0J3mkQ@mail.gmail.com>
 <20150811142301.GE23307@e104818-lin.cambridge.arm.com>
 <55CA16CA.8060609@arm.com>
Message-ID: <20150910155523.GH6281@e103592.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Aug 11, 2015 at 04:37:46PM +0100, Suzuki K. Poulose wrote:
> On 11/08/15 15:23, Catalin Marinas wrote:
> >On Mon, Aug 10, 2015 at 07:48:48PM +0200, Ard Biesheuvel wrote:
> >>>On 10/08/15 17:06, Catalin Marinas wrote:
> >>>>And to debunk some of the counter arguments:
> >>>>
> >>>>a) Running out of HWCAP bits - I really doubt this, we can always
> >>>>     introduce 64 more via a new elf_hwcapX
> >>
> >>Note that ELF_HWCAP is also wired into ifunc resolution of GNU
> >>indirect functions, which looks like a useful feature although it
> >>isn't used that widely yet.
> >
> >I forgot to mention, we also need an HWCAP_CPUID with these patches when
> >we expose the MRS interface. The ifunc resolver could use MRS when
> >available. But I would still keep adding HWCAP bits for new features,
> >even if we risk running out of the 64-bit we have now.
> >
> 
> Sure, I will add the HWCAP_CPUID in the next version of the series.

+1

Playing with this, I realise that I get a splat if my userspace code
tries to do an MRS for an ID register when this series is absent -- we
need an hwcap that we can check first.

Cheers
---Dave
