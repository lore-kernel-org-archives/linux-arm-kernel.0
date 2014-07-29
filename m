From: treding@nvidia.com (Thierry Reding)
Date: Tue, 29 Jul 2014 10:42:38 +0200
Subject: linux-next: build failure after merge of the gpio tree
In-Reply-To: <20140729183153.0e77a6f6@canb.auug.org.au>
References: <20140729183153.0e77a6f6@canb.auug.org.au>
Message-ID: <20140729084237.GE31360@ulmo.nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 29, 2014 at 10:31:53AM +0200, Stephen Rothwell wrote:
> * PGP Signed by an unknown key
> 
> Hi Linus,
> 
> After merging the gpio tree, today's linux-next build (arm
> multi_v7_defconfig) failed like this:
> 
> In file included from arch/arm/mach-tegra/board-paz00.c:20:0:
> include/linux/gpio/machine.h:24:2: error: unknown type name 'u16'
>   u16 chip_hwnum;
>   ^
> include/linux/gpio/machine.h:31:19: error: field 'list' has incomplete type
>   struct list_head list;
>                    ^
> 
> Caused by commit 0a6d315827ee ("gpio: split gpiod board registration
> into machine header") or an interaction of that with commit
> a0524acc94c9 ("ARM: tegra: Sort includes alphabetically") from the
> arm-soc tree.
> 
> linux/gpio/machine.h needs to include some of the same files that
> linux/gpio/driver.h does.  See Rule 1 in Documentation/SubmitChecklist.
> 
> I have used the version of the gpio tree from next-20140728 for today.

I think linux/gpio/machine.h needs at least linux/types.h (for u16,
though I guess that "dependency" could be removed by simply making
gpiod_lookup.chip_hwnum an unsigned int) and linux/list.h for struct
list_head.

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140729/67c920e9/attachment.sig>
