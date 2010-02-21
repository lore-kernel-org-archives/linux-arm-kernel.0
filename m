From: anarsoul@gmail.com (Vasily Khoruzhick)
Date: Mon, 22 Feb 2010 00:58:48 +0200
Subject: [PATCH 2/4] s3c24xx_ts: report touch only when stylus is down
In-Reply-To: <20100221225125.GA18604@core.coreip.homeip.net>
References: <1266510750-9846-1-git-send-email-anarsoul@gmail.com>
	<201002212344.39633.anarsoul@gmail.com>
	<20100221225125.GA18604@core.coreip.homeip.net>
Message-ID: <201002220058.52583.anarsoul@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

? ????????? ?? 22 ??????? 2010 00:51:25 ????? Dmitry Torokhov ???????:
> We do put it in WAIT4INT mode rigtht there though so it looks like we
> just need to move that call (well the original doing WAIT4INT | INT_UP)
> before we check for pen state.

And we need to disable WAIT4INT mode in s3c24xx_ts_schedule_read (actually 
according to spec we need to disable it right after we got interrupt).

Regards
Vasily
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 198 bytes
Desc: This is a digitally signed message part.
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20100222/23ce84ed/attachment.sig>
