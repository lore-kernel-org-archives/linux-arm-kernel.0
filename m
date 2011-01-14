From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 14 Jan 2011 09:11:54 +0000
Subject: [PATCH] ARM: use memblock memory regions for "System RAM" I/O
	resources
In-Reply-To: <1294877317-25832-1-git-send-email-dima@android.com>
References: <20110112235223.GM11039@n2100.arm.linux.org.uk>
	<1294877317-25832-1-git-send-email-dima@android.com>
Message-ID: <20110114091154.GL24149@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 12, 2011 at 04:08:37PM -0800, Dima Zavin wrote:
> Do not use memory bank info to request the "system ram" resources as
> they do not track holes created by memblock_remove inside
> machine's reserve callback. If the removed memory is passed as
> platform_device's ioresource, then drivers that call
> request_mem_region would fail due to a conflict with the incorrectly
> configured system ram resource.

Patch looks fine - please send it to the patch system, thanks.
