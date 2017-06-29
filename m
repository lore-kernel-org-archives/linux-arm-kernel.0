From: icenowy@aosc.io (icenowy at aosc.io)
Date: Fri, 30 Jun 2017 00:46:30 +0800
Subject: [linux-sunxi] Re: [PATCH 1/6] net: stmmac: support future
 possible different internal phy mode
In-Reply-To: <20170629.122349.2265868886957558079.davem@davemloft.net>
References: <20170627092806.28181-1-clabbe.montjoie@gmail.com>
 <20170629.122349.2265868886957558079.davem@davemloft.net>
Message-ID: <9f1992d1cab37e5f309c6260985ce32a@aosc.io>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

? 2017-06-30 00:23?David Miller ???
> From: Corentin Labbe <clabbe.montjoie@gmail.com>
> Date: Tue, 27 Jun 2017 11:28:01 +0200
> 
>> The current way to find if the phy is internal is to compare DT 
>> phy-mode
>> and emac_variant/internal_phy.
>> But it will negate a possible future SoC where an external PHY use the
>> same phy mode than the internal one.
>> 
>> By using phy-mode = "internal" we permit to have an external PHY with
>> the same mode than the internal one.
>> 
>> Reported-by: Andr? Przywara <andre.przywara@arm.com>
>> Signed-off-by: Corentin Labbe <clabbe.montjoie@gmail.com>
> 
> Series applied.

I think there's still some problems around for this patchset...
The definition of "internal" is internal *proprietary* PHY, but the
internal PHY of Allwinner SoCs seem to be MII...

See [1].

[1] 
http://lists.infradead.org/pipermail/linux-arm-kernel/2017-June/516159.html

> 
> Please provide a proper "[PATCH 0/n] " header posting next time.
