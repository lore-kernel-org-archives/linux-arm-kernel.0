From: pawel.moll@arm.com (Pawel Moll)
Date: Wed, 05 Oct 2011 18:37:10 +0100
Subject: [PATCH 02/16] ARM: amba: Auto-generate AMBA driver module
	aliases during modpost
In-Reply-To: <1317830707-17517-3-git-send-email-dave.martin@linaro.org>
References: <1317830707-17517-1-git-send-email-dave.martin@linaro.org>
	<1317830707-17517-3-git-send-email-dave.martin@linaro.org>
Message-ID: <1317836230.3158.394.camel@hornet.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 2011-10-05 at 17:04 +0100, Dave Martin wrote:
> This patch adds the necessary support in file2alias.c to define
> suitable aliases based on the amba_id table in AMBA driver modules.
> 
> This should be sufficient to allow such modules to be auto-loaded
> via udev.  The AMBA bus driver's uevent hotplug code is also
> modified to pass an approriate MODALIAS string in the event.
> 
> For simplicity, the AMBA ID is treated an an opaque 32-bit numeber.
> Module alises use patterns as appropriate to describe the value-
> mask pairs described in the driver's amba_id list.
> 
> The proposed alias format is (extended regex):
> 
>         ^amba:d(HEX){8}$
> 
> Where HEX is a single upper-case HEX digit or a pattern (? or []
> expression) matching a single upper-case HEX digit, as expected by
> udev.
> 
> "d" is short for "device", following existing alias naming
> conventions for other device types.  This adds some flexibility for
> unambiguously extending the alias format in the future by adding
> additional leading and trailing fields, if this turns out to be
> necessary.
> 
> Signed-off-by: Dave Martin <dave.martin@linaro.org>

Acked-by: Pawel Moll <pawel.moll@arm.com>

Cheers!

Pawel
