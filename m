From: afaerber@suse.de (=?ISO-8859-15?Q?Andreas_F=E4rber?=)
Date: Mon, 30 Jun 2014 00:56:54 +0200
Subject: [PATCH 2/2] arm: Add back maximum bank limit
In-Reply-To: <1404068784-27604-2-git-send-email-lauraa@codeaurora.org>
References: <1404068784-27604-1-git-send-email-lauraa@codeaurora.org>
 <1404068784-27604-2-git-send-email-lauraa@codeaurora.org>
Message-ID: <53B099B6.1070706@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Laura,

Am 29.06.2014 21:06, schrieb Laura Abbott:
> Commit 1c2f87c22566cd057bc8cde10c37ae9da1a1bb76
> (ARM: 8025/1: Get rid of meminfo) dropped the upper bound on
> the number of memory banks that can be added as there was no
> technical need in the kernel. It turns out though, some bootloaders
> (specifically the arndale-octa exynos boards) may pass invalid memory
> information and rely on the kernel to not parse this data. This is a
> bug in the bootloader but we still need to work around this.
> Re-introduce a maximum bank limit per board to prevent invalid banks
> from being passed to the kernel.
> 
> Reported-by: Tushar Behera <trblinux@gmail.com>
> Signed-off-by: Laura Abbott <lauraa@codeaurora.org>
> ---
> http://lists.infradead.org/pipermail/linux-arm-kernel/2014-June/265615.html

Tested-by: Andreas F?rber <afaerber@suse.de>

[    0.000000] Max banks too low, ignoring memory at 0xfbffffaf
[    0.000000] Max banks too low, ignoring memory at 0xfffedbff
[    0.000000] Max banks too low, ignoring memory at 0xffbbffd9
[    0.000000] Max banks too low, ignoring memory at 0xffefefef

Thanks,
Andreas

-- 
SUSE LINUX Products GmbH, Maxfeldstr. 5, 90409 N?rnberg, Germany
GF: Jeff Hawn, Jennifer Guild, Felix Imend?rffer; HRB 16746 AG N?rnberg
