From: javier@dowhile0.org (Javier Martinez Canillas)
Date: Wed, 14 Dec 2016 19:22:46 -0300
Subject: [PATCH] arm: dt: Initialize boot_command_line from CONFIG_CMDLINE
 in case DT does not provide /chosen/bootargs
In-Reply-To: <1481749963-8664-1-git-send-email-pali.rohar@gmail.com>
References: <1481749963-8664-1-git-send-email-pali.rohar@gmail.com>
Message-ID: <CABxcv=n=FOFedS9vF9qf68PAWy3YQoAMHJcgiG9TiaLrDOZXDw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Pali,

On Wed, Dec 14, 2016 at 6:12 PM, Pali Roh?r <pali.rohar@gmail.com> wrote:
> Commit 008a2ebcd677 ("ARM: dts: omap3: Remove skeleton.dtsi usage") broke
> support for setting cmdline on Nokia N900 via CONFIG_CMDLINE.
>

This commit really exposed the issue rather than causing it. But since
it was working before due including skeleton.dtsi which defines an
empty chosen node, I think that you should add a:

Fixes: 008a2ebcd677 ("ARM: dts: omap3: Remove skeleton.dtsi usage")

> It is because arm code booted in DT mode parse cmdline only via function
> early_init_dt_scan_chosen() and that function does not fill variable
> boot_command_line when DTB does not contain /chosen entry. It is called
> from function early_init_dt_scan_nodes() in setup_machine_fdt().
>
> This patch fixes it by explicitly filling boot_command_line in function
> setup_machine_fdt() after calling early_init_dt_scan_nodes() in case
> boot_command_line still remains empty.
>
> Signed-off-by: Pali Roh?r <pali.rohar@gmail.com>
> ---

Best regards,
Javier
