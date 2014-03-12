From: santosh.shilimkar@ti.com (Santosh Shilimkar)
Date: Thu, 13 Mar 2014 00:35:41 +0800
Subject: [PATCH] arm: boot: dts: build keystone devicetree blob
In-Reply-To: <1394639330-1288-1-git-send-email-balbi@ti.com>
References: <1394639330-1288-1-git-send-email-balbi@ti.com>
Message-ID: <53208CDD.7030106@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 12 March 2014 11:48 PM, Felipe Balbi wrote:
> Currently, even when building keystone only
> kernel builds, DTB won't get build because
> we lack a Makefile rule to get it compiled.
> 
> This patch adds that rule so mainline kernel
> users have a chance to use up-to-date DTB on
> keystone 2 platforms.
> 
> Signed-off-by: Felipe Balbi <balbi@ti.com>
> ---
>
We have been building dtbs with explicit command
instead of dtbs since it was just one dtb so far
supported. Was planning to add the rule once more
boards get added. Now with Lamarr and Edision in
for next merge window, will do that post 3.15-rc1.

> note that I just tried this on top of linux-next
> (commit 69d5cdda16b3c9767b82d80b07edb9bb056448e3)
> and, even though dtb builds fine, I still couldn't
> get keystone_defconfig uImage to boot fine.
> 
> It's probably my LOADADDR which is wrong.
> 
> Santosh, what's the LOADADDR I should be using
> for keystone boots ?
>
LOADADDR is same 0x80008000. You might have missed
to configure the environment u-boot variable to
disable higher address space switch.
'setenv mem_lpae 0'. Also ensure to update
the boot loaders since the default ones comes with
EVM are long back outdated.

Regards,
Santosh
 
