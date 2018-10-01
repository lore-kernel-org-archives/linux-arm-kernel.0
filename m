From: f.fainelli@gmail.com (Florian Fainelli)
Date: Mon,  1 Oct 2018 11:17:16 -0700
Subject: [PATCH 3/3] soc: bcm: brcmstb: Fix re-entry point with a
 THUMB2_KERNEL
In-Reply-To: <20180927192711.26455-4-f.fainelli@gmail.com>
References: <20180927192711.26455-1-f.fainelli@gmail.com>
 <20180927192711.26455-4-f.fainelli@gmail.com>
Message-ID: <20181001181716.31870-1-f.fainelli@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 27 Sep 2018 12:27:11 -0700, Florian Fainelli <f.fainelli@gmail.com> wrote:
> When the kernel is built with CONFIG_THUMB2_KERNEL we would set the
> kernel's resume entry point to be a function that is already built as
> Thumb-2 code while the boot agent doing the resume is in ARM mode, so
> this does not work. There is a header label defined: cpu_resume_arm
> which we can use to do the switching for us.
> 
> Fixes: 0b741b8234c8 ("soc: bcm: brcmstb: Add support for S2/S3/S5 suspend states (ARM)")
> Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
> ---

Applied to drivers/next, thanks!
--
Florian
