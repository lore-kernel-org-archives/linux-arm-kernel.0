From: marek.belisko@gmail.com (Belisko Marek)
Date: Sat, 26 Sep 2015 21:58:15 +0200
Subject: [PATCH v3] ARM: dts: twl4030: Add iio properties for bci subnode
In-Reply-To: <20150926172936.GD22315@earth>
References: <1443212447-5841-1-git-send-email-marek@goldelico.com>
 <1443212447-5841-3-git-send-email-marek@goldelico.com>
 <20150926172936.GD22315@earth>
Message-ID: <CAAfyv36nZ3c-yw7QQHwBWk3GwY31rV3Uq2n0dz5hppn5JFhEcA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Tony sorry I forgot to add you to the recipients for this patchset.
Can you please queue this patch. Many thanks.

@Sebastian: thanks for noticing

On Sat, Sep 26, 2015 at 7:29 PM, Sebastian Reichel <sre@kernel.org> wrote:
> Hi Marek,
>
> On Fri, Sep 25, 2015 at 10:20:47PM +0200, Marek Belisko wrote:
>> Added new iio properties which are required for twl4030-charger driver and
>> allow to use twl4030-madc indirectly.
>>
>> Signed-off-by: Marek Belisko <marek@goldelico.com>
>> ---
>>  arch/arm/boot/dts/twl4030.dtsi | 2 ++
>>  1 file changed, 2 insertions(+)
>>
>> diff --git a/arch/arm/boot/dts/twl4030.dtsi b/arch/arm/boot/dts/twl4030.dtsi
>> index 36ae916..482b7aa 100644
>> --- a/arch/arm/boot/dts/twl4030.dtsi
>> +++ b/arch/arm/boot/dts/twl4030.dtsi
>> @@ -22,6 +22,8 @@
>>       charger: bci {
>>               compatible = "ti,twl4030-bci";
>>               interrupts = <9>, <2>;
>> +             io-channels = <&twl4030_madc 11>;
>> +             io-channel-name = "vac";
>>               bci3v1-supply = <&vusb3v1>;
>>       };
>
> Acked-By: Sebastian Reichel <sre@kernel.org>
>
> This patch is missing correct To/Cc:
>
> $ grep -A5 "OMAP DEVICE TREE SUPPORT" MAINTAINERS
> OMAP DEVICE TREE SUPPORT
> M:      Beno?t Cousson <bcousson@baylibre.com>
> M:      Tony Lindgren <tony@atomide.com>
> L:      linux-omap at vger.kernel.org
> L:      devicetree at vger.kernel.org
> S:      Maintained
>
> -- Sebastian

BR,

marek

-- 
as simple and primitive as possible
-------------------------------------------------
Marek Belisko - OPEN-NANDRA
Freelance Developer

Ruska Nova Ves 219 | Presov, 08005 Slovak Republic
Tel: +421 915 052 184
skype: marekwhite
twitter: #opennandra
web: http://open-nandra.com
