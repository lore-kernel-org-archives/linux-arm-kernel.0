From: tony@atomide.com (Tony Lindgren)
Date: Fri, 9 Dec 2016 13:59:58 -0800
Subject: [PATCH] usb: dwc3: omap: remove devm_request_threaded_irq
In-Reply-To: <20161209205508.6456-1-grygorii.strashko@ti.com>
References: <20161209205508.6456-1-grygorii.strashko@ti.com>
Message-ID: <20161209215958.GN4920@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Grygorii Strashko <grygorii.strashko@ti.com> [161209 12:55]:
> Switch back from devm_request_threaded_irq() to request_threaded_irq() to
> avoid races between interrupt handler execution and PM runtime in error
> handling code path in probe and in dwc3_omap_remove():

Can't you just call disable_irq() on the exit path instead of removing
devm?

Regards,

Tony
