From: grant.likely@linaro.org (Grant Likely)
Date: Thu, 05 Dec 2013 19:27:19 +0000
Subject: [PATCH V5 2/6] Add shared update_fdt() function for ARM/ARM64
In-Reply-To: <1385595115-21488-3-git-send-email-roy.franz@linaro.org>
References: <1385595115-21488-1-git-send-email-roy.franz@linaro.org> <
 1385595115-21488-3-git-send-email-roy.franz@linaro.org>
Message-ID: <20131205192719.71C6AC40785@trevor.secretlab.ca>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 27 Nov 2013 15:31:51 -0800, Roy Franz <roy.franz@linaro.org> wrote:
> Both ARM and ARM64 stubs will update the device tree
> that they pass to the kernel.  In both cases they
> primarily need to add the same UEFI related information,
> so the function can be shared.
> Create a new FDT related file for this to avoid use
> of architecture #ifdefs in efi-stub-helper.c
> Change EFI allocation type for memory map to
> EFI_RUNTIME_SERVICES_DATA, since we are passing
> this buffer to the kernel, or immediately freeing it.

Nit: You're using a very short line length for the commit block. 72
columns is more customary.

g.
