From: agraf@suse.de (Alexander Graf)
Date: Mon, 25 Jun 2018 13:12:29 +0200
Subject: [PATCH] efi/libstub/arm: add opt-in Kconfig option for the DTB
 loader
In-Reply-To: <20180625063405.24387-1-ard.biesheuvel@linaro.org>
References: <20180625063405.24387-1-ard.biesheuvel@linaro.org>
Message-ID: <4825d1cd-c490-0442-5d43-9991250d5c1f@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/25/2018 08:34 AM, Ard Biesheuvel wrote:
> There are various ways a platform can provide a device tree binary
> to the kernel, with different levels of sophistication:
> - ideally, the UEFI firmware, which is tightly coupled with the
>    platform, provides a device tree image directly as a UEFI
>    configuration table, and typically permits the contents to be
>    manipulated either via menu options or via UEFI environment
>    variables that specify a replacement image,
> - GRUB for ARM has a 'devicetree' directive which allows a device
>    tree image to be loaded from any location accessible to GRUB, and
>    supersede the one provided by the firmware,
> - the EFI stub implements a dtb= command line option that allows a
>    device tree image to be loaded from a file residing in the same
>    file system as the one the kernel image was loaded from.
>
> The dtb= command line option was never intended to be more than a
> development feature, to allow the other options to be implemented
> in parallel. So let's make it an opt-in feature that is disabled
> by default, but can be re-enabled at will.
>
> Note that we already disable the dtb= command line option when we
> detect that we are running with UEFI Secure Boot enabled.
>
> Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>

Sounds reasonable to me.

Reviewed-by: Alexander Graf <agraf@suse.de>


Alex
