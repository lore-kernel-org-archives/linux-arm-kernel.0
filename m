From: gregkh@linuxfoundation.org (Greg Kroah-Hartman)
Date: Thu, 25 Feb 2016 16:09:30 +0000
Subject: [PATCH v2] tty/serial: at91: restore dynamic driver binding
In-Reply-To: <56CED0E3.5070308@atmel.com>
References: <1456392221-30401-1-git-send-email-romain.izard.pro@gmail.com>
 <56CED0E3.5070308@atmel.com>
Message-ID: <20160225160929.GA20373@kroah.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Feb 25, 2016 at 11:01:07AM +0100, Nicolas Ferre wrote:
> Le 25/02/2016 10:23, Romain Izard a ?crit :
> > In commit c39dfebc7798956fd2140ae6321786ff35da30c3, the modular support
> > code for atmel_serial was removed, as the driver cannot be built as a
> > module. Because no use case was proposed, the dynamic driver binding
> > support was removed as well.
> > 
> > The atmel_serial driver can manage up to 7 serial controllers, which are
> > multiplexed with other functions. For example, in the Atmel SAMA5D2, the
> > Flexcom controllers can work as USART, SPI or I2C controllers, and on
> > all Atmel devices serial lines can be reconfigured as GPIOs.
> > 
> > My use case uses GPIOs to transfer a firmware update using a custom
> > protocol on the lines used as a serial port during the normal life of
> > the device. If it is not possible to unbind the atmel_serial driver, the
> > GPIO lines remain reserved and prevent this case from working.
> > 
> > This patch reinstates the atmel_serial_remove function, and fixes it as
> > it failed to clear the "clk" field on removal, triggering an oops when
> > a device was bound again after being unbound.
> > 
> > Signed-off-by: Romain Izard <romain.izard.pro@gmail.com>
> 
> Even if you didn't follow my advice for not including unneeded changes
> in of the last patch chunk, there's no use delaying the patch just for
> this. So, here is my:

Yes there is, I'm not going to take this, Romain please fix it properly.

greg k-h
