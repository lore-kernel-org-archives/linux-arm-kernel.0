From: jeremy.linton@arm.com (Jeremy Linton)
Date: Mon, 1 Feb 2016 09:47:00 -0600
Subject: [PATCH 0/3] UEFI stub pre-boot compat checks
In-Reply-To: <1454000549-9189-1-git-send-email-ard.biesheuvel@linaro.org>
References: <1454000549-9189-1-git-send-email-ard.biesheuvel@linaro.org>
Message-ID: <56AF7DF4.3050504@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/28/2016 11:02 AM, Ard Biesheuvel wrote:
> As discussed earlier today [1], and last year [2], it makes sense for the
> UEFI stub to perform some basic checks on the hardware for missing features
> that would prevent the kernel from booting to a state where it can even
> complain about this.
>
> So implements this for ARM, to check on LPAE builds whether the CPU supports
> it (patch #1), and for arm64, to check whether the build time granule is
> implemented by the CPU (patch #2). Patch #3 wires it up into the shared init
> code.

Ard,

This version looks good, and addresses all the reservations from the 16k 
page thread. Thanks!

Reviewed-by: Jeremy Linton <jeremy.linton@arm.com>
