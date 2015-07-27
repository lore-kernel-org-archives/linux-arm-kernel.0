From: hdegoede@redhat.com (Hans de Goede)
Date: Mon, 27 Jul 2015 14:43:20 +0200
Subject: [linux-sunxi] [RFC] ARM: dts: sunxi: Add regulators and
 board-specific operating points for LeMaker BananaPi
In-Reply-To: <20150727120918.191F76C82FB4@dd34104.kasserver.com>
References: <1437960486-2809-1-git-send-email-public_timo.s@silentcreek.de><55B5E6DB.8020009@redhat.com>
 <20150727120918.191F76C82FB4@dd34104.kasserver.com>
Message-ID: <55B62768.6040403@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On 27-07-15 14:09, public_timo.s at silentcreek.de wrote:
> Hi,
>
> Hans de Goede schrieb am 27.07.2015 10:07:
>
>> I've a simular patch here:
>>
>> https://github.com/jwrdegoede/linux-sunxi/commit/6a30b7d5be6012b81e5e1439a444e41c0ac1afc1
>>
>> I did not submit this upstream yet as it is part of a series to enable the otg
>> controller on the bananapi which needs axp-usb-power-supply support for which
>> the actual powersupply driver changes are still pending.
> Oops, I see. Are you planning to submit this for 4.3 or later?

I plan to submit this for 4.3.

>> As you can see other then you adding the cpu operating points are patches are
>> identical, which is good :)
> Yep, that and you chose a slightly higher maximum voltage for the CPU.
>
>> IMHO we should just stick with the standard operating points unless we know
>> that there are stability issues with them (such as e.g. on the A10 OlinuxIno
>> Lime).
> I'd be fine with that as I don't have any stability issues with the lower
> voltages. What about the 1008MHz operating point that I "reintroduced"? It was
> dropped here [1]  because there was no regulator support.

That is in essence an overclocked setting, the max CPU voltage officially is
1.4V, I do not think that we should provide any overclocked settings in the
official dts files. If people really want to overclock they will have to
modify there dts themselves IMHO.

 > Can this be reenabled
> on board level (which means overriding the defaults inherited from
> sun7i-a20.dtsi) or should this be done at SOC level for all boards (which
> means we have to add regulator nodes for all boards in the first place)?

Technically this is possible, but I do not think that it is a good idea.

Regards,

Hans
