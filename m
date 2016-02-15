From: tj@kernel.org (Tejun Heo)
Date: Mon, 15 Feb 2016 13:30:41 -0500
Subject: [PATCH V2] AHCI: Workaround for ThunderX Errata#22536
In-Reply-To: <56C147B2.9010303@caviumnetworks.com>
References: <1455319230-30201-1-git-send-email-tchalamarla@caviumnetworks.com>
 <20160214170152.GC3965@htj.duckdns.org>
 <56C147B2.9010303@caviumnetworks.com>
Message-ID: <20160215183041.GH3965@htj.duckdns.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello, Tirumalesh.

On Sun, Feb 14, 2016 at 07:36:18PM -0800, Tirumalesh Chalamarla wrote:
> There is no need for special Driver, AHCI is sufficient for ThunderX, the
> file only contains this interrupt handler,
> is it preferable if this interrupt handler in libahci.c with others, instead
> of separate file?

Yeap, just fold it in ahci.c with surrounding #ifdef guard.

Thanks.

-- 
tejun
