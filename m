From: N.Voss@weinmann.de (Voss, Nikolaus)
Date: Mon, 5 Nov 2012 07:08:29 +0100
Subject: [PATCH] i2c: at91: add a sanity check on i2c message length
In-Reply-To: <5093EE2B.8080005@atmel.com>
References: <1349879158-27268-1-git-send-email-ludovic.desroches@atmel.com>
 <20121101222922.GD22956@pengutronix.de> <5093A8CD.60006@atmel.com>
 <20121102111432.GD21313@pengutronix.de> <5093EE2B.8080005@atmel.com>
Message-ID: <EF2E73589CA71846A15D0B2CDF79505D090EFB340B@wm021.weinmann.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

ludovic.desroches wrote on Friday, November 02, 2012 5:01 PM:
> Le 11/02/2012 12:14 PM, Wolfram Sang a ?crit :
> > On Fri, Nov 02, 2012 at 12:04:45PM +0100, ludovic.desroches wrote:
> >> Hi Wolfram,
> >>
> >> Le 11/01/2012 11:29 PM, Wolfram Sang a ?crit :
> >>> On Wed, Oct 10, 2012 at 04:25:58PM +0200,
> ludovic.desroches at atmel.com wrote:
> >>>> From: Ludovic Desroches <ludovic.desroches@atmel.com>
> >>>>
> >>>> If the i2c message length is zero, i2c-at91 will directly return an error
> >>>> instead of trying to send a zero-length message.
> >>>>
> >>>> Signed-off-by: Ludovic Desroches <ludovic.desroches@atmel.com>
> >>>
> >>> What happens if you send a 0 byte message? Some hardware is able to
> do
> >>> this and it will be used in SMBUS QUICK which the driver states to
> >>> support according to at91_twi_func().
> >>
> >> Without this I had some data corruption when writing to / reading
> >> from a serial eeprom (depending on the IP version).
> >>
> >> Yes SMBUS quick command is supported but is not managed in the
> >> driver, we have to tell explicitly the IP that we want to send this
> >> command.
> >
> > Ok, so unless you want to implement the support, please update this
> > patch with a comment that SMBUS_QUICK is a TODO and remove the
> > SMBUS_QUICK capability.
> >
> 
> Implementation should not be a huge task, only one bit to set in a
> register but I have no device to test it.
> So I will choose to remove the SMBUS_QUICK capability.
> 
> Hi Nikolaus,
> 
> Did you test the driver with SMBus compatible devices? Can I keep other
> SMBus capabilities from SMBUS_EMUL?

Hi Ludovic,

yes, I use this driver with the sbs driver to query a smbus-attached
battery with a TI bq chip (I actually wrote this driver only for this
purpose). I implemented and tested SMBUS_BLOCK but not
SMBUS_QUICK...

Niko
