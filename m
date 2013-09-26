From: sergei.shtylyov@cogentembedded.com (Sergei Shtylyov)
Date: Thu, 26 Sep 2013 22:28:31 +0400
Subject: [PATCH] ARM: shmobile: Lager: add Micrel KSZ8041 PHY fixup
In-Reply-To: <CANqRtoTiHQ3EVDZ8POCkyN2ga95rF=u5ERfYsdZbX+toqAWmaQ@mail.gmail.com>
References: <201309140429.23474.sergei.shtylyov@cogentembedded.com>
 <CANqRtoTiHQ3EVDZ8POCkyN2ga95rF=u5ERfYsdZbX+toqAWmaQ@mail.gmail.com>
Message-ID: <52447CCF.8000301@cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello.

On 09/26/2013 10:50 AM, Magnus Damm wrote:

>> Currently on the Lager board NFS timeouts/delays are seen when booting.  That
>> turned out to happen because the SoC's ETH_LINK signal turns on and off after
>> each packet.  It is connected to Micrel KSZ8041 PHY's LED0 signal. Ether LEDs
>> on the Lager board are named LINK and ACTIVE which corresponds to non-default
>> 01 setting of the PHY control register 1 bits 14-15. The 'sh_eth' driver resets
>> the PHY when opening the network device, so we have to set the mentioned bits
>> back to 01 from the default 00 value which causes bouncing of ETH_LINK.  That
>> can be achieved using the PHY platform fixup mechanism if we also modify the
>> driver to use it..

>> Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

> Hi Sergei,

> Thanks for your efforts on this. Nice to see that Ethernet for Lager
> board support is improving.

> Can you please share with us with link speeds you tested? I suspect

    100 Mbit/s, full duplex.

> that this patch is only needed for some case, like for instance 100
> MBit Full Duplex.

    Hm, why? :-O

> Fixing the PHY settings makes sense even though only
> a single mode needs it, but knowing which link speeds that are known
> to work would help a lot.

    This patch should not depend on the link speed and duplex settings.

> Cheers,

> / magnus

WBR, Sergei
