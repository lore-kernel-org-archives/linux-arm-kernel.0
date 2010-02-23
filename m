From: nico@fluxnic.net (Nicolas Pitre)
Date: Tue, 23 Feb 2010 17:15:18 -0500 (EST)
Subject: [PATCH] Support for Buffalo WXL (Terastation Duo)
In-Reply-To: <4B83DD5C.2080607@kolios.dk>
References: <4B83DD5C.2080607@kolios.dk>
Message-ID: <alpine.LFD.2.00.1002231704230.1946@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 23 Feb 2010, Sebastien Requiem wrote:

> Hi everyone,
> 
> 
> 
> I have created a patch to support a new Sub architecture.
> 
> 
> Description of patch:
> 
> * Modification of Kconfig to add the Option
> * 1 new file : buffalo-wxl-setup.c
> This file is inspired from the db-78xx0-setup.c already present.
> The following is done:
>  - Configure MPP Lines for the plateform (see my patch for MPP)
> This is taken from the stock kernel provided by buffalotech (the vendor)
>  - GigaBit Ethernet
>  - Sata
>  - Uart are initiallized in a different way than on the dev board as we have
> one core only.
>  - USB
> 
> 
> The kernel has been running for some days now on my plateform.
> 
> I would appreciate if you had time to review my patch and give me any 
> comments/feedback regarding my work.

All previous comments also apply to this patch.

Furthermore you used the config symbol MACH_BUFFALO_WXL while the 
machine record expects MACH_TERASTATION_WXL.  And in wxl_pci_init() you 
used machine_is_db78x00_bp() instead of machine_is_terastation_wxl() 
which is actively wrong.

I've fixed up those and pushed the result too.


Nicolas
