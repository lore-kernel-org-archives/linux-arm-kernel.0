From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Wed, 6 Nov 2013 15:57:05 +0100
Subject: [BUG?] ARM: mvebu: is second PCIe unit of Armada XP mv78230 x1
 or x4?
In-Reply-To: <20131105104845.4fc9e216@skate>
References: <87ppqgyrmc.fsf@natisbad.org>
	<20131105104845.4fc9e216@skate>
Message-ID: <20131106155705.444c20b2@skate>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Arnaud,

On Tue, 5 Nov 2013 10:48:45 +0100, Thomas Petazzoni wrote:

> The only place where we (Gregory pointed me in the right direction)
> could find some relation between the SoC variants and the available PCIe
> interfaces is in the hardware manual of each SoC variant, where the
> SERDES lanes are described.
> 
> For MV78230, it says:
> 
> 	PCIe 0.0, 0.1, 0.2, 0.3, 1.0, 1.1 and 1.2

[...]

> What it says for 78230 it a bit weird, because I don't see why it
> mentions 1.1 and 1.2 since the second PCIe interface on 78230 is said
> to be x1. Maybe that's a mistake in the datasheet, I'll try to get a
> confirmation about this.

I've updated the MV78230 hardware datasheet that we had, and indeed the
latest version available has this correct: MV78230 has PCIe 0.0, 0.1,
0.2, 0.3 and 1.0, which means a x4/x1 PCIe interface and a x1 one. The
"1.1" and "1.2" indicated in an earlier version of the datasheet were a
mistake, apparently.

Bottom line: it means that the patch you submitted and that I Acked-by
a few minutes ago is correct.

Best regards,

Thomas
-- 
Thomas Petazzoni, CTO, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
