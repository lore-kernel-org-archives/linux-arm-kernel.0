From: swarren@wwwdotorg.org (Stephen Warren)
Date: Thu, 21 Nov 2013 09:48:58 -0700
Subject: [PATCH] ARM: kernel: Detect DTB overwrite and error out
In-Reply-To: <1385006644-16024-1-git-send-email-joelf@ti.com>
References: <1385006644-16024-1-git-send-email-joelf@ti.com>
Message-ID: <528E397A.2030100@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/20/2013 09:04 PM, Joel Fernandes wrote:
> Kernel can silenty fail for DT-boot after the decompression stage, if DTB is
> overwritten. Instead of simply failing, we detect the condition and print an
> error.
> 
> One may think that it is sufficient for the bootloader to place the DTB away
> from kernel, but this is not the right fix because: (1) We add more dependence
> to the bootloader's stupidity (2) the decompressed kernel end address is not
> known to the loader. Also, we shouldn't depend on bootloader for silently
> failing us, so we detect the condition and error out.

If this problem happens, is there any guarantee that the kernel will
still execute far enough to actually print this error message? Can the
decompressor detect this condition instead?
