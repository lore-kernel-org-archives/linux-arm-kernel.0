From: arnd@arndb.de (Arnd Bergmann)
Date: Sun, 5 Jan 2014 19:11:12 +0100
Subject: [PATCH V2 0/4] misc: xgene: Add support for APM X-Gene SoC Queue
 Manager/Traffic Manager
In-Reply-To: <CAN1v_PtFz42crHW5=cUgw-fAnPn3rQht=o0t3nmjJRamYSLDMg@mail.gmail.com>
References: <1387594651-25771-1-git-send-email-rapatel@apm.com>
 <1441245.xPZLG2iNZ6@wuerfel>
 <CAN1v_PtFz42crHW5=cUgw-fAnPn3rQht=o0t3nmjJRamYSLDMg@mail.gmail.com>
Message-ID: <201401051911.12349.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sunday 05 January 2014, Ravi Patel wrote:
> On Sat, Dec 21, 2013 at 11:03 PM, Arnd Bergmann <arnd@arndb.de> wrote:
> > On Saturday 21 December 2013 17:00:51 Loc Ho wrote:
> >> On Sat, Dec 21, 2013 at 12:11 PM, Arnd Bergmann <arnd@arndb.de> wrote:
> >
> > Please describe here what the purpose of the qmtm is, as this is not
> > entirely clear from the code or from your reply.
> >
> > Greg was guessing that it's a bus controller, my best guess is a DMA
> > engine. If it's something completely different, you have to let
> > us know what it is so we can do a proper review rather than guessing.
> >
> > Please provide a link to the data sheet if you are unable to explain.
> 
> Here is URL to a text document explaining role of QMTM device with CPU, Ethernet
> subsystem.
> 
> https://drive.google.com/file/d/0B28TgQZ3JLoRRGNnbjJoUGNHWW8/edit?usp=sharing
> 
> For simplicity, I have shown only Ethernet.
> PktDMA and Security subsystem interfaces with QMTM in the same way as Ethernet.
> 

Thanks, that helps a lot. Please add this file to an appropriate place
in the Documentation directory in the next version of your patches.

There is still one central aspect that remains unclear to me, which is
what the QMTM is actually good for, as opposed to how it gets used from
the OS. In the text description, it sounds like the ethernet is the DMA
master and performs DMA all by itself but from that it's not clear why
a message to and from the QMTM is needed. From your drawing on the other
hand, it seems like the QMTM is really the DMA master and performs the
DMA on behalf of the ethernet device, which isn't connected to the
coherent interface itself. If this is correct, it seems that QMTM is more
like a DMA engine after all that should use the existing slave API to
provide services to slave drivers.

	Arnd
