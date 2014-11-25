From: will.deacon@arm.com (Will Deacon)
Date: Tue, 25 Nov 2014 17:48:24 +0000
Subject: [PATCH v3 04/13] efi: split off remapping code from
 efi_config_init()
In-Reply-To: <20141125172419.GD3331@console-pimps.org>
References: <1416315432-8534-1-git-send-email-ard.biesheuvel@linaro.org>
 <1416315432-8534-5-git-send-email-ard.biesheuvel@linaro.org>
 <20141125172419.GD3331@console-pimps.org>
Message-ID: <20141125174824.GJ8541@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 25, 2014 at 05:24:19PM +0000, Matt Fleming wrote:
> On Tue, 18 Nov, at 01:57:03PM, Ard Biesheuvel wrote:
> > Split of the remapping code from efi_config_init() so that the caller
> > can perform its own remapping. This is necessary to correctly handle
> > virtually remapped UEFI memory regions under kexec, as efi.systab will
> > have been updated to a virtual address.
> > 
> > Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> > ---
> >  drivers/firmware/efi/efi.c | 49 +++++++++++++++++++++++++++++-----------------
> >  include/linux/efi.h        |  2 ++
> >  2 files changed, 33 insertions(+), 18 deletions(-)
> 
> Looks straight forward.
> 
> What tree are these going through?

I think a bunch of the series is still under review, so we can probably
decide on that nearer 3.20 based on any dependencies that crop up.

Will
