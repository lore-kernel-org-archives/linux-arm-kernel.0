From: carlo@caione.org (Carlo Caione)
Date: Mon, 10 Feb 2014 21:09:08 +0100
Subject: [linux-sunxi] Re: [PATCH 2/3] mfd: axp20x: Add dtsi for axp20x
In-Reply-To: <20140210195942.GA3192@lukather>
References: <1391875428-6281-1-git-send-email-carlo@caione.org>
 <1391875428-6281-3-git-send-email-carlo@caione.org>
 <20140210195942.GA3192@lukather>
Message-ID: <CAOQ7t2bqjBfOM==exWN-Z7oiAVhykJM2mdL3OdqZtZu5apfR-A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Feb 10, 2014 at 8:59 PM, Maxime Ripard
<maxime.ripard@free-electrons.com> wrote:
> Hi Carlo,
>
> On Sat, Feb 08, 2014 at 05:03:47PM +0100, Carlo Caione wrote:
>> This patch adds a new dtsi for supporting axp20x.
>>
>> Signed-off-by: Carlo Caione <carlo@caione.org>
>> ---
>>  arch/arm/boot/dts/axp20x.dtsi | 9 +++++++++
>>  1 file changed, 9 insertions(+)
>>  create mode 100644 arch/arm/boot/dts/axp20x.dtsi
>>
>> diff --git a/arch/arm/boot/dts/axp20x.dtsi b/arch/arm/boot/dts/axp20x.dtsi
>> new file mode 100644
>> index 0000000..98d4c7c
>> --- /dev/null
>> +++ b/arch/arm/boot/dts/axp20x.dtsi
>> @@ -0,0 +1,9 @@
>> +/*
>> +* Integrated Power Management Chip AXP209
>> +*/
>> +
>> +&axp {
>> +     compatible = "x-powers,axp20x";
>> +     interrupt-controller;
>> +     #interrupt-cells = <1>;
>> +};
>
> Hmmm, this refers to an undefined node, I can't see this DTSI used
> anywhere, and why do you need a DTSI of its own in the first place?

Since axp is an independent MFD this could be integrated in the DTS of
the SoC using it (multiple SoC could be using the same axp), that's
why I left it in a DTSI.
i.e. it will be integrated in sun7i-a20-cubieboard2.dts once the
problem with the NMI controller has been solved (and we have a NMI
controller to link the axp to).

Thanks,

-- 
Carlo Caione
