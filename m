From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sun, 24 Nov 2013 12:41:25 +0000
Subject: [PATCH] ARM: pxa: Move iotable mapping inside vmalloc region
In-Reply-To: <1385296571-23599-1-git-send-email-ezequiel.garcia@free-electrons.com>
References: <1385296571-23599-1-git-send-email-ezequiel.garcia@free-electrons.com>
Message-ID: <20131124124125.GM16735@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Nov 24, 2013 at 09:36:11AM -0300, Ezequiel Garcia wrote:
> In order to remove the following ugly message:
> 
>   BUG: mapping for 0x00000000 at 0xff000000 out of vmalloc space
> 
> the iotable mappings should be re-located inside the vmalloc
> region. Such move was introduced at commit:
> 
> commit 0536bdf33faff4d940ac094c77998cfac368cfff
> Author: Nicolas Pitre <nicolas.pitre@linaro.org>
> Date:   Thu Aug 25 00:35:59 2011 -0400
> 
>     ARM: move iotable mappings within the vmalloc region
> 
> While at it, let's add some nicer defines to make the code
> more readable.
> 
> Cc: Nicolas Pitre <nicolas.pitre@linaro.org>
> Signed-off-by: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>

NAK.  I'm guessing that you haven't properly tested this.  Grep for
UNCACHED_PHYS_0, and what you'll find is that your change will break
standby and suspend on all PXA platforms.
