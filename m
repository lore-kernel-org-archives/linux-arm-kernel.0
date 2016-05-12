From: sstabellini@kernel.org (Stefano Stabellini)
Date: Thu, 12 May 2016 11:58:04 +0100 (BST)
Subject: [PATCH] Xen: EFI: Parse DT parameters for Xen specific UEFI
In-Reply-To: <20160512100410.GA2728@codeblueprint.co.uk>
References: <1462523526-3172-1-git-send-email-zhaoshenglong@huawei.com>
 <20160511122730.GU2839@codeblueprint.co.uk> <57333533.2030206@linaro.org>
 <20160511232444.GY2839@codeblueprint.co.uk> <5733E8CF.3070004@huawei.com>
 <20160512100410.GA2728@codeblueprint.co.uk>
Message-ID: <alpine.DEB.2.10.1605121138500.2494@sstabellini-ThinkPad-X260>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 12 May 2016, Matt Fleming wrote:
> On Thu, 12 May, at 10:22:07AM, Shannon Zhao wrote:
> > 
> > As said above, I will rebase this patch on top of the EFI next branch.
> 
> OK thanks.
> 
> Note that it is not possible to escape merge conflicts, since there
> are changes in the xen tip tree that are not in the EFI next branch
> and vice versa.
> 
> For example these commits from xen/linux-next look relevant,
> 
>   8e147fcc3ffa ("FDT: Add a helper to get the subnode by given name")
>   37060935dc04 ("ARM64: XEN: Add a function to initialize Xen specific UEFI runtime services")
>   acb2c923a860 ("XEN: EFI: Move x86 specific codes to architecture directory")
>   055be2d42408 ("ARM: Xen: Document UEFI support on Xen ARM virtual platforms")
>   3915fea959b6 ("ARM: XEN: Move xen_early_init() before efi_init()")

>From a diffstat perspective, the changes introduced by these commits
affect drivers/of/fdt.c, arch/arm/xen, arch/x86/xen, drivers/xen and
little else. I don't think they should cause merge troubles.


> Linus, Stefano, tip-folks: I'm soliciting opinions on the correct way
> to handle this inter-tree dependency where we've got changes to EFI
> code in two separate trees and Shannon wants to write patches on top
> of both.
> 
> I'm guessing the best solution is to merge xen/linux-next and efi/next
> into a topic branch either in the EFI tree or Xen tree, but I want to
> be cautious of the branch history that will create.

I am OK with that. You and I will have to be careful with the pull
requests.


> (In hindsight all of these change should have probably gone via the
> EFI tree.)

That is still possible if deemed best. 
