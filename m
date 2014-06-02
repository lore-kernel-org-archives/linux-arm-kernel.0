From: lee.jones@linaro.org (Lee Jones)
Date: Mon, 2 Jun 2014 14:26:19 +0100
Subject: [PATCH] i2c: Make I2C ID tables non-mandatory for DT'ed and/or
 ACPI'ed devices
In-Reply-To: <20140602123851.GB2654@katana>
References: <1401452797-29521-1-git-send-email-lee.jones@linaro.org>
 <1401452797-29521-2-git-send-email-lee.jones@linaro.org>
 <20140530123656.GC2742@katana> <20140530133405.GB29731@lee--X1>
 <20140530174800.GA4917@katana> <20140530192516.GA4319@lee--X1>
 <20140531134805.GA3287@katana>
 <CACRpkdZvyfA0aaJe3YuevXfA2pTZLRPZ3mQpitL6qD7=qE0Xyg@mail.gmail.com>
 <20140602123851.GB2654@katana>
Message-ID: <20140602132619.GA4146@lee--X1>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 02 Jun 2014, Wolfram Sang wrote:

> On Mon, Jun 02, 2014 at 02:16:59PM +0200, Linus Walleij wrote:
> > On Sat, May 31, 2014 at 3:48 PM, Wolfram Sang <wsa@the-dreams.de> wrote:
> > >
> > >> Right, I read the function which provides the functionality, but my
> > >> point is; I don't think my patch changes the semantics in a way which
> > >> would adversely affect this option.  If you think that it does, can you
> > >> specify how please?
> > >
> > > Currently, if a driver would be DT only and does not provide a seperate
> > > i2c_device_id table, then the driver is unusable with method 4. I don't
> > > like to have some drivers being capable of it and some not.
> > >
> > >> Does the sysfs method create a i2c_device_id table?  If not, how does
> > >> it probe successfully pre-patch?
> > >
> > > The sysfs method creates a device. Its name is matched against
> > > i2c_device_ids only since it does not have a node pointer for DT to be
> > > matched against.
> > 
> > Is this really so useful on embedded systems?
> 
> Well, this feature is at least nice with embedded:
> 
> ---
> 
> * You are developing a driver on a test board, where you soldered the I2C
>   device yourself.
> 
> ---
> 
> Or during HW bringup, you this or that driver for a device (out-of-tree
> vs. in-kernel), and hey, the RTC even has an EEPROM at another address,
> let's try. Such things are the use cases I have mostly seen and those
> customers liked it.
> 
> The problem is that we are talking about matching against I2C slave
> drivers. I can't see a line between embedded and non-embedded when it
> comes to slaves. They are just slaves and could be on any hardware.
> Keeping the bigger picture in mind, IMO it is cumbersome if some drivers
> support user-space instantiation and some not.
> 
> Though, I wouldn't mind if compatible entries could be passed to the
> 'new_device' file, in addition to i2c_device_ids. Yet, this needs some
> extra handling I haven't found the time for, yet.

Actually, I'm just about to submit a new set.

Hopefully we cover some bases.

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
