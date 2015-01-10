From: andi@lisas.de (Andreas Mohr)
Date: Sat, 10 Jan 2015 11:46:27 +0100
Subject: Linux 3.19-rc3
In-Reply-To: <CA+55aFy+7+-8CHpmOjRXh1txpABRK3PC+7yZ+fESVAmveOWDyw@mail.gmail.com>
Message-ID: <20150110104627.GA8281@rhlx01.hs-esslingen.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Linus Torvalds wrote:
> I dunno. I do know that you definitely don't want to haev a
> desktop/workstation with 64kB pages.

Yet that is what any VirtualAlloc() call on Windows does
(well, not exactly *page* granularity but *allocation* granularity there).
Prime example: do a naively specific/custom VirtualAlloc() request
for a simple string Hello World\0 allocation (11+1 bytes),
get one page (4kB, "Private Data") plus "overhead" (60kB, "Unusable").
--> allocation efficiency: 0.01831%(!).
And that does hurt plenty IME, especially on a 32bit address space's
very limited 2GB/3GB total per Win32 process.

http://blogs.microsoft.co.il/sasha/2014/07/22/tracking-unusable-virtual-memory-vmmap/
"Why is address space allocation granularity 64K?"
  http://blogs.msdn.com/b/oldnewthing/archive/2003/10/08/55239.aspx

One thing less left to wonder why 'doze is such a performance pig...

Andreas Mohr
