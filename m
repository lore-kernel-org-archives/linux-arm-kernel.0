From: pavel@ucw.cz (Pavel Machek)
Date: Mon, 5 Jun 2017 22:05:31 +0200
Subject: [[PATCH]] drivers: leds/trigger: system cannot enter suspend
In-Reply-To: <1496648191-134355-1-git-send-email-bo.zhang@nxp.com>
References: <1496648191-134355-1-git-send-email-bo.zhang@nxp.com>
Message-ID: <20170605200531.GA24496@amd>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon 2017-06-05 15:36:31, Zhang Bo wrote:
> System cannot enter suspend mode because of heartbeat led trigger.

Can you tell us _why_ the heartbeat trigger prevents suspend/resume?

Because it does not:

# echo heartbeat > /sys/class/leds/tpacpi\:\:standby/trigger
# echo mem > /sys/power/state
(system suspends, as expected).
#

Linux amd 4.12.0-rc2+ #400 SMP Mon May 22 22:44:02 CEST 2017 i686...

If it does for you, you may want to find out why, then fix that.

Thanks,
									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 181 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170605/2886f31f/attachment.sig>
