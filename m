From: abhijitpagare@ti.com (Pagare, Abhijit)
Date: Wed, 23 Dec 2009 16:57:53 +0530
Subject: [PATCH 1/1] ARM: OMAP4: PM: Remove the checks preventing OMAP4
	clockdomain validation
In-Reply-To: <alpine.DEB.2.00.0912220911160.5563@utopia.booyaka.com>
References: <1261391747-24066-1-git-send-email-abhijitpagare@ti.com>
	<alpine.DEB.2.00.0912220911160.5563@utopia.booyaka.com>
Message-ID: <EAF47CD23C76F840A9E7FCE10091EFAB02C017980E@dbde02.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Paul,
	While testing after the below change I found out that some sleep/wakeup dependency related checks have to be avoided for OMAP4 to boot up properly as the dependencies have not been populated currently for OMAP4. 	Also I was validating the clock->clockdomain registering and noticed that one of the clock-domains is missing in the auto-generated file.
	So along with the current patch in discussion I am sending two separate patches for fixing the above things as well.

Best Regards,
Abhijit Pagare

> -----Original Message-----
> From: Paul Walmsley [mailto:paul at pwsan.com]
> Sent: Tuesday, December 22, 2009 9:43 PM
> To: Pagare, Abhijit
> Cc: linux-omap at vger.kernel.org; linux-arm-kernel at lists.infradead.org;
> Cousson, Benoit; Nayak, Rajendra
> Subject: Re: [PATCH 1/1] ARM: OMAP4: PM: Remove the checks preventing
> OMAP4 clockdomain validation
> 
> Hello Abhijit,
> 
> On Mon, 21 Dec 2009, Abhijit Pagare wrote:
> 
> > The clockdomain related code beng in place it is now not necessary to
> have
> > some of the clock code commented out. This would help the validation of
> the
> > clockdomain functions using the clock level interfaces.
> >
> > Signed-off-by: Abhijit Pagare <abhijitpagare@ti.com>
> > Cc: Paul Walmsley <paul@pwsan.com>
> > Cc: Benoit Cousson <b-cousson@ti.com>
> > Cc: Rajendra Nayak <rnayak@ti.com>
> 
> Could you also deal with the TODO in mach-omap2/clock44xx_data.c ?
> 
> Also, has this patch been tested?  If so, please list the platform it was
> tested on in the commit message.
> 
> thanks,
> 
> - Paul
