From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Fri, 21 Sep 2012 14:15:17 -0400 (EDT)
Subject: [PATCH v3 03/17] ARM: use late patch framework for phys-virt
 patching
In-Reply-To: <1347385155-11643-4-git-send-email-cyril@ti.com>
References: <1347385155-11643-1-git-send-email-cyril@ti.com>
 <1347385155-11643-4-git-send-email-cyril@ti.com>
Message-ID: <alpine.LFD.2.02.1209211411140.6667@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 11 Sep 2012, Cyril Chemparathy wrote:

> This patch replaces the original physical offset patching implementation
> with one that uses the newly added patching framework.
> 
> Signed-off-by: Cyril Chemparathy <cyril@ti.com>

Please also remove the MODULE_ARCH_VERMAGIC_P2V entirely from module.h 
in this patch.  This corresponds to the old patch table format which is 
no longer supported once this patch is applied.  The new mechanism is 
covered by MODULE_ARCH_VERMAGIC_RT_PATCH already.

Once that is done, you may add...

Reviewed-by: Nicolas Pitre <nico@linaro.org>


Nicolas
