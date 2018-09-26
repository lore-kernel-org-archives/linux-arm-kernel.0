From: starnight@g.ncu.edu.tw (Jian-Hong Pan)
Date: Wed, 26 Sep 2018 23:52:50 +0800
Subject: [RFC 1/3 net] lorawan: Add LoRaWAN class module
In-Reply-To: <cebcea44-9db3-5564-574c-038d9af79995@suse.de>
References: <cover.1535039998.git.starnight@g.ncu.edu.tw>
 <fc737f3940bbe91341fb15d85ac11931eb56d1fc.1535039998.git.starnight@g.ncu.edu.tw>
 <cebcea44-9db3-5564-574c-038d9af79995@suse.de>
Message-ID: <CAC=mGzjFHJi1VHKCXa-dM5XBsbXo_s1QqpPdbLF0+3BdhVMR2Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Andreas F?rber <afaerber@suse.de> ? 2018?9?24? ?? ??12:40???
>
> Hi Jian-Hong,
>
> [+ Afonso]
>
> Am 23.08.18 um 19:15 schrieb Jian-Hong Pan:
> > LoRaWAN defined by LoRa Alliance(TM) is the MAC layer over LoRa devices.
> >
> > This patch implements part of Class A end-devices features defined in
> > LoRaWAN(TM) Specification Ver. 1.0.2:
> > 1. End-device receive slot timing
> > 2. Only single channel and single data rate for now
> > 3. Unconfirmed data up/down message types
> > 4. Encryption/decryption for up/down link data messages
> >
> > It also implements the the functions and maps to Datagram socket for
> > LoRaWAN unconfirmed data messages.
> >
> > On the other side, it defines the basic interface and operation
> > functions for compatible LoRa device drivers.
> >
> > Signed-off-by: Jian-Hong Pan <starnight@g.ncu.edu.tw>
> > ---
> >  include/linux/maclorawan/lora.h | 239 +++++++++++
> >  net/maclorawan/Kconfig          |  14 +
> >  net/maclorawan/Makefile         |   2 +
> >  net/maclorawan/lorawan.h        | 219 ++++++++++
> >  net/maclorawan/lrwsec.c         | 237 +++++++++++
> >  net/maclorawan/lrwsec.h         |  57 +++
> >  net/maclorawan/mac.c            | 552 +++++++++++++++++++++++++
> >  net/maclorawan/main.c           | 665 ++++++++++++++++++++++++++++++
> >  net/maclorawan/socket.c         | 700 ++++++++++++++++++++++++++++++++
> >  9 files changed, 2685 insertions(+)
> >  create mode 100644 include/linux/maclorawan/lora.h
>
> Can we use include/linux/lora/lorawan.h for simplicity?

Technically, yes

> >  create mode 100644 net/maclorawan/Kconfig
> >  create mode 100644 net/maclorawan/Makefile
> >  create mode 100644 net/maclorawan/lorawan.h
> >  create mode 100644 net/maclorawan/lrwsec.c
> >  create mode 100644 net/maclorawan/lrwsec.h
> >  create mode 100644 net/maclorawan/mac.c
> >  create mode 100644 net/maclorawan/main.c
> >  create mode 100644 net/maclorawan/socket.c
>
> This patch is much too large for me to review...
>
> It also doesn't seem to follow the structure I suggested: 802.15.4 has
> two separate directories, net/ieee802154/ and net/mac802154/. Therefore
> I had suggested net/maclorawan/ only for code that translates from
> ETH_P_LORAWAN to ETH_P_LORA socket buffers, i.e. your soft MAC. Generic
> socket code that applies also to hard MAC drivers I expected to go
> either to net/lora/lorawan/ or better net/lorawan/ or some other clearly
> separate location, with its own Kconfig symbol - any reason not to?
> Consider which parts can be enabled/used independently of each other,
> then you can put them into two (or more?) different patches.

Maybe I misunderstood before.  Besides, the header files need to be
split for different paths or folders.
Anyway, I will try to separate it into parts in version 2 patches.

> Also please use SPDX license identifiers in your headers.
> And please don't put the whole world in To, use CC.

Regards,
Jian-Hong Pan
