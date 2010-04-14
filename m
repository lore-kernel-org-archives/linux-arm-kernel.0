From: cbouatmailru@gmail.com (Anton Vorontsov)
Date: Wed, 14 Apr 2010 19:37:29 +0400
Subject: [PATCH v3 0/3] Support for Cavium Networks CNS3xxx machines
In-Reply-To: <20100330190216.GA7611@oksana.dev.rtsoft.ru>
References: <20100330190216.GA7611@oksana.dev.rtsoft.ru>
Message-ID: <20100414153729.GA20979@oksana.dev.rtsoft.ru>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On Tue, Mar 30, 2010 at 11:02:16PM +0400, Anton Vorontsov wrote:
> v3 is on the way...

Russell, does this look OK to you?

If so, I'll wait for the next mach-types update, and then will
ask you to pull the cns3xxx tree (or I can submit these patches
via the patch tracker if you prefer that).

Oh, and can you please take a look at these two as well:

[PATCH] ARM: Add support for PCI domains
 http://lists.infradead.org/pipermail/linux-arm-kernel/2010-March/012461.html
[PATCH] ARM: cns3xxx: Add support for PCI Express ports
 http://lists.infradead.org/pipermail/linux-arm-kernel/2010-March/012462.html

Thanks!

> Changes since v2:
> 
> - We noticed that timer2 (which was used as a clock source) causes
>   nanosleep system call to misbehave. Until debugged, the timer2
>   support is removed.
> 
>   It's fine since timer1 is still used as a clockevent, and provides
>   all needed timekeeping functionality. With these patches we want
>   a minimal (but rock solid) CNS3xxx support, all non-essential
>   features can wait.
> 
>   I.e. support for the second timer can be added as a separate
>   patch.
> 
> - Updated some PCIe register definitions to make PCIe integration
>   more smooth.
> 
> - Updated defconfig.
> 
> Changes since v1:
> 
> - Addressed Russell's comments;
> - CNS3420VB board support split into its own patch per Sergei's
>   comment;
> - This series no longer include AHCI and SDHCI patches. Because of
>   dependencies on other trees they aren't yet suitable for inclusion,
>   so no need to repost them again.

-- 
Anton Vorontsov
email: cbouatmailru at gmail.com
irc://irc.freenode.net/bd2
