From: jthumshirn@suse.de (Johannes Thumshirn)
Date: Thu, 3 Mar 2016 09:30:12 +0100
Subject: [PATCH 08/14] scsi: mvumi: use __maybe_unused to hide pm functions
In-Reply-To: <1456934350-1389172-9-git-send-email-arnd@arndb.de>
References: <1456934350-1389172-1-git-send-email-arnd@arndb.de>
 <1456934350-1389172-9-git-send-email-arnd@arndb.de>
Message-ID: <20160303083012.GE25301@c203.arch.suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 02, 2016 at 04:59:00PM +0100, Arnd Bergmann wrote:
> The mvumi scsi hides the references to its suspend/resume functions
> in an #ifdef but does not hide the implementation the same way:
> 
> drivers/scsi/mvumi.c:2632:12: error: 'mvumi_suspend' defined but not used [-Werror=unused-function]
> drivers/scsi/mvumi.c:2651:12: error: 'mvumi_resume' defined but not used [-Werror=unused-function]
> 
> This adds __maybe_unused annotations so the compiler knows
> it can silently drop them instead of warning, while avoiding
> the addition of another #ifdef.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Reviewed-by: Johannes Thumshirn <jthumshirn@suse.de>

-- 
Johannes Thumshirn                                          Storage
jthumshirn at suse.de                                +49 911 74053 689
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 N?rnberg
GF: Felix Imend?rffer, Jane Smithard, Graham Norton
HRB 21284 (AG N?rnberg)
Key fingerprint = EC38 9CAB C2C4 F25D 8600 D0D0 0393 969D 2D76 0850
