From: notasas@gmail.com (Grazvydas Ignotas)
Date: Sun, 10 Feb 2013 22:45:59 +0200
Subject: [PATCH 0/6] ARM: mm: HugeTLB + THP support.
In-Reply-To: <1360335683-7755-1-git-send-email-steve.capper@arm.com>
References: <1360335683-7755-1-git-send-email-steve.capper@arm.com>
Message-ID: <CANOLnONh3rtqLXZ7LrEW9ML-Dzpr0=xmkeqnTVVzt3iq2sNyhg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Feb 8, 2013 at 5:01 PM, Steve Capper <steve.capper@arm.com> wrote:
> Hello,
> The following patches bring both HugeTLB support and Transparent
> HugePage (THP) support to ARM.
>
> These are not intended for 3.9.

I've tested this on 3.2 with this series and dependencies (LPAE and
some others) backported because I currently only have full board
support on 3.2. This was done on OMAP3/CortexA8 pandora board running
PSX emulator that renders graphics to 16bpp 1024x512 framebuffer
(sometimes 2048x1024 in "enhanced" mode). Here are some average frames
per second counter readings without huge pages and with them:

(not showing games as they are irrelevant here)
no hugetlb / hugetlb
game1: ~52 / 57
game2: ~67 / 77
game3: 21 / 26
game4: 22 / 25

As it can be seen here huge pages are very useful for this kind of
load, so I'm really looking forward for this to get merged.

FWIW:
Tested-by: Grazvydas Ignotas <notasas@gmail.com>


-- 
Gra?vydas
