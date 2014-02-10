From: khilman@linaro.org (Kevin Hilman)
Date: Mon, 10 Feb 2014 10:18:57 -0800
Subject: [GIT PULL] mvebu: phy and ata fixes for v3.14
In-Reply-To: <20140208172217.GK8533@titan.lakedaemon.net> (Jason Cooper's
 message of "Sat, 8 Feb 2014 12:22:17 -0500")
References: <20140208172217.GK8533@titan.lakedaemon.net>
Message-ID: <7hd2iual0u.fsf@paris.lan>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Jason,

Jason Cooper <jason@lakedaemon.net> writes:

> All,
>
> Here is a small set of fixes for fix a boot hang we are currently
> experiencing in the boot farm.  Now that we are probing for the phy, we
> didn't take into account optional phys, which causes the hang.  These
> patches fix this and restore booting on the affected platforms.
>
> thx,
>
> Jason.
>
>
> The following changes since commit 38dbfb59d1175ef458d006556061adeaa8751b72:
>
>   Linus 3.14-rc1 (2014-02-02 16:42:13 -0800)
>
> are available in the git repository at:
>
>   git://git.infradead.org/linux-mvebu.git tags/mvebu-phy_ata-fixes-3.14
>
> for you to fetch changes up to 90aa2997029fa623fe9e3ec3a469a00a34130237:
>
>   ata: sata_mv: Fix probe failures with optional phys (2014-02-05 05:48:58 +0000)
>
> ----------------------------------------------------------------
> mvebu phy and ata fixes for v3.14
>
>  - phy
>     - add support for optional phys via NULL
>
>  - ata
>     - fix boot hang due to probe failure of optional phys
>
> NOTE:  Series has been Ack'd by both the phy maintainer and the ata maintainer
> for going through arm-soc
>
> ----------------------------------------------------------------

Thanks, applied to fixes.

Note that the openblocks ax3 will still fail boot test on
mvebu_defconfig in arm-soc because we're missing the the 'select
GENERIC_PHY' Kconfig fix which seems to have gone through libata/next.
That's fine though as things should boot fine in -next now.

Thanks for the fixes,

Kevin
