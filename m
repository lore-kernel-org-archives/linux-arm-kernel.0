From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Tue, 16 Aug 2016 20:13:38 +0100
Subject: [PATCH v2] ARM: Add missing newline terminators to kernel messages
In-Reply-To: <1471354832-18456-1-git-send-email-geert+renesas@glider.be>
References: <1471354832-18456-1-git-send-email-geert+renesas@glider.be>
Message-ID: <20160816191338.GL1041@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Aug 16, 2016 at 03:40:32PM +0200, Geert Uytterhoeven wrote:
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
> Before commit 874f9c7da9a4acbc ("printk: create pr_<level> functions"),
> pr_*() calls without a trailing newline characters would be printed with
> a newline character appended, both on the console and in the output of
> the dmesg command.
> 
> After that commit, no new line character is appended, and the output of
> the next pr_*() call of the same type may be appended:
> 
>     - Truncating RAM at 0x0000000040000000-0x00000000c0000000 to -0x0000000070000000
>     - Ignoring RAM at 0x0000000200000000-0x0000000240000000 (!CONFIG_HIGHMEM)
>     + Truncating RAM at 0x0000000040000000-0x00000000c0000000 to -0x0000000070000000Ignoring RAM at 0x0000000200000000-0x0000000240000000 (!CONFIG_HIGHMEM)
> 
> and:
> 
>     -No ATAGs?
>     -hw-breakpoint: found 5 (+1 reserved) breakpoint and 4 watchpoint registers.
>     +No ATAGs?hw-breakpoint: found 5 (+1 reserved) breakpoint and 4 watchpoint registers.
> 
> While this commit has been reverted in commit a0cba2179ea4c182 ("Revert
> "printk: create pr_<level> functions""), it's still good practice to
> terminate kernel messages with newlines.

Shouldn't that be above the "---" line?

Other than that, patch looks fine, thanks.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
