From: lorenzo.pieralisi@arm.com (Lorenzo Pieralisi)
Date: Fri, 4 Mar 2016 17:37:50 +0000
Subject: [PATCH V5 00/15] MMCONFIG refactoring and support for ARM64 PCI
 hostbridge init based on ACPI
In-Reply-To: <56D9A121.9080508@codeaurora.org>
References: <1455630825-27253-1-git-send-email-tn@semihalf.com>
 <56D49611.2050202@codeaurora.org> <20160303112332.GC28359@red-moon>
 <56D84938.6020102@codeaurora.org> <20160304105517.GA30693@red-moon>
 <56D97901.7080001@semihalf.com> <56D9A121.9080508@codeaurora.org>
Message-ID: <20160304173750.GA15070@red-moon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Mar 04, 2016 at 09:52:17AM -0500, Sinan Kaya wrote:

[...]

> >> I could integrate the code implementing pci=realloc in patch 11 so
> >> that we realloc by default all resources claimed that failed (which
> >> means that bridges are resized accordingly and you won't be forced
> >> to use pci=realloc on command line).
> >>
> > 
> > I agree with Lorenzo. Just because v3 works it does not mean we want to go this way. Also, I think we should realloc all resources claimed that failed, w/o need to use pci=realloc on command line.
> > 
> 
> Let's give this a try. I have seen the kernel messages with and
> without realloc option too. I don't want to see any kind of error
> messages if it is actually working.

I agree, claiming resources failures are too noisy, it is a pet-peeve
of mine too. The code to realloc resources is in the kernel already,
it is just a matter of defining how to use it (ie trigger it by default
without command line option - actually the kernel can be already
compiled to enable realloc by default, see CONFIG_PCI_REALLOC_ENABLE_AUTO),
that's why I added Yinghai to the thread, Bjorn and him have more
insights on how this has been used on current systems and I am really keen
on getting their opinion, they have more visibility into this than I do,
writing the patch itself should be simple enough.

Thanks !
Lorenzo
