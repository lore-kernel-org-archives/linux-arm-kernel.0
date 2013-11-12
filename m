From: lauraa@codeaurora.org (Laura Abbott)
Date: Tue, 12 Nov 2013 14:27:28 -0800
Subject: [RFC PATCHv2 0/4] Intermix Lowmem and Vmalloc
Message-ID: <1384295252-31778-1-git-send-email-lauraa@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

This is v2 of a patch series to allow lowmem and vmalloc to be
intermixed (http://lists.infradead.org/pipermail/linux-arm-kernel/2013-November/210578.html
provides the full decriptions which I've omitted here for brevity)

Nots I forgot to mention before:
- as a side effect of how CMA is setup, the remapped lowmem regions are
explicitly printed out in /proc/vmallocinfo which has turned out to be useful
for debugging. I couldn't find a good way to support those and the lowmem
regions in vmalloc short of adding partial region unmapping.
- I still have a nagging concern about regions that straddle the lowmem/highmem
boundary causing problems. I haven't been able to find a concrete issue yet
though..

v2: Fixed several comments by Kyungmin Park which led me to discover
several issues with the is_vmalloc_addr implementation. is_vmalloc_addr
is probably the ugliest part of the entire series and I debated if
adding extra vmalloc flags would make it less ugly.

Again, comments or suggestions on how to better accomplish this are welcome.

Thanks,
Laura
