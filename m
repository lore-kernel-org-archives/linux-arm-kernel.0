From: robherring2@gmail.com (Rob Herring)
Date: Wed, 5 Feb 2014 09:05:13 -0600
Subject: [PATCH] arm64: fix early_io_map for 64K pages
In-Reply-To: <20140205145250.GC28140@mudshark.cambridge.arm.com>
References: <1391611829-7824-1-git-send-email-robherring2@gmail.com>
 <20140205145250.GC28140@mudshark.cambridge.arm.com>
Message-ID: <CAL_JsqJ6vqi_8O9XsXxQNWTtJ5vs7vSdErDy7wzwjej-HnQV3A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 5, 2014 at 8:52 AM, Will Deacon <will.deacon@arm.com> wrote:
> Hi Rob,
>
> On Wed, Feb 05, 2014 at 02:50:29PM +0000, Rob Herring wrote:
>> From: Rob Herring <robh@kernel.org>
>>
>> earlyprintk is broken with 64KB pages. The problem is pgprot_default
>> is not yet initialized when early_io_map is called, so the pte does not
>> get marked as valid. Set the necessary page and access permission bits.
>>
>> Cc: Mark Salter <msalter@redhat.com>
>> Cc: Catalin Marinas <catalin.marinas@arm.com>
>> Cc: Will Deacon <will.deacon@arm.com>
>> Signed-off-by: Rob Herring <robh@kernel.org>
>> ---
>
> I thought we fixed this in 4ce00dfcf19c by reverting the use of
> pgprot_default?

Ah crap. I only checked the history on mmu.c and missed that fix. And
I was so happy I found a kernel issue with qemu.

Rob
