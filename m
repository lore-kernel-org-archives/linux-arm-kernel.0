From: jszhang@marvell.com (Jisheng Zhang)
Date: Thu, 21 Jul 2016 15:13:44 +0800
Subject: [RFC] arm64: mm: use pgprot_device for device in phys_mem_access_prot
Message-ID: <20160721151344.36e29858@xhacker>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all,

Normally, in arm64, kernel driver maps register space as device nGnRE. But
if we access the register space via. /dev/mem, then the mapping is
device nGnRnE, is there a mismatch here?

the fix is s/pgprot_noncached/pgprot_device in phys_mem_access_prot().

>From armv8 ARM, this mismatch seems not the so called mismatched memory
attributes?

Thanks,
Jisheng
