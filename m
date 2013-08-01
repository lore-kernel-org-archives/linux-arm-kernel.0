From: finn@uni-bremen.de (Finn Hoffmann)
Date: Thu, 01 Aug 2013 10:01:55 +0200
Subject: NSA310 + DT
In-Reply-To: <20130731164512.GB19725@lunn.ch>
References: <20130730172407.3aab15c6@skate> <51F7EBB9.7000504@uni-bremen.de>
 <20130730191943.49f8070c@skate> <20130730183610.GT24782@lunn.ch>
 <51F814A0.2050403@uni-bremen.de> <20130730232316.10dc7019@skate>
 <20130731111414.47e7670b@skate> <51F8DC3A.6010007@uni-bremen.de>
 <20130731115108.21c043fd@skate> <51F8F7E3.9090404@uni-bremen.de>
 <20130731164512.GB19725@lunn.ch>
Message-ID: <51FA15F3.7050708@uni-bremen.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Am 31.07.2013 18:45, schrieb Andrew Lunn:
>> I came across one curious thing: With Andrews kernel I had:
>> $ sensors
>> adt7476-i2c-0-2e
>> Adapter: mv64xxx_i2c adapter
>> in0: +1.82 V (min = +0.00 V, max = +3.31 V)
>> in1: +1.09 V (min = +0.00 V, max = +2.99 V)
>> in2: +3.27 V (min = +2.98 V, max = +3.63 V)
>> in3: +5.12 V (min = +4.53 V, max = +5.52 V)
>> in4: +11.98 V (min = +0.00 V, max = +15.69 V)
>> fan1: 4330 RPM (min = 0 RPM)
>> fan2: 0 RPM (min = 0 RPM)
>> fan3: 0 RPM (min = 0 RPM)
>> fan4: 0 RPM (min = 0 RPM)
>> temp1: +32.2??C (low = -127.0??C, high = +127.0??C)
>> (crit = +100.0??C, hyst = +96.0??C)
>> temp2: +32.5??C (low = -127.0??C, high = +127.0??C)
>> (crit = +100.0??C, hyst = +96.0??C)
>> temp3: +41.0??C (low = -127.0??C, high = +127.0??C)
>> (crit = +100.0??C, hyst = +96.0??C)
>> cpu0_vid: +0.000 V
>>
>> normally I have:
>> # sensors
>> lm85-i2c-0-2e
>> Adapter: mv64xxx_i2c adapter
>> in0: +1.82 V (min = +0.00 V, max = +3.32 V)
>> Vcore: +1.07 V (min = +0.00 V, max = +2.99 V)
>> +3.3V: +3.25 V (min = +2.97 V, max = +3.63 V)
>> +5V: +5.05 V (min = +4.50 V, max = +5.50 V)
>> +12V: +12.12 V (min = +0.00 V, max = +15.94 V)
>> fan1: 2480 RPM (min = 0 RPM)
>> temp1: +35.0?C (low = -127.0?C, high = +127.0?C)
>> temp2: +34.0?C (low = -127.0?C, high = +127.0?C)
>> temp3: +47.0?C (low = -127.0?C, high = +127.0?C)
> Note that the first above is an adt7476 and the other lm85.
>
> There are multiple, slightly different NSA310 designs. Some have an
> lm85, others have a adt7476. Which do you have? If you are using:
>
> https://github.com/lunn/linux.git branch v3.11-rc1-nsa310-tdc you will
> find two different DT descriptions for NSA310. See which works best
> for you, kirkwood-nsa310.dtb or kirkwood-nsa310a.dtb.
>
>      Andrew
There is a ADT7476RQZ chip on the board of my NSA310. I was only 
confused that both work.
But right now I can not reproduce that. I have changed the dts file back to
             adt7476: adt7476a at 2e {
                 compatible = "adt7476";
                 reg = <0x2e>;
             };
but sensors still says it is a lm85.

The LED's on after kernel is loaded, while starting up does not work.
            pmx_led_sys_green: pmx-led-sys-green {
                 marvell,pins = "mpp28";
                 marvell,function = "gpio";
                 linux,default-trigger = "heartbeat";
                 brightness = <255>;
             };
I first tried default-trigger, then I added brightness additionally but 
LED's wont turn on.

There is no sata hdd trigger and nand-disk does not trigger on sata hdd 
activity.

Finn
