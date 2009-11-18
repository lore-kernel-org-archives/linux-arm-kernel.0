From: lost.distance@yahoo.com (Paul Parsons)
Date: Wed, 18 Nov 2009 00:22:41 +0000
Subject: [PATCH] hx4700: fix hx4700 touchscreen pressure values
Message-ID: <E1NAYJo-00016g-PW@pih-relay04.plus.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> Does pressure actually work as expected -- that is not inverted?
> Because I need this patch on spitz...  but it may break your
> machine...

You are right, the pressure values were being inverted on my hx4700.
Pressing hard generates somewhat lower Rt values than pressing lightly.

Since typical hx4700 Rt values are close to (pressure_max/2) anyway,
the inverted and non-inverted values were not very different.
For example:

Rt      ts->pressure_max-Rt
599     425
562     462
588     436
570     454

So by all means submit your ads7846.c patch; it will not break hx4700.
