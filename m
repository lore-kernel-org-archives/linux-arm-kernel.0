From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Thu, 13 Nov 2014 11:17:30 +0100
Subject: [PATCHv3 2/5] ARM: mvebu: disable I/O coherency on non-SMP
 situations on Armada 370/375/38x/XP
In-Reply-To: <5650402.1KVMxKcjQn@wuerfel>
References: <1415871540-20302-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1415871540-20302-3-git-send-email-thomas.petazzoni@free-electrons.com>
 <5650402.1KVMxKcjQn@wuerfel>
Message-ID: <20141113111730.705f9ca1@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Arnd Bergmann,

On Thu, 13 Nov 2014 11:10:07 +0100, Arnd Bergmann wrote:

> Seems fine to me. I was hoping to solve this with the introduction
> of the CONFIG_ARCH_MULTIPLATFORM_STRICT or CONFIG_BROKEN_MULTIPLATFORM
> setting that would allow us to have a compile-time setting to make it
> work on UP (while possibly breaking or slowing down other machines
> in a multiplatform kernel), but Russell didn't like the idea.

Right. Unfortunately, I don't currently see a good way of handling such
a case, other than having the C code at some point in the
initialization re-create all the page tables that were set up by the
assembly code. The basic problem here is that I need access to an
information located in the Device Tree at a moment where the DT isn't
available. So there are two options: 1/ make the DT available earlier,
but it really seems impractical to manipulate the DT in the
early assembly code, or 2/ make sure that the initialization done in
the assembly code can be overridden later.

What do you think?

Best regards,

Thomas
-- 
Thomas Petazzoni, CTO, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
