From: gnomes@lxorguk.ukuu.org.uk (One Thousand Gnomes)
Date: Tue, 3 Dec 2013 16:53:18 +0000
Subject: [RFC part1 PATCH 4/7] ARM64 / ACPI: Introduce the skeleton of
 _PDC related for ARM64
In-Reply-To: <1386088611-2801-5-git-send-email-hanjun.guo@linaro.org>
References: <1386088611-2801-1-git-send-email-hanjun.guo@linaro.org>
 <1386088611-2801-5-git-send-email-hanjun.guo@linaro.org>
Message-ID: <20131203165318.2c04a8bf@alan.etchedpixels.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

O> +enum idle_boot_override { IDLE_NO_OVERRIDE = 0, IDLE_HALT, IDLE_NOMWAIT,
> +			IDLE_POLL, IDLE_FORCE_MWAIT };

This should probably move out of the arch directory to be a single enum
including both platforms values. That will make it rather easier to keep
sane and avoid ifdefs around which definitions are for which processor.
