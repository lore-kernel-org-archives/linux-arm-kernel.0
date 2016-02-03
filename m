From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 3 Feb 2016 00:05:06 +0000
Subject: [PATCH 3/3] kallsyms: remove --page-offset command line option
In-Reply-To: <1454419174-21290-4-git-send-email-ard.biesheuvel@linaro.org>
References: <1454419174-21290-1-git-send-email-ard.biesheuvel@linaro.org>
 <1454419174-21290-4-git-send-email-ard.biesheuvel@linaro.org>
Message-ID: <20160203000504.GY10826@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Feb 02, 2016 at 02:19:34PM +0100, Ard Biesheuvel wrote:
> The --page-offset command line option was only used for ARM, to filter
> symbol addresses below CONFIG_PAGE_OFFSET. This is no longer needed, so
> remove the functionality altogether.

>From what I remember, this option has nothing to do with MMU-ful ARM,
but noMMU ARM, where the .text segment can be significantly different
from the .data segment.

I think you need to talk to noMMU people about this patch.

-- 
RMK's Patch system: http://www.arm.linux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
