From: olof@lixom.net (Olof Johansson)
Date: Mon, 2 Apr 2012 21:55:20 -0700
Subject: [PATCH] ARM: fix lcd power build failure in collie_defconfig
In-Reply-To: <1333405037-3053-1-git-send-email-paul.gortmaker@windriver.com>
References: <1333405037-3053-1-git-send-email-paul.gortmaker@windriver.com>
Message-ID: <20120403045520.GA21904@quad.lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Apr 02, 2012 at 06:17:17PM -0400, Paul Gortmaker wrote:
> Commit 086ada54abaa4316e8603f02410fe8ebc9ba2de1
> 
>   "FB: sa1100: remove global sa1100fb_.*_power function pointers"
> 
> got rid of all instances but one in locomolcd.c -- which was
> conditional on CONFIG_SA1100_COLLIE.  The associated .power
> field which replaces the global is populated in mach-sa1100/collie.c
> so move the assignment there, but make it conditional on the
> locomolcd support, so use CONFIG_BACKLIGHT_LOCOMO in that file.
> 
> Cc: arm at kernel.org
> Acked-by: Russell King <rmk+kernel@arm.linux.org.uk>
> Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>

Thanks, applied to fixes.


-Olof
