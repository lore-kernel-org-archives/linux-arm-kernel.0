From: r.sricharan@ti.com (R, Sricharan)
Date: Wed, 12 Sep 2012 18:59:49 +0530
Subject: [RFC PATCH] ARM: mm: ADD descriptor string to
 CONFIG_DMA_ADDR_64BIT_T
In-Reply-To: <CAMQu2gxi7xs4qp+Mkv0PvjZM7PvoWAuoe5YSBMfnE0Y+UFjrUQ@mail.gmail.com>
References: <1347429006-10879-1-git-send-email-r.sricharan@ti.com>
 <5050841A.7030203@ti.com>
 <CAMQu2gzpiZ8Qa8eGprCscmhFa1zW4Bb4ZEVR=e56tXBSE1pGWQ@mail.gmail.com>
 <20120912131918.GD21823@arm.com>
 <CAMQu2gxi7xs4qp+Mkv0PvjZM7PvoWAuoe5YSBMfnE0Y+UFjrUQ@mail.gmail.com>
Message-ID: <CAJ7qFSe4NgfT0fRBZfAFezCjex_GPv4Ogg4y7agZjXhCL3Fudg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,
On Wed, Sep 12, 2012 at 6:55 PM, Shilimkar, Santosh
<santosh.shilimkar@ti.com> wrote:
> On Wed, Sep 12, 2012 at 6:49 PM, Catalin Marinas
> <catalin.marinas@arm.com> wrote:
>> On Wed, Sep 12, 2012 at 01:57:26PM +0100, Shilimkar, Santosh wrote:
>>> On Wed, Sep 12, 2012 at 6:16 PM, Cyril Chemparathy <cyril@ti.com> wrote:
>>> >
>>> > On 9/12/2012 1:50 AM, R Sricharan wrote:
>>> >>
>>> >> Even if CONFIG_DMA_ADDR_64BIT_T is enabled by the defconfig,
>>> >> the feature is not getting selected.
>>> >> Adding a string description in the Kconfig resolves this.
>>> >>
>>> >> But not sure if this is the right way to fix this.
>>> >>
>>> >
>>> > Shouldn't you be selecting this in your 64-bit dma address capable arch
>>> > instead?
>>> >
>>> Yes. The selection to enable  CONFIG_DMA_ADDR_64BIT_T happens
>>> in the arch which needs it. Since this option was made as simple bool,
>>> looks like because of some KCONFIG magic, it was not getting selected.
>>> Adding some help text does fix the issue and thats is the patch all about.
>>
>> Are you sure you select this explicitly in Kconfig? It should not depend
>> on a description.
>>
> You are right.
>
>> What I understood from the initial email was that this option was only
>> added to the defconfig but ignored by the kernel as it's not a user
>> selectable option (unless you add some text).
>>
> That's right. Explicit KCONFIG select should work.
 yes. It works when enabled in arch/KCONFIG.
 Thanks. This patch is not needed then.

Thanks,
 Sricharan
