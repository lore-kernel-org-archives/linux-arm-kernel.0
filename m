From: baruch@tkos.co.il (Baruch Siach)
Date: Tue, 16 May 2017 09:08:27 +0300
Subject: [RESEND PATCH] iio: adc: bcm_iproc_adc: swap primary and
 secondary isr handler's
In-Reply-To: <20170516060110.GA25722@kroah.com>
References: <1494913772-30904-1-git-send-email-raveendra.padasalagi@broadcom.com>
 <20170516060110.GA25722@kroah.com>
Message-ID: <20170516060826.wnw3mpq5makpnptt@sapphire.tkos.co.il>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Greg,

On Tue, May 16, 2017 at 08:01:10AM +0200, Greg KH wrote:
> On Tue, May 16, 2017 at 11:19:32AM +0530, Raveendra Padasalagi wrote:
> > The third argument of devm_request_threaded_irq() is the primary
> > handler. It is called in hardirq context and checks whether the
> > interrupt is relevant to the device. If the primary handler returns
> > IRQ_WAKE_THREAD, the secondary handler (a.k.a. handler thread) is
> > scheduled to run in process context.
> > 
> > bcm_iproc_adc.c uses the secondary handler as the primary one
> > and the other way around. So this patch fixes the same, along with
> > re-naming the secondary handler and primary handler names properly.
> > 
> > Tested on the BCM9583XX iProc SoC based boards.
> > 
> > Reported-by: Pavel Roskin <plroskin@gmail.com>
> > Fixes: 4324c97ecedc("iio: Add driver for Broadcom iproc-static-adc")
> > Signed-off-by: Raveendra Padasalagi <raveendra.padasalagi@broadcom.com>
> > ---
> >  drivers/iio/adc/bcm_iproc_adc.c | 8 ++++----
> >  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> <formletter>
> 
> This is not the correct way to submit patches for inclusion in the
> stable kernel tree.  Please read Documentation/stable_kernel_rules.txt
> for how to do this properly.

File moved to Documentation/process/stable-kernel-rules.rst since v4.10.

Maybe linking to 
https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html would 
be better.

> </formletter>

baruch

-- 
     http://baruch.siach.name/blog/                  ~. .~   Tk Open Systems
=}------------------------------------------------ooO--U--Ooo------------{=
   - baruch at tkos.co.il - tel: +972.2.679.5364, http://www.tkos.co.il -
