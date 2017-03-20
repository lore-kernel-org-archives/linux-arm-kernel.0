From: wens@csie.org (Chen-Yu Tsai)
Date: Mon, 20 Mar 2017 16:32:45 +0800
Subject: [PATCH] ARM: dts: sun7i: lamobo-r1: Fix CPU port RGMII settings
In-Reply-To: <20170320082956.sa2bwsoapp23srto@lukather>
References: <20170319045321.6454-1-f.fainelli@gmail.com>
 <20170320082956.sa2bwsoapp23srto@lukather>
Message-ID: <CAGb2v65m8JszJWjJs+ja66RVXeHpytSKNX61D2vf1Yp=kWCWFA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Mon, Mar 20, 2017 at 4:29 PM, Maxime Ripard
<maxime.ripard@free-electrons.com> wrote:
> Hi Florian,
>
> On Sat, Mar 18, 2017 at 09:53:20PM -0700, Florian Fainelli wrote:
>> The CPU port of the BCM53125 is configured with RGMII (no delays) but
>> this should actually be RGMII with transmit delay (rgmii-txid) because
>> STMMAC takes care of inserting the transmitter delay. This fixes
>> occasional packet loss encountered.
>>
>> Fixes: d7b9eaff5f0c ("ARM: dts: sun7i: Add BCM53125 switch nodes to the lamobo-r1 board")
>> Reported-by: Hartmut Knaack <knaack.h@gmx.de>
>> Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
>
> Applied, thanks!
> Maxime

I'm not sure dwmac-sunxi supports "rgmii-txid" though.
At least I don't remember implementing it.

ChenYu
