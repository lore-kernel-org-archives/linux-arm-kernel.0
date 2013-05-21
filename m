From: elyas.r@gmail.com (Elyas Razzaghi)
Date: Wed, 22 May 2013 01:36:52 +0300
Subject: AT91SAM9260 I2C Driver
References: c88e466f0708070426i44ee92l3ed67fdefd9fa707@mail.gmail.com
Message-ID: <519BF704.40706@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

I have decided to use the PCA9665 I2C controller on my AT91RM9200 custom 
board. Could you help me with my board specific code to initialize the 
driver? How should I modify the code for PCA(I2C) part of my 
arch/arm/mach-at91/board-xxx.c file?

Best regards,
Elyas

On 2007-08-07 11:26, Michel Benoit wrote:
 > Hello Alex,
 >
 > I've cc'ed this email to the linux-arm-kernel list.
 >
 > > I too have decided to use the PCA9564 I2C controller, as the on-chip
 > > TWI controller was too buggy. I'm now trying to utilize the PCA9564
 > > driver included in 2.6.21, but am having some trouble figuring out how
 > > to use it. Would you mind answering a few questions for me?
 > >
 > > First off, I've included the PCA driver (not the ISA version) in my
 > > kernel using the menu configuration (not as a loadable module, but
 > > included it directly in the kernel), but I can't find anything in the
 > > running kernel that lets me know it has been included, except that the
 > > directory "/sys/bus/platform/drivers/pca9564" exists. I see nothing
 > > in the startup text stating that the driver is loaded and there is no
 > > entry in "/dev". Do you know what steps I need to take to load the
 > > driver?
 >
 > Have you included any board specific code to initialise the driver?
 >
 > Here is some code from my arch/arm/mach-at91rm9200/board-xxx.c file.
 >
 >
 > #if defined(CONFIG_I2C_PCA) || defined(CONFIG_I2C_PCA_MODULE)
 >
 > static struct at91_pca_data pca_data;
 >
 >
 >
 >
 > void __init at91_add_device_i2c_pca(struct at91_pca_data *data)
 > {
 >
 >
 >
 >
 >
 >
 >
 >
 >
 >
 >
 >
 > >
 > > Second, how do you physically connect the PCA9564 to your processor?
 > > Do you use GPIO, or is it placed on the data bus?
 >
 > The PCA9564 is on the system data bus with the irq and the reset pins
 > connected to gpio.
 >
 > I had to tweak the driver a little in order to use the GPIO reset pin
 > when the PCA detects an error condition on the bus.
 >
 >
 > > Thanks in advance for any help you can provide,
 > > Alex Parkinson
 > >
 > > On 5/30/07, Michel Benoit <murpme@gmail.com> wrote:
 > > > Hi Alex,
 > > >
 > > > Here is a copy of the driver that I wrote to test the 9260 i2c
 > > > interface. Its raw but it supports both master and slave mode. I did
 > > > not manage to get the twi hw to work in slave mode on the EK
 > > > development board so we chose to use an external PCA i2c controller
 > > > instead on our hw. I was told that the i2c (twi) controller is buggy
 > > > and cannot be trusted 100% of the time even in master mode.
 > > >
 > > > There are some folks that have been discussing an implementation of
 > > > interrupt based at91 i2c driver on the lm-sensors mailing list. I'm
 > > > not sure what the status of that drive ris but I know that 
someone was
 > > > trying to get the driver into mainline.
 > > >
 > > > Good luck!
 > > >
 > > >
 > > >
 > > >
 > > > On 5/29/07, Alex Parkinson <okalex@gmail.com> wrote:
 > > > > Michel,
 > > > >
 > > > > I've seen on a number of mailing lists that you've worked with 
the I2C
 > > > > driver for the SAM9260 quite a bit. I'm about to dive into the code
 > > > > now, and I just wanted to ask you if you ever managed to get it
 > > > > working. I saw on the lm-sensors mailing list that you modified the
 > > > > driver to be interrupt-based. Has your code made it into the 
mainline
 > > > > kernel? If not, would you mind sharing it with me?
 > > > >
 > > > > Sincerely,
 > > > > Alex Parkinson
 > > > >
 > > >
 > > >
 > >
 >
 >
 >
