From: JacekBurghardt@caias.us (Jacek Burghardt)
Date: Sun, 21 Nov 2010 20:03:23 +0000
Subject: [PATCH v3 5/5] OMAP: mailbox: add notification support for
	multiple readers
Message-ID: <3r3uw0pt42hbqvtsfo5996q6.1290369799122@email.android.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



Felipe Balbi <me@felipebalbi.com> wrote:


Hi Hari,

On Fri, 2010-11-19 at 22:01 -0600, Kanigeri, Hari wrote:
> Of course :), profiling was done before releasing this code and no
> difference observed with or without blocking notifier. All the OMAP4

would you share some numbers ?

> use cases are exercising this code. Just curious , are you doubting
> the blocking notifier mechanism ?

a little bit. Yeah. It added about 600ms of time spent on musb's probe
when we were using blocking notifier for charger detection. When we
moved to atomic notifier, that was solved. Anyway, you can never be sure
when that will be scheduled and if cpu is really busy, it might pose a
great deal.

--
balbi


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel at lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
