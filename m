From: nm@ti.com (Menon, Nishanth)
Date: Mon, 7 Feb 2011 11:03:15 +0530
Subject: [PATCH 03/20] mach-omap2: smartreflex: world-writable debugfs
	voltage files
In-Reply-To: <87zkqbjtrd.fsf@ti.com>
References: <cover.1296818921.git.segoon@openwall.com>
	<96a2b24548af3a68fde712c68b49e856e53ea1fc.1296818921.git.segoon@openwall.com>
	<87zkqbjtrd.fsf@ti.com>
Message-ID: <AANLkTinMBQZa+-_T4O1dOZcUGjOM4748J+m_WmEV=LXW@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Feb 5, 2011 at 04:24, Kevin Hilman <khilman@ti.com> wrote:
> Vasiliy Kulikov <segoon@openwall.com> writes:
>
>> Don't allow everybody to change voltage settings.
>>
>> Signed-off-by: Vasiliy Kulikov <segoon@openwall.com>
>> ---
>> ?Cannot compile the driver, so it is not tested at all.
>
> Acked-by: Kevin Hilman <khilman@ti.com>
Also fixes the checkpatch warning:
scripts/checkpatch.pl -f arch/arm/mach-omap2/smartreflex.c
WARNING: Exporting world writable files is usually an error. Consider
more restrictive permissions.
#903: FILE: arm/mach-omap2/smartreflex.c:903:
+	(void) debugfs_create_file("autocomp", S_IRUGO | S_IWUGO, dbg_dir,

total: 0 errors, 1 warnings, 1028 lines checked

Acked-by: Nishanth Menon <nm@ti.com>

Regards,
Nishanth Menon
