From: Wenyou.Yang@atmel.com (Yang, Wenyou)
Date: Tue, 11 Nov 2014 00:53:58 +0000
Subject: [PATCH v4] i2c/at91: adopt pinctrl support
In-Reply-To: <54609DD8.8030903@cogentembedded.com>
References: <1415584552-11390-1-git-send-email-wenyou.yang@atmel.com>
 <54609DD8.8030903@cogentembedded.com>
Message-ID: <B256D81BAE5131468A838E5D7A243641BFC71DAA@penmbx01>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

> -----Original Message-----
> From: Sergei Shtylyov [mailto:sergei.shtylyov at cogentembedded.com]
> Sent: Monday, November 10, 2014 7:13 PM
> To: Yang, Wenyou; wsa at the-dreams.de; Desroches, Ludovic
> Cc: khilman at kernel.org; Ferre, Nicolas; linux-kernel at vger.kernel.org; linux-
> i2c at vger.kernel.org; linux-arm-kernel at lists.infradead.org
> Subject: Re: [PATCH v4] i2c/at91: adopt pinctrl support
> 
> Hello.
> 
> On 11/10/2014 4:55 AM, Wenyou Yang wrote:
> 
> > Amend the at91 i2c pin controller
> 
>     You're amending the hardware itself, really? :-)
> 
> > to optionally take a pin controlhandle
> 
>     I don't see the code that does this.
> 
> > and set the state of the pins to:
> > - "default" on boot and resume.
> 
>     I don't see where you are changing anything for the probe() method.
> Perhaps you meant the driver core code which selects the dafault profile
> automatically?
Yes, the driver core code default do, so remove the redundant code from _probe function.

> 
> > - "sleep" on suspend().
> 
> > This should make it possible to optimize energy usage for the pins
> > both for the suspend/resume cycle
> 
> > Signed-off-by: Wenyou Yang <wenyou.yang@atmel.com>
> > ---
> > Hi Wolfram,
> >
> > Thanks a lot.
> >
> > The change of this version is to remove
> > 	pinctrl_pm_select_default_state(&pdev->dev) from the _probe function.
> 
>     Aha, you've specifically removed this...
> 
> WBR, Sergei

Best Regards,
Wenyou Yang
