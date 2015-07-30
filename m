From: bp@alien8.de (Borislav Petkov)
Date: Thu, 30 Jul 2015 06:31:48 +0200
Subject: [PATCH v2 2/3] edac: Add L3/SoC support to the APM X-Gene SoC
 EDAC driver
In-Reply-To: <CAPw-ZTkZ7q8PUWydFad5TXrhcY6YBRjdVvz+SR+LV4sOLDKkEg@mail.gmail.com>
References: <1437808063-17592-1-git-send-email-lho@apm.com>
 <1437808063-17592-2-git-send-email-lho@apm.com>
 <1437808063-17592-3-git-send-email-lho@apm.com>
 <20150729142941.GC17367@nazgul.tnic>
 <CAPw-ZTkZ7q8PUWydFad5TXrhcY6YBRjdVvz+SR+LV4sOLDKkEg@mail.gmail.com>
Message-ID: <20150730043148.GC7209@nazgul.tnic>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 29, 2015 at 04:39:10PM -0700, Loc Ho wrote:
> Debug folder node shows up at /sys/kernel/debug/<file here> while the
> MC debug node shows up at /sys/kernel/debug/edac where <file here> is
> the driver node name. It would be better if everything shows up at
> /sys/kernel/debug/edac. For this to happen, I need EDAC core change to
> provide an parent node.

Sure, feel free to add accessors for edac_debugfs from
drivers/edac/edac_mc_sysfs.c which edac drivers can call and thus
receive the top-level debugfs node.

For that, you can put all those accessor prototypes into a
drivers/edac/edac-internal.h header which should be included only by
edac drivers.

> No... each EDAC instance has its own context as we allocated via
> function edac_device_alloc_ctl_info. Per type of instance will use the
> same type function.

So you have multiple instances running on the system? I don't think
anyone has audited the edac core and whether it can actually handle
that...

-- 
Regards/Gruss,
    Boris.

ECO tip #101: Trim your mails when you reply.
--
