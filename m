From: ludovic.desroches@atmel.com (Ludovic Desroches)
Date: Wed, 17 Jun 2015 14:42:53 +0200
Subject: [RESEND PATCH 2/2] pinctrl: introduce complex pin description
In-Reply-To: <557EF6D9.6050503@wwwdotorg.org>
References: <1433948699-19800-1-git-send-email-ludovic.desroches@atmel.com>
 <1433948699-19800-3-git-send-email-ludovic.desroches@atmel.com>
 <557EF6D9.6050503@wwwdotorg.org>
Message-ID: <20150617124253.GC12295@odux.rfo.atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 15, 2015 at 10:01:29AM -0600, Stephen Warren wrote:
> On 06/10/2015 09:04 AM, Ludovic Desroches wrote:
> >Using a string to describe a pin in the device tree can be not enough.
> >Some controllers may need extra information to fully describe a pin. It
> >concerns mainly controllers which have a per pin muxing approach which
> >don't fit well the notions of groups and functions.
> >Instead of using a pin name, a 32 bit value is used. The 16 least
> >significant bits are used for the pin number. Other 16 bits can be used to
> >store extra parameters.
> 
> The driver for the pin controller is supposed to provide this information in
> a table. The whole point of having a driver, rather than a table/list of raw
> register values in the DT, is so the driver can provide this information at
> a semantic level. This information is fixed per SoC and so make sense to put
> into a driver, while the board-specific configuration varies wildly, and
> hence makes sense to put into DT.
> 
> 

I didn't think the controversery part would be about having this
information in a driver or in the device tree. I think there are pros
and cons for both cases.

We already have this description in our dt file with the previous at91
pin controller and I think it is a good thing to not have to update the
driver for each new SoC using the same pio controller. Tables could become
huge, embedding several one into a 'single zImage' is something I am not
confortable with. I know that some people could tell me that doing that
may increase the boot time.                                     
                                                                                
We should debate about this patch later. If there is no acceptance for
the previous one, I have to clarify if I need it.


Regards

Ludovic   
