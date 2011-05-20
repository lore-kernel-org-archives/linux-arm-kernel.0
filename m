From: robert.jarzmik@free.fr (Robert Jarzmik)
Date: Fri, 20 May 2011 19:36:49 +0200
Subject: [PATCH] mioa701: move gpio-pullup functionality to gpio-vbus
In-Reply-To: <1305719866-9811-1-git-send-email-dbaryshkov@gmail.com>
References: <1305719866-9811-1-git-send-email-dbaryshkov@gmail.com>
Message-ID: <4DD6A6B1.9010209@free.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/18/2011 01:57 PM, Dmitry Eremin-Solenikov wrote:
> gpio-vbus can (and should?) handle D+ pullup gpio for us. Move gpio-pullup handling
> to gpio-vbus and stop providing udc_info as it's empty now.
No sorry, NAK.

As a matter of fact, even if gpio-vbus driver handles correctly the VBUS 
sensing and D+ line powering, it still lacks the suspend / resume 
handling to "disconnect the D+ line" on suspend and reconnect it on 
"resume". That's the reason I nack this patch, as for me, gpio-vbus and 
pxa27x-udc are not yet iso functional.

If I was provided proof that this is innoccuous (ie. there is no power 
draw possible in suspend, or that the resume procedure still works with 
gpio-vbus), then I'll ack the patch.

Cheers.

--
Robert
