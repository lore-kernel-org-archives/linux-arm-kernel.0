From: anarsoul@gmail.com (Vasily Khoruzhick)
Date: Mon, 22 Feb 2010 11:03:00 +0200
Subject: [PATCH 2/4] s3c24xx_ts: report touch only when stylus is down
In-Reply-To: <20100222071403.GD2095@core.coreip.homeip.net>
References: <1266510750-9846-1-git-send-email-anarsoul@gmail.com>
	<201002220058.52583.anarsoul@gmail.com>
	<20100222071403.GD2095@core.coreip.homeip.net>
Message-ID: <201002221103.13677.anarsoul@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

? ????????? ?? 22 ??????? 2010 09:14:03 ????? Dmitry Torokhov ???????:
> +               /* Reset WAIT4INT state */
> +               writel(0, ts.io + S3C2410_ADCTSC);

That's wrong, should be writel(S3C2410_ADCTSC_PULL_UP_DISABLE | AUTOPST, ts.io 
+ S3C2410_ADCTSC), anyway it doesn't work even with this fix

> -               if (pen_is_down)
> +               if (pen_is_down) {
> +                       /* Reset WAIT4INT state */
> +                       writel(0, ts.io + S3C2410_ADCTSC);

Same note.

Regards
Vasily
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 198 bytes
Desc: This is a digitally signed message part.
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20100222/3a96c2de/attachment.sig>
