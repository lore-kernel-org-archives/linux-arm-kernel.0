From: will.deacon@arm.com (Will Deacon)
Date: Mon, 20 Jun 2016 09:28:36 +0100
Subject: [PATCH 1/2] arm64: consolidate context ID for 8-bit ASIDs
In-Reply-To: <20160617173300.4767-1-jean-philippe.brucker@arm.com>
References: <20160617173300.4767-1-jean-philippe.brucker@arm.com>
Message-ID: <20160620082835.GD29165@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jun 17, 2016 at 06:32:59PM +0100, Jean-Philippe Brucker wrote:
> When a CPU uses 8 bits of ASID, software should write the top 8 bits of
> TTB registers and TLBI commands as 0. Currently, we put the generation
> field right above the ASIDs, which leads to writing it into TTB and TLBIs.
> Hardware is supposed to always ignore those bits, but we shouldn't rely on
> that.

Actually, I think we can rely on this. The ARM ARM has a special exception
for ASID size (there are some pending changes to this text that appear to
be inconsequential to this discussion):

  ASID size

  [...]

  When the value of TCR_EL1.AS is 0, ASID[15:8] ... Are ignored by hardware
  for every purpose other than reads of ID_AA64MMFR0_EL1.

Will
