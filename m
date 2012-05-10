From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 10 May 2012 09:53:26 +0100
Subject: [PATCH] ARM: decompressor: Fix mmu mapping for non-DRAM
 address space.
In-Reply-To: <4FAB6A27.3050509@ti.com>
References: <1336398149-26153-1-git-send-email-santosh.shilimkar@ti.com>
 <20120508124116.GE17798@arm.com>
 <CAMQu2gxXB4GyddjrcKWwJ=KXx=MoDs7DdwhbOY85qkVJ1Vv3wA@mail.gmail.com>
 <20120508215554.GA18980@n2100.arm.linux.org.uk>
 <CAMQu2gzmZ1Af4sAxoT9WS_akY1gBrqffKE84rnbM_EUK8V8NHQ@mail.gmail.com>
 <20120509122348.GA30632@n2100.arm.linux.org.uk>
 <CAMQu2gzdwXwzhhFLtLXTj5e0a9cFeq5ReUcMT-tGUxTPUcV_4Q@mail.gmail.com>
 <20120509154849.GA10375@n2100.arm.linux.org.uk> <4FAB6A27.3050509@ti.com>
Message-ID: <20120510085325.GA3655@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 10, 2012 at 12:41:35PM +0530, Santosh Shilimkar wrote:
> Are you planning to merge below patch as is or split
> the patch like 1) Refactoring 2) ARMv7 fix

I don't see any point in splitting this up, especially as the ARMv7
fix would involve merely changing two lines (the domain register value
and the value passed into __setup_mmu via r6.)
