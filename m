From: david-b@pacbell.net (David Brownell)
Date: Tue, 7 Sep 2010 10:32:38 -0700 (PDT)
Subject: [PATCH] pio: add arch specific gpio_is_valid() function
In-Reply-To: <0D5B5291-80B9-4576-8DC7-8F33CFF2A803@niasdigital.com>
Message-ID: <255134.38265.qm@web180307.mail.gq1.yahoo.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> gpio_is_valid determines whether a gpio /can/ be attached to acontroller,

Or more simply:  whether its numeric prameter is
a valid argument to gpio_request() and friends.


 gpio_request determines whether that gpio
> currently /is/
> attached to a controller.

Of course, "controller" is out of sight of folk
just using GPIOs.  Otherwise, that's a fair take
on one set of gpio_request() error reports.


? Part of the confusion seems
> to come at least
> in part from the overlooking of facility for dynamically added gpio numbers.

Maybe, but I think most of it came from folk who
expected "valid" to mean (your terminology) the
GPIO number is now connected to a controller.
(Otherwise $SUBJECT would be meaningless since
there'd be no arch-specific issue.
> 
> Fix the documentation to clarify these points.

Patch is forthcoming.
