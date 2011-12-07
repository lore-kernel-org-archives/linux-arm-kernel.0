From: catalin.marinas@arm.com (Catalin Marinas)
Date: Wed, 7 Dec 2011 22:15:24 +0000
Subject: [GIT PULL] Linux support for ARM LPAE
In-Reply-To: <20111207202912.GE14542@n2100.arm.linux.org.uk>
References: <20111202182054.GA3250@arm.com>
 <20111206124109.GT14542@n2100.arm.linux.org.uk>
 <20111206140729.GA31720@arm.com>
 <20111206233058.GZ14542@n2100.arm.linux.org.uk>
 <20111207112320.GB23720@arm.com> <20111207122544.GD23720@arm.com>
 <20111207202912.GE14542@n2100.arm.linux.org.uk>
Message-ID: <CAHkRjk7H+A4XKk+==hKPGdnUfaS4PePEf9-p-iO6eE=+xOmTWw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 7 December 2011 20:29, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> On Wed, Dec 07, 2011 at 12:25:44PM +0000, Catalin Marinas wrote:
>> ARM: pgtable: Fix compiler warning in ioremap.c introduced by nopud
>>
>> From: Catalin Marinas <catalin.marinas@arm.com>
>>
>> With the arch/arm code conversion to pgtable-nopud.h, the section and
>> supersection (un|re)map code triggers compiler warnings on UP systems.
>> This is caused by pmd_offset() being given a pgd_t argument rather than
>> a pud_t one. This patch makes the necessary conversion via pud_alloc()
>> and pmd_alloc().
>>
>> Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
>
> So, do I now take this email as you saying that _your_ LPAE tree is
> not ready for merging because you want to rework this patch, or what?

No, I'm not, it's you saying that your nopud patch does not have any
fix for the warnings, even though I had fixes posted for months. The
same fix that's in my LPAE series was sent to you to include with your
patch but instead you kept saying (even twice in the past week) that
those warning had no fix. From that, I understand that you really
don't consider my patch a proper fix for the compiler warnings.

> Because you've decided to go down the path of reworking this patch,
> I consider it dangerous for me to just pull from your tree again - I've
> no idea what I'd get, and I've no idea whether what's there is what you
> want me to merge.

I haven't changed anything in my LPAE branch, just posted an
alternative fix-up for the nopud patch. Please _state_ clearly whether
you consider my original (in the LPAE series) fixup valid or not. If
yes, I'm happy that I don't have to rework anything.

> What I want from you - by 5pm tomorrow so I can get this stuff merged -
> is a pull request for the LPAE stuff as it was in your v2 pull request,
> either based on top of _either_ my devel-stable (if you can get it - as
> the machine is having severe problems running git atm) or with Will's
> idmap changes merged into it _before_ the LPAE changes.
>
> I suspect you'll have to do the latter though, because I don't think I
> can sort out git on the server at the moment.

Yes, that's fine with me, I already talked to Will about this earlier
today but wanted to get your reply first.

-- 
Catalin
