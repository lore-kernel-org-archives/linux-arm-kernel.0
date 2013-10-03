From: matt@console-pimps.org (Matt Fleming)
Date: Thu, 3 Oct 2013 22:07:15 +0100
Subject: [PATCH 2/6] Add shared update_fdt() function for ARM/ARM64
In-Reply-To: <CAFECyb-=2osh_j_9FCnWjAjLX-xbzanQeFjCLNTz4JKAk5d30w@mail.gmail.com>
References: <1380385403-31904-1-git-send-email-roy.franz@linaro.org>
 <1380385403-31904-3-git-send-email-roy.franz@linaro.org>
 <20131003095224.GX21381@console-pimps.org>
 <1380807804.17503.9.camel@deneb.redhat.com>
 <20131003142721.GB2781@console-pimps.org>
 <CAFECyb-=2osh_j_9FCnWjAjLX-xbzanQeFjCLNTz4JKAk5d30w@mail.gmail.com>
Message-ID: <20131003210715.GD2781@console-pimps.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 03 Oct, at 12:28:03PM, Roy Franz wrote:
> Hi Matt,
> 
>    This  function is shared between ARM and ARM64, which are separate
> architectures so to keep this in arch code would require it to be
> duplicated for ARM/ARM64.  Would moving this function to a new
> "efi-stub-fdt.c" file be satisfactory?  This file would just be used
> the ARM and ARM64, so this would remove
> the need for the top-level #ifdefs.

Fair enough, move it to drivers/firmware/efi/fdt.c - there's no need to
prefix it with "efi-" (efi-pstore.c has historic baggage).

-- 
Matt Fleming, Intel Open Source Technology Center
