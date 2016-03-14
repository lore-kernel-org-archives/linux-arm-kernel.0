From: nsekhar@ti.com (Sekhar Nori)
Date: Mon, 14 Mar 2016 17:22:46 +0530
Subject: [PATCH 2/4] mmc: davinci: fix unwinding in probe
In-Reply-To: <1457567405-30475-3-git-send-email-david@lechnology.com>
References: <1457567405-30475-1-git-send-email-david@lechnology.com>
 <1457567405-30475-3-git-send-email-david@lechnology.com>
Message-ID: <56E6A60E.7040808@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi David,

On Thursday 10 March 2016 05:20 AM, David Lechner wrote:
> Unwiding from an error in davinci_mmcsd_probe was a mess. Some errors were
> not handled and not all paths unwound correctly.
> 
> Signed-off-by: David Lechner <david@lechnology.com>

Since you are touching this, can you also shift to using devm_*()
variants where possible (like devm_ioremap()). That will simplify the
error handling quite a bit.

Regards,
Sekhar
