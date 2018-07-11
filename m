From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 11 Jul 2018 21:10:21 +0200
Subject: [PATCH net-next 5/5 v2] net: gemini: Indicate that we can handle
 jumboframes
In-Reply-To: <20180704203556.GC23469@lunn.ch>
References: <20180704183324.10605-1-linus.walleij@linaro.org>
 <20180704183324.10605-5-linus.walleij@linaro.org>
 <20180704203556.GC23469@lunn.ch>
Message-ID: <CACRpkdbaPqqGEag94k5AnMJ8Bq7cjfET_gQsEfoxM=72_U34yg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 4, 2018 at 10:35 PM Andrew Lunn <andrew@lunn.ch> wrote:
>
> On Wed, Jul 04, 2018 at 08:33:24PM +0200, Linus Walleij wrote:
> > The hardware supposedly handles frames up to 10236 bytes and
> > implements .ndo_change_mtu() so accept 10236 minus the ethernet
> > header for a VLAN tagged frame on the netdevices. Use
> > ETH_MIN_MTU as minimum MTU.
> >
> > Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
>
> Hi Linus
>
> Did you try with an MTU of 68? Maybe the vendor picked 256 because of
> a hardware limit?

Yeah works fine:

ping -s 68 169.254.1.2
PING 169.254.1.2 (169.254.1.2) 68(96) bytes of data.
76 bytes from 169.254.1.2: icmp_seq=1 ttl=64 time=0.359 ms
76 bytes from 169.254.1.2: icmp_seq=2 ttl=64 time=0.346 ms
76 bytes from 169.254.1.2: icmp_seq=3 ttl=64 time=0.351 ms

This also works fine:

ping -s 9000 169.254.1.2
PING 169.254.1.2 (169.254.1.2) 9000(9028) bytes of data.
9008 bytes from 169.254.1.2: icmp_seq=1 ttl=64 time=1.45 ms
9008 bytes from 169.254.1.2: icmp_seq=2 ttl=64 time=1.68 ms
9008 bytes from 169.254.1.2: icmp_seq=3 ttl=64 time=1.55 ms

I'll send new patches with all suggested changes soon :)

Thanks a lot for your help!

Yours,
Linus Walleij
