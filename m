From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Wed, 16 Jan 2013 20:37:13 +0100
Subject: [PATCH 5/6] arm: mvebu: Enable USB controllers on Armada XP
 OpenBlocks AX3-4 board
In-Reply-To: <CALF0-+XKGk+ru3VZ6815KTu_Aj_daYafr+Y5WJ9dXUoFqbTHOQ@mail.gmail.com>
References: <1358243670-11935-1-git-send-email-ezequiel.garcia@free-electrons.com>
 <1358243670-11935-5-git-send-email-ezequiel.garcia@free-electrons.com>
 <CABMQnVLD+VKj53dfQC24AwCboed3EGt+gqTKt-B9q8nhEx3Ytg@mail.gmail.com>
 <CALF0-+XKGk+ru3VZ6815KTu_Aj_daYafr+Y5WJ9dXUoFqbTHOQ@mail.gmail.com>
Message-ID: <20130116203713.7b396070@skate>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Ezequiel Garcia,

On Wed, 16 Jan 2013 16:16:59 -0300, Ezequiel Garcia wrote:

> >> +               usb at d0050000 {
> >> +                       status = "okay";
> >> +               };
> >> +               usb at d0051000 {
> >> +                       status = "okay";
> >> +               };
> >> +               usb at d0052000 {
> >> +                       status = "okay";
> >> +               };
> > USB2 of openblocks-ax3-4 is used as Mini-PCIE.
> > I think this is unnecessary.
> 
> Mmm... could you explain this with some more detail.
> Unfortunately, I don't have access to an Openblocks board to check on
> this, so I'd appreciate any clarification.
> 
> Is there any Openblocks datasheet or hardware schematics publicly
> available for me to look at?

As far as I know, there is no public document. I've been given access
to a PDF, in Japanese, that gives some details about the hardware.

>From what I can read, only 2 USB ports are used from the internal
Marvell EHCI controller.

Another USB port is available, but it is connected to a USB controller
that sits on the PCIe bus. And the PCIe interface on which this USB
controller is connected is not enabled in the default U-Boot shipped
with AX3-4 (at least not with the generation I have). I've been given
an U-Boot version that is supposed to enable this PCIe interface, but I
haven't tested yet.

Anyway, from a Marvell EHCI controller perspective, only two ports are
used, as Nobuhiro said. I am not sure which ports, but it seems like
the first two ones were used. One of the two physical ports is a
combined USB / eSATA port, but I don't think this makes any difference
at the software level.

I don't have the OpenBlocks AX3-4 with me right now, but I could
probably make a test on Friday.

Best regards,

Thomas
-- 
Thomas Petazzoni, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
