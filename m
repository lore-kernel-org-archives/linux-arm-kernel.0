From: public_timo.s@silentcreek.de (Timo Sigurdsson)
Date: Tue, 28 Jul 2015 11:02:09 +0200 (CEST)
Subject: [linux-sunxi] [RFC] ARM: dts: sunxi: Add regulators and
 board-specific operating points for LeMaker BananaPi
In-Reply-To: <55B62768.6040403@redhat.com>
References: <1437960486-2809-1-git-send-email-public_timo.s@silentcreek.de><55B5E6DB.8020009@redhat.com>
 <20150727120918.191F76C82FB4@dd34104.kasserver.com><55B62768.6040403@redhat.com>
Message-ID: <20150728090209.1D7BC6C80542@dd34104.kasserver.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Hans de Goede schrieb am 27.07.2015 14:43:
>>> I've a simular patch here:
>>>
>>> https://github.com/jwrdegoede/linux-sunxi/commit/6a30b7d5be6012b81e5e1439a444e41c0ac1afc1
>>>
>>> I did not submit this upstream yet as it is part of a series to enable the
>>> otg
>>> controller on the bananapi which needs axp-usb-power-supply support for which
>>> the actual powersupply driver changes are still pending.
>> Oops, I see. Are you planning to submit this for 4.3 or later?
> 
> I plan to submit this for 4.3.
Ok, then I guess we can drop my patch.

>>> IMHO we should just stick with the standard operating points unless we know
>>> that there are stability issues with them (such as e.g. on the A10 OlinuxIno
>>> Lime).
>> I'd be fine with that as I don't have any stability issues with the lower
>> voltages. What about the 1008MHz operating point that I "reintroduced"? It was
>> dropped here [1]  because there was no regulator support.
> 
> That is in essence an overclocked setting, the max CPU voltage officially is
> 1.4V, I do not think that we should provide any overclocked settings in the
> official dts files. If people really want to overclock they will have to
> modify there dts themselves IMHO.

Personally, I would be fine with that. Even though I think, it might be good to
have them in the official files just for convenience and because people who are 
used to the sunxi-3.4 kernels are used to having the 1008MHz opp (and it was in
mainline for a short while, too). For those who don't want to use that setting,
it's easier to limit the maximum in userspace compared to compiling a new
device tree blob. But I do understand your point, so I guess it's just
something that maintainers have to make a decision for. As I said, either way
is fine for me.

> > Can this be reenabled
>> on board level (which means overriding the defaults inherited from
>> sun7i-a20.dtsi) or should this be done at SOC level for all boards (which
>> means we have to add regulator nodes for all boards in the first place)?
> 
> Technically this is possible, but I do not think that it is a good idea.

I guess the same applies here, too. It's something maintainers should have a
common understanding on. I don't know how much variation there is among the
A20 boards in terms of frequencies and voltages. If there is a lot, I'd say
it would be desireable to have board-specific opp. The downside I see in my
approach is that it impacts readability of the dts(i) files when settings
are overridden further down the tree.

Thanks and regards,

Timo
