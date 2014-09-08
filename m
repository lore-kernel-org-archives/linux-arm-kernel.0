From: grant.likely@secretlab.ca (Grant Likely)
Date: Mon, 8 Sep 2014 13:20:11 +0100
Subject: Unable to boot mainline on snow chromebook since 3.15
In-Reply-To: <20140908112112.GK26030@arm.com>
References: <20140905115704.GO13515@arm.com> <20140905122232.GP13515@arm.com>
 <CAD=FV=VfioJf9VYoSYL0QBk-bN93-Ecx3=0n9hb5Q4rcx43-_g@mail.gmail.com>
 <540C202E.2060009@collabora.co.uk> <540C7F5B.6070307@gmail.com>
 <540C83DE.10505@collabora.co.uk> <540C8577.2070907@gmail.com>
 <20140908112112.GK26030@arm.com>
Message-ID: <CACxGe6v40wMSW8LJRtyZ3C6PinRMcQM-Zog+XpTJ-QG3HHJknw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Sep 8, 2014 at 12:21 PM, Will Deacon <will.deacon@arm.com> wrote:
> On Sun, Sep 07, 2014 at 05:19:03PM +0100, Tomasz Figa wrote:
>> At least for next 3.17-rc I'd suggest fixing this up in respective clock
>> driver and dropping the hack only after Exynos DRM patches are merged
>> and confirmed working.
>
> Whilst I'm sympathetic to people working to enable DRM, I think this is
> the right solution to the problem. The transition from simplefb to DRM
> shouldn't break display for a bunch of kernel revisions whilst the code is
> in flux.

I would go further. The kernel behaviour has changed, and we have to
deal with platforms that assume the old behaviour. That means either
defaulting to leaving enabled regulators/clocks alone unless there is
a flag in the DT saying they can be power managed, or black listing
platforms that are known to depend on the regulator being on.

Updating the device tree must not be required to get the kernel to
boot, but it is valid to require a DT upgrade to get better
performance (battery life) out of the platform.

g.
