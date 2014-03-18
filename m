From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Tue, 18 Mar 2014 11:15:54 +0100
Subject: [PATCH v2 3/8] input: misc: Add driver for AXP20x Power Enable Key
In-Reply-To: <20140318095002.GM25478@lee--X1>
References: <1394898225-28452-1-git-send-email-carlo@caione.org>
 <1394898225-28452-4-git-send-email-carlo@caione.org>
 <20140318090013.GU27873@lukather> <20140318095002.GM25478@lee--X1>
Message-ID: <20140318101554.GZ27873@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Mar 18, 2014 at 09:50:02AM +0000, Lee Jones wrote:
> > > This patch add support for the Power Enable Key found on MFD AXP202 and
> > > AXP209. Besides the basic support for the button, the driver adds two
> > > entries in sysfs to configure the time delay for power on/off.
> > > 
> > > Signed-off-by: Carlo Caione <carlo@caione.org>
> > > ---
> > >  drivers/input/misc/Kconfig      |  11 ++
> > >  drivers/input/misc/Makefile     |   1 +
> > >  drivers/input/misc/axp20x-pek.c | 267 ++++++++++++++++++++++++++++++++++++++++
> > >  3 files changed, 279 insertions(+)
> > >  create mode 100644 drivers/input/misc/axp20x-pek.c
> > 
> > From what I understood of the MFD framework, you usually have a MFD
> > core driver that gets loaded from the DT and instantiate its various
> > functions through sub-devices, that are registered through
> > mfd_add_devices, and the drivers for these sub-devices are supported
> > in sub-drivers that are located in the driver/mfd, alongside the core
> > driver.
> > 
> > I believe that such a pattern allows for two interesting things:
> >   - You don't have to search around the whole kernel tree to find
> >     where a given sub-feature is supported.
> >   - You don't have to cripple your DT with instantiation of all the
> >     subcomponents, while you only really have one device.
> > 
> > Do you have a reason for not following this pattern?
> 
> Sorry Maxime, this is not the case.
> 
> If an MFD contains Regulators and USB & GPIO Controllers, I'd expect
> to see the device represented in the following way:
> 
>   drivers/mfd/<id>.c
>   drivers/{gpio,pinctrl}/{gpio,pinctrl}-<id>.c
>   drivers/regulator/<id>-regulator.c
>   drivers/usb/host/<id>.c

Oh, ok. Nevermind then :)

Just out of curiosity, some drivers at least seem to follow that trend
in drivers/mfd, is there any reason for this (other than historical) ?

Thanks,
Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140318/f84d8126/attachment.sig>
