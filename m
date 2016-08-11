From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Thu, 11 Aug 2016 22:30:54 +0200
Subject: [BISECTED,
 REGRESSION] v4.7: Display lost on Kirkwood/OpenRD Client
In-Reply-To: <20160811180414.GB10648@raspberrypi.musicnaut.iki.fi> (Aaro
 Koskinen's message of "Thu, 11 Aug 2016 21:04:14 +0300")
References: <20160810215858.GA10648@raspberrypi.musicnaut.iki.fi>
 <87inv73hyf.fsf@free-electrons.com>
 <20160811180414.GB10648@raspberrypi.musicnaut.iki.fi>
Message-ID: <87wpjn120x.fsf@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Aaro,
 
 On jeu., ao?t 11 2016, Aaro Koskinen <aaro.koskinen@iki.fi> wrote:

> Hi,
>
> On Thu, Aug 11, 2016 at 09:03:52AM +0200, Gregory CLEMENT wrote:
>>  On mer., ao?t 10 2016, Aaro Koskinen <aaro.koskinen@iki.fi> wrote:
>> > When upgrading from v4.6 --> v4.7, I lost the display/framebuffer on
>> > OpenRD-Client (the only pcie device on the board).
>> >
>> > Bisection points to:
>> >
>> > eb13cf8345e94a02e9872ca3e909596a5ddb5f90 is the first bad commit
>> 
>> Could you try this patch:
>
> That works, thanks!

Good, so I will send a proper patch soon.

Gregory


> A.
>
>> diff --git a/arch/arm/boot/dts/kirkwood-openrd.dtsi b/arch/arm/boot/dts/kirkwood-openrd.dtsi
>> index e4ecab112601..7175511a92da 100644
>> --- a/arch/arm/boot/dts/kirkwood-openrd.dtsi
>> +++ b/arch/arm/boot/dts/kirkwood-openrd.dtsi
>> @@ -116,6 +116,10 @@
>>         };
>>  };
>>  
>> +&pciec {
>> +       status = "okay";
>> +};
>> +
>>  &pcie0 {
>>         status = "okay";
>>  };

-- 
Gregory Clement, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
