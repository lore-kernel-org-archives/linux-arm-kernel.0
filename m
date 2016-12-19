From: matt@codeblueprint.co.uk (Matt Fleming)
Date: Mon, 19 Dec 2016 21:38:59 +0000
Subject: [PATCH v2] efi/libstub: arm*: Pass latest memory map to the kernel
In-Reply-To: <20161219142419.16780-1-james.morse@arm.com>
References: <20161219142419.16780-1-james.morse@arm.com>
Message-ID: <20161219213859.GA2225@codeblueprint.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 19 Dec, at 02:24:19PM, James Morse wrote:
> From: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> 
> As reported by James, the current libstub code involving the annotated
> memory map only works somewhat correctly by accident, due to the fact
> that a pool allocation happens to be reused immediately, retaining its
> former contents.
> 
> Instead of juggling memory maps, which makes the code more complex than
> it needs to be, simply put a placholder value into the FDT, and only
> write the actual value after ExitBootServices() has been called.
> 
> Reported-by: James Morse <james.morse@arm.com>
> Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> [Update mmap-size too, remove updated_fdt()s unused params and header entry]
> Signed-off-by: James Morse <james.morse@arm.com>
> ---
> Hi Ard,
> 
> This is a v2 of your patch that updates the mmap-size too. This solves the
> truncated memmap problem I saw with v1 on Seattle.
> 
> The original patch was CC-stable, so I think this should also have:
> Cc: <stable@vger.kernel.org>
> Fixes: ed9cc156c42f ("efi/libstub: Use efi_exit_boot_services() in FDT")
> 
> 
> Thanks,
> 
> James
> 
>  drivers/firmware/efi/libstub/efistub.h |  8 ----
>  drivers/firmware/efi/libstub/fdt.c     | 75 +++++++++++++++++++++-------------
>  2 files changed, 47 insertions(+), 36 deletions(-)

Thanks James. I've queued this one up in the 'urgent' queue and tagged
it for stable. I'll send it to tip before the end of the week.
