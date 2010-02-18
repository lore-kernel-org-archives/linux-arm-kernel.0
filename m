From: anarsoul@gmail.com (Vasily Khoruzhick)
Date: Thu, 18 Feb 2010 17:00:09 +0200
Subject: [PATCH] Add resources description for s3c24xx ts driver
In-Reply-To: <201002181601.20625.anarsoul@gmail.com>
References: <201002181601.20625.anarsoul@gmail.com>
Message-ID: <201002181700.15340.anarsoul@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

? ????????? ?? 18 ??????? 2010 16:01:14 ????? Vasily Khoruzhick ???????:
> Following patch adds resource description for s3c24xx ts driver.
> Without this patch driver fails to initialize with "no resource for
> interrupt" message.
> 
> Anyway, even with this patch driver stops reporting events after few
> presses, I'll investigate on it later.
> 
> Btw, does this driver work at least for anyone?
> 
> Regards
> Vasily

Ok, found problem: driver reports touches even if stylus is not down. Here's 
patch in attachment.

Regards
Vasily
-------------- next part --------------
A non-text attachment was scrubbed...
Name: 0002-s3c24xx_ts-report-touch-only-when-stylus-is-down.patch
Type: text/x-patch
Size: 1581 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20100218/bfa92d42/attachment.bin>
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 198 bytes
Desc: This is a digitally signed message part.
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20100218/bfa92d42/attachment.sig>
