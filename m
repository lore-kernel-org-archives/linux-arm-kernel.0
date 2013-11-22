From: balbi@ti.com (Felipe Balbi)
Date: Thu, 21 Nov 2013 21:51:28 -0600
Subject: [PATCH 5/8] ARM: OMAP2+: timer: Introduce OF-friendly
 clocksource/clockevent system timers
In-Reply-To: <1385085414-9034-6-git-send-email-joelf@ti.com>
References: <1385085414-9034-1-git-send-email-joelf@ti.com>
 <1385085414-9034-6-git-send-email-joelf@ti.com>
Message-ID: <20131122035127.GA1417@saruman.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Thu, Nov 21, 2013 at 07:56:51PM -0600, Joel Fernandes wrote:

[...]

> New functions for OF-only boot are introduced, and we can soon delete the old
> versions once we migrate all platforms. Currently only AM335x is migrated and

actually, you don't need to initialize .init_timer at all in DT boot.
Just use CLKSOURCE_OF_DECLARE() and pass your omap_generic_timer_init()
as argument (although, I'd call it omap_of_timer_init()).

That will put of_device_id structure on a special section
(__clksource_of_table) and pass your function as a data argument. That
function will be called automatically during init.

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20131121/cacbd4ae/attachment.sig>
