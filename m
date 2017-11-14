From: sergei.shtylyov@cogentembedded.com (Sergei Shtylyov)
Date: Tue, 14 Nov 2017 21:00:21 +0300
Subject: [PATCH 3/3] arm64: dts: renesas: eagle: add EtherAVB pins
In-Reply-To: <CAMuHMdWCj=CjA_zyC1GKr=KEk2CNMAtwvREw25R1uJktZucY4w@mail.gmail.com>
References: <20171110200714.406365231@cogentembedded.com>
 <CAMuHMdWCj=CjA_zyC1GKr=KEk2CNMAtwvREw25R1uJktZucY4w@mail.gmail.com>
Message-ID: <1017d8fb-e353-f212-09a9-a28bf07eddc2@cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello.

On 11/14/2017 11:44 AM, Geert Uytterhoeven wrote:

>> Add the (previously omitted) EtherAVB pin data to the Eagle board's
>> device tree.
>>
>> Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
> 
> Thanks for your patch!
> 
>> --- renesas.orig/arch/arm64/boot/dts/renesas/r8a77970-eagle.dts
>> +++ renesas/arch/arm64/boot/dts/renesas/r8a77970-eagle.dts
>> @@ -34,6 +34,9 @@
[...]
>> @@ -53,6 +56,11 @@
>>   };
>>
>>   &pfc {
>> +       avb_pins: avb {
>> +               groups = "avb0_mdio", "avb0_mii";
> 
> Oh no, its'called "avb0_mdio" here, but "avb(0)_mdc" on all other
> R-Car Gen3 SoCs?

    Can you remember the reason? I don;t want to follow the bad example. :-)

> What about "avb0_link", which is connected through "L_LNK"?

    The same as for other gen3 board, the AVB node has renesas,no-ether-link".
I tried to verify that property on Eagle, and left it intact as a result... 
Will re-test removing it once more.

[...]

> Gr{oetje,eeting}s,
> 
>                          Geert

MBR, Sergei
