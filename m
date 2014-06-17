From: balbi@ti.com (Felipe Balbi)
Date: Tue, 17 Jun 2014 08:19:35 -0500
Subject: [PATCH] ARM: OMAP2+: l2c: squelch warning dump on power control
 setting
In-Reply-To: <3c3a7a4861df01d0163787a9c18f7b7ac821c5b9.1403000372.git.nsekhar@ti.com>
References: <3c3a7a4861df01d0163787a9c18f7b7ac821c5b9.1403000372.git.nsekhar@ti.com>
Message-ID: <20140617131935.GB9070@saruman.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 17, 2014 at 04:04:51PM +0530, Sekhar Nori wrote:
> ROM code on AM437x does not support writing to L2C-310 power control
> register. The L2C driver, however, tries writing to this register for
> all revisions >= r3p0.
> 
> This leads to a warning dump on boot which leads most users to believe
> that L2 cache is non-functional.
> 
> Since the problem is understood, and cannot be addressed through software,
> replace the warning with a pr_info() while maintaining the WARN_ON() for
> other truly unexpected scenarios.
> 
> Reported-by: Nishanth Menon <nm@ti.com>
> Signed-off-by: Sekhar Nori <nsekhar@ti.com>

Tested with today's linux-next
(5f295cdf5c5dbbb0c40f10f2ddae02ff46bbf773) with am437x-sk, I can see
that the WARNING goes away.

Tested-by: Felipe Balbi <balbi@ti.com>

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140617/86f291a2/attachment.sig>
