From: satish.patel@ti.com (Patel, Satish)
Date: Tue, 9 Jul 2013 02:23:29 +0000
Subject: [PATCH v9 0/8] Generic PHY Framework
In-Reply-To: <51DAADD1.3060302@ti.com>
References: <1372247257-30186-1-git-send-email-kishon@ti.com>
 <780E789C2E067A4BB8F69D0BB9EC4F253E975B5E@DBDE04.ent.ti.com>
 <51D3F773.9000209@ti.com> <20130703132038.GI15056@arwen.pp.htv.fi>
 <780E789C2E067A4BB8F69D0BB9EC4F253E975D6E@DBDE04.ent.ti.com>
 <51D54694.20203@ti.com> <20130704101216.GD4830@arwen.pp.htv.fi>
 <780E789C2E067A4BB8F69D0BB9EC4F253E9764D5@DBDE04.ent.ti.com>
 <51DAADD1.3060302@ti.com>
Message-ID: <780E789C2E067A4BB8F69D0BB9EC4F253E976575@DBDE04.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

> -----Original Message-----
> From: ABRAHAM, KISHON VIJAY
> Sent: Monday, July 08, 2013 5:47 PM
> To: Patel, Satish
> Cc: Balbi, Felipe; grant.likely at linaro.org; tony at atomide.com;
> arnd at arndb.de; swarren at nvidia.com; sylvester.nawrocki at gmail.com;
> linux-kernel at vger.kernel.org; linux-omap at vger.kernel.org; linux-arm-
> kernel at lists.infradead.org; linux-usb at vger.kernel.org;
> gregkh at linuxfoundation.org; akpm at linux-foundation.org;
> rob.herring at calxeda.com; rob at landley.net; linux at arm.linux.org.uk;
> benoit.cousson at linaro.org; mchehab at redhat.com; cesarb at cesarb.net;
> davem at davemloft.net; Nayak, Rajendra; shawn.guo at linaro.org; Shilimkar,
> Santosh; devicetree-discuss at lists.ozlabs.org; linux-
> doc at vger.kernel.org; Nori, Sekhar; Krishnamoorthy, Balaji T; Cherian,
> George; Mankad, Maulik Ojas; Srinivasan, Nageswari; Sundareson,
> Prabindh
> Subject: Re: [PATCH v9 0/8] Generic PHY Framework
> 
> Hi,
> 
> On Monday 08 July 2013 04:54 PM, Patel, Satish wrote:
> > Hi,
> >
> >
> >> -----Original Message-----
> >> From: Balbi, Felipe
> >> Sent: Thursday, July 04, 2013 3:42 PM
> >> To: ABRAHAM, KISHON VIJAY
> >> Cc: Patel, Satish; Balbi, Felipe; grant.likely at linaro.org;
> >> tony at atomide.com; arnd at arndb.de; swarren at nvidia.com;
> >> sylvester.nawrocki at gmail.com; linux-kernel at vger.kernel.org; linux-
> >> omap at vger.kernel.org; linux-arm-kernel at lists.infradead.org; linux-
> >> usb at vger.kernel.org; gregkh at linuxfoundation.org; akpm at linux-
> >> foundation.org; rob.herring at calxeda.com; rob at landley.net;
> >> linux at arm.linux.org.uk; benoit.cousson at linaro.org;
> mchehab at redhat.com;
> >> cesarb at cesarb.net; davem at davemloft.net; Nayak, Rajendra;
> >> shawn.guo at linaro.org; Shilimkar, Santosh; devicetree-
> >> discuss at lists.ozlabs.org; linux-doc at vger.kernel.org; Nori, Sekhar;
> >> Krishnamoorthy, Balaji T; Cherian, George; Mankad, Maulik Ojas
> >> Subject: Re: [PATCH v9 0/8] Generic PHY Framework
> >>
> >> On Thu, Jul 04, 2013 at 03:25:32PM +0530, Kishon Vijay Abraham I
> >> wrote:
> >>> On Thursday 04 July 2013 02:51 PM, Patel, Satish wrote:
> >>>> Hi,
> >>>>
> >>>>> -----Original Message-----
> >>>>> From: Balbi, Felipe
> >>>>> Sent: Wednesday, July 03, 2013 6:51 PM
> >>>>> To: ABRAHAM, KISHON VIJAY
> >>>>> Cc: Patel, Satish; grant.likely at linaro.org; tony at atomide.com;
> >> Balbi,
> >>>>> Felipe; arnd at arndb.de; swarren at nvidia.com;
> >>>>> sylvester.nawrocki at gmail.com; linux-kernel at vger.kernel.org;
> linux-
> >>>>> omap at vger.kernel.org; linux-arm-kernel at lists.infradead.org;
> linux-
> >>>>> usb at vger.kernel.org; gregkh at linuxfoundation.org; akpm at linux-
> >>>>> foundation.org; rob.herring at calxeda.com; rob at landley.net;
> >>>>> linux at arm.linux.org.uk; benoit.cousson at linaro.org;
> >> mchehab at redhat.com;
> >>>>> cesarb at cesarb.net; davem at davemloft.net; Nayak, Rajendra;
> >>>>> shawn.guo at linaro.org; Shilimkar, Santosh; devicetree-
> >>>>> discuss at lists.ozlabs.org; linux-doc at vger.kernel.org; Nori,
> Sekhar;
> >>>>> Krishnamoorthy, Balaji T; Cherian, George
> >>>>> Subject: Re: [PATCH v9 0/8] Generic PHY Framework
> >>>>>
> >>>>> Hi,
> >>>>>
> >>>>> On Wed, Jul 03, 2013 at 03:35:39PM +0530, Kishon Vijay Abraham I
> >>>>> wrote:
> >>>>>> On Wednesday 03 July 2013 03:02 PM, Patel, Satish wrote:
> >>>>>>> Hi Kishon,
> >>>>>>>
> >>>>>>>> -----Original Message-----
> >>>>>>>> From: ABRAHAM, KISHON VIJAY
> >>>>>>>> Sent: Wednesday, June 26, 2013 5:17 PM
> >>>>>>>> To: grant.likely at linaro.org; tony at atomide.com; Balbi, Felipe;
> >>>>> ABRAHAM,
> >>>>>>>> KISHON VIJAY; arnd at arndb.de; swarren at nvidia.com;
> >>>>>>>> sylvester.nawrocki at gmail.com; linux-kernel at vger.kernel.org;
> >> linux-
> >>>>>>>> omap at vger.kernel.org; linux-arm-kernel at lists.infradead.org;
> >> linux-
> >>>>>>>> usb at vger.kernel.org; gregkh at linuxfoundation.org; akpm at linux-
> >>>>>>>> foundation.org
> >>>>>>>> Cc: rob.herring at calxeda.com; rob at landley.net;
> >>>>> linux at arm.linux.org.uk;
> >>>>>>>> benoit.cousson at linaro.org; mchehab at redhat.com;
> >> cesarb at cesarb.net;
> >>>>>>>> davem at davemloft.net; Nayak, Rajendra; shawn.guo at linaro.org;
> >>>>> Shilimkar,
> >>>>>>>> Santosh; devicetree-discuss at lists.ozlabs.org; linux-
> >>>>>>>> doc at vger.kernel.org; Nori, Sekhar; Krishnamoorthy, Balaji T;
> >>>>> Cherian,
> >>>>>>>> George
> >>>>>>>> Subject: [PATCH v9 0/8] Generic PHY Framework
> >>>>>>>>
> >>>>>>>> Added a generic PHY framework that provides a set of APIs for
> >> the
> >>>>> PHY
> >>>>>>>> drivers
> >>>>>>>> to create/destroy a PHY and APIs for the PHY users to obtain
> a
> >>>>>>>> reference to
> >>>>>>>> the PHY with or without using phandle.
> >>>>>>>>
> >>>>>>>> This framework will be of use only to devices that uses
> >> external
> >>>>> PHY
> >>>>>>>> (PHY
> >>>>>>>> functionality is not embedded within the controller).
> >>>>>>>>
> >>>>>>>> The intention of creating this framework is to bring the phy
> >>>>> drivers
> >>>>>>>> spread
> >>>>>>>> all over the Linux kernel to drivers/phy to increase code re-
> >> use
> >>>>> and
> >>>>>>>> to
> >>>>>>>> increase code maintainability.
> >>>>>>>
> >>>>>>> I would like to use this framework for a smart-card controller
> >>>>> connected to a
> >>>>>>> smart-card phy. I have some questions and would like to get
> >>>>> feedback on the same.
> >>>>>>
> >>>>>> glad to know that :-)
> >>>>>>>
> >>>>>>> I am using ?TDA8026" Smartcard PHY from NXP. Here is the link
> >> for
> >>>>> datasheet
> >>>>>>> and app note for the same. The smart card controller is inside
> >> the
> >>>>> TI SoC
> >>>>>>> I am working with.
> >>>>>>>
> >>>>>>> Datasheet :
> >>>>>>> www.nxp.com/documents/data_sheet/TDA8026.pdf?
> >>>>>>>
> >>>>>>> Appnote :
> >>>>>>> http://www.nxp.com/documents/application_note/AN10724.pdf
> >>>>>>>
> >>>>>>> The TI SoC details are not public (yet). I can provide details
> >> to
> >>>>> you offline.
> >>>>>>>
> >>>>>>> Brief about operation:
> >>>>>>> -	The controller can work with and without a PHY
> >>>>>>> -	When not using PHY, it is limited to talking to a single
> >>>>>>> 	smart card. There is also a need to put external de-
> activation
> >>>>> logic
> >>>>>>> 	on card removal for this case.
> >>>>>>> -	With a PHY you can use more than one smart card.
> >>>>>>> -	Phy has 5 slots :  1 for smart card (credit/debit/other
> >> card
> >>>>> with chip)
> >>>>>>>        and others for SAM ? SIM like modules
> >>>>>>> - 	Once the PHY is initialized, there are some operations
> >> that the
> >>>>> controller
> >>>>>>> 	can request of the PHY like:
> >>>>>>> 	- Card configurations  - set voltage
> >>>>>>> 	- Activation of card
> >>>>>>> 	- ATR ? Answer to reset
> >>>>>>> 	- Warm reset
> >>>>>>> 	- ADPU exchange
> >>>>>>> 	- Deactivation ( Normal/Emergency)
> >>>>>>
> >>>>>> hmm.. We should think about extending the phy_ops to include
> >> these
> >>>>>> operations (something like phy_smart_card_ops so that other
> >>>>>> smart_card PHYs will also be able to use it).
> >>>>>
> >>>>> let's try to avoid use-case specific additions. set_voltage
> sounds
> >>>>> like
> >>>>> a regulator thing, but the regulator is controlled through the
> >> PHY. I
> >>>>> guess it makes sense to have a generic phy_set_voltage() call
> >> since
> >>>>> even
> >>>>> USB can make use of that.
> >>>>>
> >>>>> For card activation, it sounds like phy_init()/phy_shutdown()
> >> would
> >>>>> cover it.
> >>>>>
> >>>>> For warm reset perhaps a phy_reset() callback ? Although that
> >> could,
> >>>>> easily, get abused.
> >>>>>
> >>>>> For deactivation, that's phy_shutdown().
> >>>>>
> >>>>> ATR and ADPU needs more thought, I guess.
> >>>>>
> >>>>>>> - 	In the mode when smartcard controller talks directly to
> >> the
> >>>>> card without the need
> >>>>>>> 	for a PHY, all the above operations will be carried out
> by the
> >>>>> controller itself
> >>>>>>>
> >>>>>>> My current thought process is to make the controller driver
> >> provide
> >>>>> the user interface
> >>>>>>> and talk to the PHY using the generic PHY framework you
> >> proposed.
> >>>>> In the case where there
> >>>>>>> is no PHY, my idea is to create a "dummy" PHY which uses the
> >>>>> controller functionality itself.
> >>>>>>
> >>>>>> right. And in the case where you actually have a PHY, create a
> >> PHY
> >>>>>> driver and implement the phy_smart_card_ops and register with
> the
> >>>>> PHY
> >>>>>> framework.
> >>>>>
> >>>>> I would try to avoid that. Otherwise we will have phy_usb_ops,
> >>>>> phy_sata_ops, phy_network_ops, phy_pci_ops, etc etc etc. It
> would
> >>>>> easily
> >>>>> blow up.
> >>>>>
> >>>>
> >>>> - I do agree with you. Creating Phy specific ops will blow up
> whole
> >>>>    concept of generic phy f/w.
> >>>> - Can we have interface like phy_setconfig - with parameter like
> >>>>    phy_setconfig(int param, void *value)
> >>>> 	- Here param can be enum of available config parameters for
> >>>> 	  specific phy.
> >>>> Phy can perform different operation/set internal state based on
> >>>> param selection and value passed by.
> >>>>
> >>>> e.x in case of smartcard
> >>>> 	enum set_config {
> >>>> 		SET_VOLATAGE,
> >>>> 		SET_ACTIVATE,
> >>>> 		SET_WARMRESET,
> >>>> 		SET_ATR,
> >>>> 		SET_DEACTIVE,
> >>>> 		....
> >>>> 	};
> >>>
> >>> hmm.. this looks similar to ioctl and can be abused easily IMO :s
> >>
> >> +1
> >>
> >> What we need is to come up with generic ways to model those, if we
> >> need
> >> set voltage, then add a phy_set_voltage() kinda thing, perhaps add
> >> capability flags to enable/disable support fort those (just like
> mmc
> >> does).
> >>
> >> But adding something which can handle "anything" like
> >> phy_set_config(),
> >> it's the same as adding use-case specific ops.
> >>
> >
> > We have two options over here
> >
> > Option 1:
> >
> > Defining generic api to which can be mapped over multiple phys
> > For smartcard case, I have can thought of following mapping with new
> > generic apis as suggested.
> >
> > Smartcard_poweron -> power_on
> > Smartcard_powerdown -> power_off
> > Smartcard_set_voltage -> phy_set_voltage
> > Smartcard_activate_card -> phy_activate_slot
> > Smartcard_deactivate_card -> phy_deactivate_slot
> 
> how is activate/deactivate different from poweron/poweroff in this
> use case?

