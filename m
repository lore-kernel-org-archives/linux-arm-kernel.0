From: catalin.marinas@arm.com (Catalin Marinas)
Date: Thu, 28 Apr 2016 10:26:41 +0100
Subject: [PATCH v9 13/14] arm64: kernel: Add support for
 hibernate/suspend-to-disk
In-Reply-To: <1461775633-29715-14-git-send-email-james.morse@arm.com>
References: <1461775633-29715-1-git-send-email-james.morse@arm.com>
 <1461775633-29715-14-git-send-email-james.morse@arm.com>
Message-ID: <20160428092640.GA3134@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Apr 27, 2016 at 05:47:12PM +0100, James Morse wrote:
> Add support for hibernate/suspend-to-disk.
> 
> Suspend borrows code from cpu_suspend() to write cpu state onto the stack,
> before calling swsusp_save() to save the memory image.
> 
> Restore creates a set of temporary page tables, covering only the
> linear map, copies the restore code to a 'safe' page, then uses the copy to
> restore the memory image. The copied code executes in the lower half of the
> address space, and once complete, restores the original kernel's page
> tables. It then calls into cpu_resume(), and follows the normal
> cpu_suspend() path back into the suspend code.
> 
> To restore a kernel using KASLR, the address of the page tables, and
> cpu_resume() are stored in the hibernate arch-header and the el2
> vectors are pivotted via the 'safe' page in low memory.
> 
> Signed-off-by: James Morse <james.morse@arm.com>
> Tested-by: Kevin Hilman <khilman@baylibre.com> # Tested on Juno R2
> Cc: Catalin Marinas <catalin.marinas@arm.com>

It looks fine. Thanks.

Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
