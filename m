From: filip.zyzniewski@gmail.com (Filip Zyzniewski)
Date: Wed, 16 Dec 2009 17:51:08 +0100
Subject: USB Host on a SA1111
Message-ID: <de2dcbb80912160851g9def9d0p77e46ba0f572fea4@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

I have found out a way to connect an USB receptacle to USB host pins on
SA1111 inside a HP Jornada 720. The modification is described at
http://jlime.com/mw4/index.php/Hardware_documentation_jornada700_usbhost .

Unfortunately it still doesn't work as expected - I have dumped some dmesgs
here: http://filip.math.uni.lodz.pl/jornada/usb_host/ .
The most interesting ones are these where kernel can retrieve proper
identification numbers (optical mouse, card driver). But communication fails
afterwards. Devices aren't usable.

Things that surprise me in these logs:

[ 1126.593375] sa1111-ohci 0400: OHCI 1.0, NO legacy support registers

I've googled dmesg dumps and usually it says "with legacy support registers".
OHCI 1.0 seems strange (SA1111 is 1.1 compatible), but i've seen that people
have it in their logs.

[ 1127.025533] hub 1-0:1.0: no power switching (usb 1.0)

SA1111 is able to control power switching (and I have implemented the circuitry
doing this with a TPS2043). This probably results from detecting it as
a 1.0 host.



I am posting this in hope that somebody could give me pointers about where
to begin digging to fix this. I think hardware part is ok, because id
numbers ARE somehow transferred. What do you think about it?

regards,
Filip Zyzniewski