power on/off normal power sequence. While activate/de-activate will be 
called during card transaction.

Brief on how it works:
- when system start, execute power on for phy
- smartcard controller and phy is connected through i2c, clock lines and 
i/o lines
- clock will be supplied by controller to phy to get data sync on i/o lines

Operation:
 
Once the card gets inserted into the slot, user application can initiate
activate sequence anytime, it is not mandatory that activation has to be called
Immediately. It all depends whether other connections ( network, printer) are proper.
User application can do some checks and then dynamically activate the card

There are 2 sequence of activation - normal activation and warm reset. If first
fails then warm reset should be executed, if card does not response to both then
deactivation will be carried out

- For activation there are some timing parameters ( called ATR - Answer to reset timings)
Has to be set to the phy

- on activation card will respond with some initial characters (ATR), which will be verified
by application, in case of error user application will de-activate the card not the phy module

- After activation, use application initiate normal tx/rx

- Once tx/rx is done, it will initiate deactivation of card not the phy module.


> > Smartcard_set_c4/c8/rst/io -> phy_set_pin
> 
> Whats should be exactly done here? Looks to me like it should be
> part of init. Does these pin settings need to be changed dynamically?

These are all phy pins which will be physically come in contact with smart card 
When inserted. In case of synchronous card, these pins will be toggled manually
by s/w bit bang algorithm


> > Smartcard_warm_reset -> phy_warmreset
>
Explained above.
 
> Again looks to me like it should be part of init.
> > Smartcard_set_clkdiv -> phy_set_clock
> > Smartcard_get_clkdiv -> phy_get_clock
> 
> Why would the smartcard give clock to the PHY? Shouldn't the driver
> of the PHY driver be doing that by itself?
> 
Source of clock to the  phy is from smart card controller

> > Smartcard_set_atr_mute_timeout -> ??
> > Smartcard_set_atr_early_timeout -> ??
> > Smartcard_get_isr_status -> phy_get_status
> 

ATR timeout parameter has to be configured for activation. This will
differ for various smart card segments.

> Why? Is it like the detection of an external event? Then the PHY
> driver should use *extcon* for event detection and passing.
>

Smartcard controller need a way to ready isr status ( like card presence,
Card inserted in to which slot, removed from which slot ) to maintain its
Internal state machine.
 
> > Smartcard_get_version -> phy_get_version
> 
> Again why? Why would the smartcard need the version of the PHY?
> 

Can be omitted. This is for the test suite reference.
> Thanks
> Kishon
