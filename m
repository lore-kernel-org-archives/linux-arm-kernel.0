From: tony@atomide.com (Tony Lindgren)
Date: Wed, 14 Dec 2016 13:46:22 -0800
Subject: [PATCH] arm: dt: Initialize boot_command_line from
 CONFIG_CMDLINE in case DT does not provide /chosen/bootargs
In-Reply-To: <20161214212556.GC28424@amd>
References: <1481749963-8664-1-git-send-email-pali.rohar@gmail.com>
 <20161214212556.GC28424@amd>
Message-ID: <20161214214622.GC4920@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Pavel Machek <pavel@ucw.cz> [161214 13:26]:
> On Wed 2016-12-14 22:12:43, Pali Roh?r wrote:
> > Commit 008a2ebcd677 ("ARM: dts: omap3: Remove skeleton.dtsi usage") broke
> > support for setting cmdline on Nokia N900 via CONFIG_CMDLINE.
> > 
> > It is because arm code booted in DT mode parse cmdline only via function
> > early_init_dt_scan_chosen() and that function does not fill variable
> > boot_command_line when DTB does not contain /chosen entry. It is called
> > from function early_init_dt_scan_nodes() in setup_machine_fdt().
> > 
> > This patch fixes it by explicitly filling boot_command_line in function
> > setup_machine_fdt() after calling early_init_dt_scan_nodes() in case
> > boot_command_line still remains empty.
> > 
> > Signed-off-by: Pali Roh?r <pali.rohar@gmail.com>
> 
> Acked-by: Pavel Machek <pavel@ucw.cz>

Acked-by: Tony Lindgren <tony@atomide.com>
