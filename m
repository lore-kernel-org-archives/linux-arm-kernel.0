From: keescook@chromium.org (Kees Cook)
Date: Mon, 22 Feb 2016 11:04:56 -0800
Subject: [PATCH 3/3] arm64: ptdump: include UEFI runtime service mappings
In-Reply-To: <CAKv+Gu8RCrZJ4F8CA+FWTBe+WaF11BTJiM0cRiHJH_b0snk-yA@mail.gmail.com>
References: <1456135239-3607-1-git-send-email-ard.biesheuvel@linaro.org>
 <1456135239-3607-4-git-send-email-ard.biesheuvel@linaro.org>
 <20160222112901.GA3435@leverpostej>
 <CAKv+Gu8RCrZJ4F8CA+FWTBe+WaF11BTJiM0cRiHJH_b0snk-yA@mail.gmail.com>
Message-ID: <CAGXu5j+dyTxMn3ytZLaNeZsKWz2oeuYHysdS4hNBM7ewKX3gdA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Feb 22, 2016 at 3:51 AM, Ard Biesheuvel
<ard.biesheuvel@linaro.org> wrote:
> On 22 February 2016 at 12:29, Mark Rutland <mark.rutland@arm.com> wrote:
>> Hi,
>>
>> On Mon, Feb 22, 2016 at 11:00:39AM +0100, Ard Biesheuvel wrote:
>>> This adds the UEFI runtime services page table mappings to the output
>>> of the kernel page table dumper. These tables are only live during the
>>> time UEFI runtime services are being invoked, but we can include them
>>> for informational purposes nonetheless.
>>
>> I would prefer that we had a separate file for the EFI runtime services
>> page tables. As you mention, they are distinct from the kernel and not
>> always live (which is also the case for the idmap, for example).
>>
>> I have some local patches atop of v4.3 that librify the dumping code and
>> add a separate file for EFI [1]. I spotted a couple other things in
>> doing that (e.g. that we need to pad addresses more).
>>
>> Is it worth cleaning that up?
>>
>
> I think so. It would be especially nice if we could share the
> registration API between ARM and arm64, since the ptdump code is very
> similar, and the UEFI range is identical between them

In a perfect world, we could unify the ptdump code between x86, arm,
and arm64. Doing this is on my TODO list, but way down the list. :P

-Kees

-- 
Kees Cook
Chrome OS & Brillo Security
