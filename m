From: rapatel@apm.com (Ravi Patel)
Date: Sat, 4 Jan 2014 15:59:46 -0800
Subject: [PATCH V2 0/4] misc: xgene: Add support for APM X-Gene SoC Queue
 Manager/Traffic Manager
In-Reply-To: <1441245.xPZLG2iNZ6@wuerfel>
References: <1387594651-25771-1-git-send-email-rapatel@apm.com>
 <201312212111.40576.arnd@arndb.de>
 <CAPw-ZTnsu_EmOW3aZTVKAVjQsdi8qMy95y2ZcYxzgVrjGkirTA@mail.gmail.com>
 <1441245.xPZLG2iNZ6@wuerfel>
Message-ID: <CAN1v_PtFz42crHW5=cUgw-fAnPn3rQht=o0t3nmjJRamYSLDMg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Dec 21, 2013 at 11:03 PM, Arnd Bergmann <arnd@arndb.de> wrote:
> On Saturday 21 December 2013 17:00:51 Loc Ho wrote:
>> On Sat, Dec 21, 2013 at 12:11 PM, Arnd Bergmann <arnd@arndb.de> wrote:
>> > On Saturday 21 December 2013, Ravi Patel wrote:
>> >> This patch adds support for APM X-Gene SoC Queue Manager/Traffic Manager.
>> >>  QMTM is required by APM X-Gene SoC Ethernet, PktDMA (XOR Engine) and
>> >>  Security Engine subsystems. All subsystems communicate with QMTM using
>> >>  messages which include information about the work to be performed and
>> >>  the location of associated data buffers.
>> >
>> > Please describe here what the purpose of the qmtm is, as this is not
>> > entirely clear from the code.
>> >
>> > In particular, please describe how this differs from a dmaengine driver
>> > and why it is not possible to extend the dma slave API to describe qmtm
>> > as a dma engine.
>> >
>> [Loc Ho]
>> If the QM driver implements the DMA API, what about the actual DMA
>> engine driver which interfaces with this QM driver. We would have DMA
>> client interfaces with the X-Gene DMA driver (not available yet) via
>> DMA API which in turn interfaces with this QM driver via DMA API.
>> Won't this be kind of awkward? Also, the QM only manage messages (or
>> descriptors) which are 32-bytes or 64-bytes. It doesn't actually do
>> any data transfer of various sizes.
>
> Please describe here what the purpose of the qmtm is, as this is not
> entirely clear from the code or from your reply.
>
> Greg was guessing that it's a bus controller, my best guess is a DMA
> engine. If it's something completely different, you have to let
> us know what it is so we can do a proper review rather than guessing.
>
> Please provide a link to the data sheet if you are unable to explain.

Here is URL to a text document explaining role of QMTM device with CPU, Ethernet
subsystem.

https://drive.google.com/file/d/0B28TgQZ3JLoRRGNnbjJoUGNHWW8/edit?usp=sharing

For simplicity, I have shown only Ethernet.
PktDMA and Security subsystem interfaces with QMTM in the same way as Ethernet.
