From: ben.dooks@codethink.co.uk (Ben Dooks)
Date: Tue, 15 May 2012 16:59:08 +0100
Subject: [PATCH 6/8] arm: mach-armada: add support for Armada XP board
 with device tree
In-Reply-To: <20120515154145.GE13860@n2100.arm.linux.org.uk>
References: <1337072084-21967-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1337072084-21967-7-git-send-email-thomas.petazzoni@free-electrons.com>
 <4FB228AD.5000507@codethink.co.uk> <4FB25A9A.3070306@gmail.com>
 <4FB25FE9.3060209@codethink.co.uk> <20120515161655.504f1403@skate>
 <4FB26904.1060308@codethink.co.uk> <20120515165813.66b4434e@skate>
 <4FB2714F.5080703@codethink.co.uk>
 <20120515154145.GE13860@n2100.arm.linux.org.uk>
Message-ID: <4FB27D4C.6080204@codethink.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 15/05/12 16:41, Russell King - ARM Linux wrote:
> On Tue, May 15, 2012 at 04:07:59PM +0100, Ben Dooks wrote:
>> I think it was because that PCI was initialised early and requires a
>> large mapping space. It is very likely to be legacy kernel stuff that
>> people have kept copying through.
>
> No.  PCI needs nothing other than access to the configuration space, and
> the PCI IO window.  There has _never_ been any hard requirement to map
> PCI memory in map_io() because that is _always_ done by drivers calling
> ioremap().

What about inb, outb and their related functions?

-- 
Ben Dooks				http://www.codethink.co.uk/
Senior Engineer				Codethink - Providing Genius
