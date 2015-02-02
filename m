From: computersforpeace@gmail.com (Brian Norris)
Date: Mon, 2 Feb 2015 00:00:13 -0800
Subject: [PATCH 0/4] mtd: nand: atmel: Rework DT representation of NFC/NAND
In-Reply-To: <1417732214-3292-1-git-send-email-boris.brezillon@free-electrons.com>
References: <1417732214-3292-1-git-send-email-boris.brezillon@free-electrons.com>
Message-ID: <20150202080013.GD3523@norris-Latitude-E6410>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Dec 04, 2014 at 11:30:10PM +0100, Boris Brezillon wrote:
> While working on the EBI driver [1] I noticed that the relationship between
> the NFC (NAND Flash Controller) and the NAND chip it is attached to would
> make things harder to represent when moving the NAND node under the EBI bus
> (another useless 'ranges' definition).
> 
> Actually this representation might be even more problematic if one wants
> decide to connect two NAND chips on his sama5 based board, because the NFC
> node is a child of the NAND chip node, and thus can only be attached to a
> single NAND chip.
> 
> To address this problem the current series moves the NFC node outside of
> the NAND chip device which then reference the NFC using the "atmel,nfc"
> property.
> 
> The series does not implement multi-chip support, but at least the new
> representation should make it possible.

I made some comments on the DT binding. I'm not as familiar withi the
hardware details here, so I may be off base. At any rate, the code looks
OK, so if we settle the binding issue OK, then I'd be happy with a
rebased version of this patch set.

Regards,
Brian
