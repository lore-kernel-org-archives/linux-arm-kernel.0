From: jrnieder@gmail.com (Jonathan Nieder)
Date: Wed, 23 May 2012 13:18:29 -0500
Subject: [PATCH] ixp4xx: fix compilation by adding gpiolib support
In-Reply-To: <20120523172703.GI21608@burratino>
References: <1337789991-5283-1-git-send-email-richardcochran@gmail.com>
 <20120523172703.GI21608@burratino>
Message-ID: <20120523181829.GK21608@burratino>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Jonathan Nieder wrote:

> 	The problem was introduced with commit eb9ae7f2a381 ("gpio: fix build
> 	error in include/asm-generic/gpio.h").
[...]
> Richard Cochran wrote:

>> This fix should also go for 3.1, 3.2, 3.3, and 3.4.
>
> If 3.1.y were still maintained, do I understand correctly that it
> would not need this because it lacks eb9ae7f2a381?

Quick correction: looks like[*] 3.1 is also affected due to
58c244009ef6 ("Input: ads7846 - cleanup GPIO initialization").  Sorry
I missed that before.

drivers/input/touchscreen/ads7846.c: In function 'ads7846_setup_pendown':
drivers/input/touchscreen/ads7846.c:970: error: implicit declaration of
function 'gpio_request_one'

Hope that helps,
Jonathan

[*] http://thread.gmane.org/gmane.linux.kernel/1250585/focus=1250984
