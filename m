From: olof@lixom.net (Olof Johansson)
Date: Mon, 2 Apr 2012 21:58:25 -0700
Subject: [PATCH] ARM: versatile: fix build failure in pci.c
In-Reply-To: <1333410505-17257-1-git-send-email-paul.gortmaker@windriver.com>
References: <1333410505-17257-1-git-send-email-paul.gortmaker@windriver.com>
Message-ID: <20120403045825.GB21904@quad.lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Apr 02, 2012 at 07:48:25PM -0400, Paul Gortmaker wrote:
> commit 9f786d033d025ab7d2c4d1b959aa81d935eb9e19
> 
>     "arm/PCI: get rid of device resource fixups"
> 
> causes this failure on the versatile:
> 
> arch/arm/mach-versatile/pci.c: In function 'pci_versatile_setup_resources':
> arch/arm/mach-versatile/pci.c:221: error: 'sys' undeclared (first use in this function)
> 
> because the versatile wasn't passing in the full struct pci_sys_data
> but only the resource sub-field.  Change it to pass in the full
> struct so that sys will be in scope.
> 
> Reported-by: Bruce Ashfield <bruce.ashfield@windriver.com>
> Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>

Thanks, applied to fixes.


-Olof
