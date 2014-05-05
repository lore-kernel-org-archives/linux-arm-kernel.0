From: ezequiel.garcia@free-electrons.com (Ezequiel Garcia)
Date: Mon, 5 May 2014 11:32:48 -0300
Subject: [PATCH 1/5] ARM: mvebu: fix thermal quirk SoC revision check
In-Reply-To: <1399299631-30825-2-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1399299631-30825-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1399299631-30825-2-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <20140505143248.GA12693@arch.cereza>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05 May 04:20 PM, Thomas Petazzoni wrote:
> In commit 54fe26a900bc528f3df1e4235cb6b9ca5c6d4dc2 ('ARM: mvebu: Add
> thermal quirk for the Armada 375 DB board'), a check on the Armada SoC
> revision was added to decide whether a quirk for the thermal device
> should be applied or not.
> 
> However, the quirk implementation has a bug: it assumes
> mvebu_get_soc_id() returns true on success, but it returns
> 0. Therefore, the condition:
> 
>   if (mvebu_get_soc_id(&dev, &rev) && rev > ARMADA_375_Z1_REV)
> 
> is always false (as long as mvebu-soc-id is properly initialized). As
> a consequence, the quirk is always applied, even on A0 steppings, for
> which the quirk should not be applied.
> 
> This was spotted by testing the thermal driver on Armada 375 A0, which
> Ezequiel could not do since he does not have access to the A0 revision
> of the SoC for the moment.
> 
> Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
> Fixes: 54fe26a900bc528f3df1e4235cb6b9ca5c6d4dc2 ('ARM: mvebu: Add thermal quirk for the Armada 375 DB board')

Acked-by: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
-- 
Ezequiel Garc?a, Free Electrons
Embedded Linux, Kernel and Android Engineering
http://free-electrons.com
