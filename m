From: mmarek@suse.com (Michal Marek)
Date: Thu, 19 Nov 2015 16:07:04 +0100
Subject: [PATCH] ARM: xip: Move XIP linking to a separate file
In-Reply-To: <1447943047-22427-1-git-send-email-chris.brandt@renesas.com>
References: <1447943047-22427-1-git-send-email-chris.brandt@renesas.com>
Message-ID: <564DE598.7060404@suse.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2015-11-19 15:24, Chris Brandt wrote:
> When building an XIP kernel, the linker script needs to be much different
> than a conventional kernel's script. Over time, it's been difficult to
> maintain both XIP and non-XIP layouts in one linker script. Therefore,
> this patch separates the two procedures into two completely different
> files.
> 
> The new linker script is essentially a straight copy of the current script
> with all the non-CONFIG_XIP_KERNEL portions removed.
> 
> Additionally, all CONFIG_XIP_KERNEL portions have been removed from the
> existing linker script...never to return again.
> 
> From now on, for any architecture, when CONFIG_XIP_KERNEL is enabled, you
> must provide a vmlinux-xip.lds.S for the build process.

Why not have a vmlinux.lds.S and #include a vmlinux-xip.lds.S /
vmlinux-nonxip.lds.S from there? That way, you do not clutter the main
Makefile and you can reuse the boilerplate of the linker script.

Michal
