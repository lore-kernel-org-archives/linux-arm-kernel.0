From: dja@axtens.net (Daniel Axtens)
Date: Mon, 07 Aug 2017 09:49:24 +1000
Subject: [PATCH 2/3] Split VGA default device handler out of VGA arbiter
In-Reply-To: <20170805065754.GA8509@wunner.de>
References: <20170804102033.27731-1-dja@axtens.net>
 <20170804102033.27731-3-dja@axtens.net> <20170805065754.GA8509@wunner.de>
Message-ID: <87zibcqmt7.fsf@linkitivity.dja.id.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Lukas,

Let me reply "back-to-front":

> Please cc dri-devel when proposing changes to vgaarb.c (see
> MAINTAINERS).

Sorry, will do in future.

> I'm missing some context as to the negative consequences you're
> experiencing on other arches (the cover letter merely refers to
> "quirks in ppc and concerns in arm land" and is missing links to
> archived versions of v1 and v2), but clearly legacy resources are
> x86-specific so any code dealing with them seems superfluous on
> other arches and should be marked as such.

Quirk/v1: https://www.spinics.net/lists/linux-pci/msg62865.html
Approach 2: https://www.spinics.net/lists/linux-pci/msg63092.html
            https://www.spinics.net/lists/linux-pci/msg63083.html

The quirk in powerpc land that I'm referring to is
arch/powerpc/kernel/pci-common.c::fixup_vga() which is a class enable
hook that marks the first VGA device it comes across as default if the
arbiter has not marked one.

The arm concerns are ventaliated in the threads I linked - they boil
down to "why do we need the arbiter at all on platforms without legacy
resources? Can't we do this more simply?"

> Would it be feasible to just sprinkle some "if (IS_ENABLED(CONFIG_X86))"
> over the portions of vgaarb.c that deal with legacy resources?

Yes and no. That would disable the unnecessary chunks of the VGA
arbiter, but we then still have to figure out how to mark devices as
default if not with the arbiter.

Regards,
Daniel

>
> Thanks,
>
> Lukas
