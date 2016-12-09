From: grygorii.strashko@ti.com (Grygorii Strashko)
Date: Fri, 9 Dec 2016 16:46:39 -0600
Subject: [PATCH] usb: dwc3: omap: remove devm_request_threaded_irq
In-Reply-To: <20161209215958.GN4920@atomide.com>
References: <20161209205508.6456-1-grygorii.strashko@ti.com>
 <20161209215958.GN4920@atomide.com>
Message-ID: <db75608b-f92c-6bfa-80a9-a3ab3adf7c23@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 12/09/2016 03:59 PM, Tony Lindgren wrote:
> * Grygorii Strashko <grygorii.strashko@ti.com> [161209 12:55]:
>> Switch back from devm_request_threaded_irq() to request_threaded_irq() to
>> avoid races between interrupt handler execution and PM runtime in error
>> handling code path in probe and in dwc3_omap_remove():
>
> Can't you just call disable_irq() on the exit path instead of removing
> devm?
>

I can. But what will be the benefit from using devm then?

-- 
regards,
-grygorii
