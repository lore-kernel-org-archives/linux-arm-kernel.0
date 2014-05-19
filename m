From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Mon, 19 May 2014 13:41:06 +0200
Subject: [PATCHv5 4/4] ARM: mvebu: use pci_ioremap_set_mem_type() to map
 PCI I/O as strongly ordered
In-Reply-To: <20140519095949.GD5113@arm.com>
References: <1400487234-4501-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1400487234-4501-5-git-send-email-thomas.petazzoni@free-electrons.com>
 <20140519095949.GD5113@arm.com>
Message-ID: <20140519134106.2c71260c@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Catalin Marinas,

On Mon, 19 May 2014 10:59:49 +0100, Catalin Marinas wrote:

> The patch is fine but for this to work in the UP case we need to fix
> MT_UNCACHED definition for sections. It seems to create SO memory but
> not necessarily writable (unless I miss something). Anyway, untested,
> something like this:

I justed tested in !CONFIG_SMP on Armada 38x, and writing to a PCI I/O
mapping works in both the MT_UNCACHED and MT_DEVICE cases.

Thomas
-- 
Thomas Petazzoni, CTO, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
