From: alexander.shishkin@linux.intel.com (Alexander Shishkin)
Date: Fri, 16 Nov 2012 14:55:46 +0200
Subject: [PATCH 8/9] usb: chipidea: udc: remove unlocked ep_queue which
 can lead to an race
In-Reply-To: <1352909950-32555-9-git-send-email-m.grzeschik@pengutronix.de>
References: <1352909950-32555-1-git-send-email-m.grzeschik@pengutronix.de>
 <1352909950-32555-9-git-send-email-m.grzeschik@pengutronix.de>
Message-ID: <87txsp671p.fsf@ashishki-desk.ger.corp.intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Michael Grzeschik <m.grzeschik@pengutronix.de> writes:

> Its not nessecary to call ep_queue unlocked while in the
> own driver. So we move the function to an unlocked version
> and call it conditionaly.

What do you mean by "conditionally" here? Also, when you say race, you
might as well mention what code is racing what to make things clearer.

Otherwise looks good, assuming that you have tested this with lockdep
enabled.

Regards,
--
Alex
