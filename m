From: aisheng.dong@nxp.com (A.s. Dong)
Date: Fri, 24 Aug 2018 09:51:47 +0000
Subject: [PATCH V5 1/5] dt-bindings: arm: fsl: add scu binding doc
In-Reply-To: <CABb+yY1+J+=nV2gNN30KLr2YQDy_g81-dJS1DJq8NgUv7Qqcog@mail.gmail.com>
References: <1534781305-4770-1-git-send-email-aisheng.dong@nxp.com>
 <1534781305-4770-2-git-send-email-aisheng.dong@nxp.com>
 <20180820181155.GA13901@bogus>
 <AM0PR04MB4211B9113831B292110C709280310@AM0PR04MB4211.eurprd04.prod.outlook.com>
 <CABb+yY1+J+=nV2gNN30KLr2YQDy_g81-dJS1DJq8NgUv7Qqcog@mail.gmail.com>
Message-ID: <AM0PR04MB4211D1CB3DE05AF148E94AAD80360@AM0PR04MB4211.eurprd04.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> -----Original Message-----
> From: Jassi Brar [mailto:jassisinghbrar at gmail.com]
> On Tue, Aug 21, 2018 at 8:30 AM A.s. Dong <aisheng.dong@nxp.com> wrote:
> >
> > > > +
> > > > +The System Controller Firmware (SCFW) is a low-level system
> > > > +function which runs on a dedicated Cortex-M core to provide
> > > > +power, clock, and resource management. It exists on some i.MX8
> > > > +processors. e.g. i.MX8QM (QM, QP), and i.MX8QX (QXP, DX).
> > > > +
> > > > +The AP communicates with the SC using a multi-ported MU module
> > > > +found in the LSIO subsystem. The current definition of this MU
> > > > +module provides
> > > > +5 remote AP connections to the SC to support up to 5 execution
> > > > +environments (TZ, HV, standard Linux, etc.). The SC side of this
> > > > +MU module interfaces with the LSIO DSC IP bus. The SC firmware
> > > > +will communicate with this MU using the MSI bus.
> > >
> > > How are 5 users supported with only 4 channels defined below?
> >
> > There're 5 MU instances designed to be specifically communicate with
> > SCU Firmware on MX8 hardware.
> >
> This is correct.
> 
> > With the new generic mu binding [1], each MU instance is abstracted
> > Into 16 virtual MU channels. (4 Tx, 4 Rx, 4 Tx doorbell, 4 Rx doorbell).
> > (MU has 4 pair of Tx/Rx data register which can be used to
> > send/receive multi words. With new binding, each data register is
> > abstracted into one MU channel, totally 8 channels for data transfer).
> >
> > SCU protocol is already designed to uses all data registers to
> > send/receive multi words according to MU hardware reference manual. So
> > it must use all channels in one MU instances with new binding.
> >
> FYI, this is incorrect.
> The 16 channels are physical and not virtual. In fact, all this is to avoid virtual
> channels.
> The physical resources required by new bindings are exactly the same as by old
> bindings. Now you use 8 physical channels instead of 1 virtual.

Okay, got it.
I'm fine to refer to them all as physical channels.
Thanks

Regards
Dong Aisheng
