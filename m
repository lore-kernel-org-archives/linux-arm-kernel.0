From: pbrobinson@gmail.com (Peter Robinson)
Date: Wed, 5 Aug 2015 11:13:07 +0100
Subject: arm kernel oops in highmem.c with 4.2
In-Reply-To: <20150805100701.GV7557@n2100.arm.linux.org.uk>
References: <CALeDE9Ox3=sh3AXQ0NUG6BBfU5i5YrMY=LDpcTHQWqz2=60F2g@mail.gmail.com>
 <20150805100701.GV7557@n2100.arm.linux.org.uk>
Message-ID: <CALeDE9PXF=gQCaBCiHpHy2nXOooQOmsCQvSgOv+wQw3mta=P6A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 5, 2015 at 11:07 AM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> On Wed, Aug 05, 2015 at 11:01:01AM +0100, Peter Robinson wrote:
>> Hi All,
>>
>> On Fedora 23 with recent 4.2 kernels we're seeing a crash (below) in
>> highmem.c on a fairly regular occurrence across a number of different
>> SoCs, I've seen it with at least AllWinner A20, i.MX6Q, Tegra2 and 124
>> with both a LPAE and non LPAE kernel, seen it happen when doing a
>> number of different things but regenerating a initrd, applying updates
>> (dnf/yum) and starting X are all pretty good triggers.
>
> I've yet to see any problems with mainline 4.2-rc5 kernels on any of my
> iMX6 platforms, which includes initramfs regeneration, apt-get updates
> and X.
>
>> [71751.658105] ------------[ cut here ]------------
>> [71751.658153] kernel BUG at arch/arm/mm/highmem.c:114!
>
> Well, in mainline kernels, the BUG is on line 113, not line 114.  So at
> least this file is modified from mainline kernels.  Maybe the problem is
> caused by patches applied to Fedora kernels?

We apply a crash driver patch [1] which has been there forever (long
enough that I'd forgotten it) but other than that for arm kernels we
currently don't apply any arm specific patches in 4.2.

Peter

[1] http://pkgs.fedoraproject.org/cgit/kernel.git/tree/crash-driver.patch
