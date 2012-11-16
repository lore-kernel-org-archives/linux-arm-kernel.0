From: gregkh@linuxfoundation.org (Greg KH)
Date: Fri, 16 Nov 2012 04:02:34 -0800
Subject: [PATCH 1/9] usb: chipidea: pci: mark platformdata as static and
 __devinitdata
In-Reply-To: <87haop7tfi.fsf@ashishki-desk.ger.corp.intel.com>
References: <1352909950-32555-1-git-send-email-m.grzeschik@pengutronix.de>
 <1352909950-32555-2-git-send-email-m.grzeschik@pengutronix.de>
 <87haop7tfi.fsf@ashishki-desk.ger.corp.intel.com>
Message-ID: <20121116120234.GA13498@kroah.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 16, 2012 at 12:06:57PM +0200, Alexander Shishkin wrote:
> Michael Grzeschik <m.grzeschik@pengutronix.de> writes:
> 
> > From: Marc Kleine-Budde <mkl@pengutronix.de>
> >
> > Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
> > Signed-off-by: Michael Grzeschik <m.grzeschik@pengutronix.de>
> 
> static yes, __devinitdata -- probably not. These structs are used
> everywhere throughout the driver currently, not only at initialization
> time.

__devinitdata means nothing anymore given that CONFIG_HOTPLUG is always
enabled.  It also will probably be removed for 3.8, so don't even worry
about adding these types of markings to variables.

thanks,

greg k-h
