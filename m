From: sean.wang@mediatek.com (Sean Wang)
Date: Thu, 19 Jul 2018 00:56:04 +0800
Subject: [SPAM]Re: [PATCH v5 5/7] Bluetooth: Extend btuart driver for
 join more vendor devices
In-Reply-To: <1531923968.8953.197.camel@mtkswgap22>
References: <cover.1531150733.git.sean.wang@mediatek.com>
 <85d449cdd34bf47d72935a821915e825c64a2145.1531150733.git.sean.wang@mediatek.com>
 <70616B99-5A2D-417A-8815-246700EEF4E2@holtmann.org>
 <1531641134.3955.19.camel@mtkswgap22>
 <6476BE78-3FE5-465F-8060-2215387323AA@holtmann.org>
 <1531754965.8953.3.camel@mtkswgap22>
 <BB53539F-C053-4DCD-A748-B75B995E1179@holtmann.org>
 <1531923968.8953.197.camel@mtkswgap22>
Message-ID: <1531932964.8953.201.camel@mtkswgap22>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 2018-07-18 at 22:26 +0800, Sean Wang wrote:
> On Wed, 2018-07-18 at 14:23 +0200, Marcel Holtmann wrote:
> > Hi Sean,
> > 

[ ... ]

> > > Because the extra header doesn't provide any details about this stream and each radio stack still needs to be in charge of their stream
> > > parsing. That is why I still want to use recv_h4.h instead of coding my own parser.
> > 
> > As I said above, if the header + length always indicates a full H:4 frame, then you do not need h4_recv.h since you know the packet size. If it doesn't (and it means things can fragment), then you do.
> > 
> 
> My case is the extra header + length doesn't indicate a full H:4 frame,
> things can fragment
> 
> > However I have to note that a serial stream from your multiplexer protocol also needs some state handling since it can be interrupted at any point. If you want this clean, then you actually do that anyway. Essentially you have two protocols layered and want to process the independently.
> 
> Yes, I also agree that it makes better and cleaner if there is another
> driver in charge of the multiplexer protocol and the framing.
> 
> But, could you accept that I postpone the target into the next stage,
> I just like to consider BT single device, not for multiplexer protocol
> case, in the current stage.
> 
> To be honest, my next step is to add mt7688 btusb and then want to have
> an integration with btmtkuart. mt7688 btusb doesn't have extra framing

something needs to be fixed, I mean mt7668 instead of mt7688

> for multiplexer protocol, so it can allow me to make the concentration
> more on pure bt protocol and pushing the latest mtk bluetooth devices
> being supported on the bluez driver.
> 
> > If you post details about the multiplexing protocol for your serial stream, then I can help you design a driver for it. With serdev that is actually simple. And then you could hook up GPS etc. at some point once you want to run this on hardware that has the combo chip.
> > 
> 
> okay, really thanks for your help. I also have an interest on this part.
> now how does bluez receive and sent packet from/to a virtual device ( a
> serdev handling multiplexer protocol)? It seems current bluez device all
> handling packet from/to physical bus device. or I was missing something?
> 
> > Having a Linux Bluetooth driver is useful for Android as well btw. We have HCI_CHANNEL_USER and a generic Android driver for using it. So enabling the chip in Linux upstream will enable it for Android as well.
> > 
> it really save more time as I knew many vendors do two driver separately
> for bluez and bluedroid. where could I find the resource for
> HCI_CHANNEL_USER and generic android driver ? Is it still the part of
> bluez or run by another project ?
> 
> > Regards
> > 
> > Marcel
> > 
> 
> 
> 
> _______________________________________________
> Linux-mediatek mailing list
> Linux-mediatek at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-mediatek
