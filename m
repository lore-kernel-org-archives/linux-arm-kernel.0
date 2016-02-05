From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Fri, 05 Feb 2016 16:45:44 +0100
Subject: marvell_cesa fails to register on kirkwood (88F6282)
In-Reply-To: <CAKzmTe20fT8BcRaDaf2gz92KMAK0kEUkaD-kPq_cPF1WKBdroA@mail.gmail.com>
 (JM's message of "Fri, 5 Feb 2016 16:00:49 +0100")
References: <CAKzmTe0mvZD5UwqM47uXbM7Z7oAJpE4g4BVMba1hkzqNu+Zbgw@mail.gmail.com>
 <20160205090246.GE32272@lunn.ch> <20160205112907.796afb05@bbrezillon>
 <CAKzmTe20fT8BcRaDaf2gz92KMAK0kEUkaD-kPq_cPF1WKBdroA@mail.gmail.com>
Message-ID: <87vb632maf.fsf@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi JM,
 
 On ven., f?vr. 05 2016, JM <fijam@archlinux.us> wrote:

> On Fri, Feb 5, 2016 at 11:29 AM, Boris Brezillon
> <boris.brezillon@free-electrons.com> wrote:
>> Jan, Andrew
>>
>> On Fri, 5 Feb 2016 10:02:46 +0100
>> Andrew Lunn <andrew@lunn.ch> wrote:
>>
>>> On Fri, Feb 05, 2016 at 06:01:18AM +0100, JM wrote:
>>> > Hi,
>>> >
>>> > I am testing marvell_cesa on a kirkwood device (QNAP TS-212p, Marvell
>>> > Kirkwood 88F6282, dts: http://pastebin.com/Gk95KFHf ).
>>> > As of kernel 4.4 (4.4.0-trunk-kirkwood #1 Debian 4.4-1~exp1) it fails
>>> > in the following way:
>>> >
>>> > modprobe marvell_cesa allhwsupport=1
>>> > dmesg | tail -n 1
>>> > [ 1057.855091] marvell-cesa: probe of f1030000.crypto failed with error -12
>>> >
>>> > or:
>>> >
>>> > modprobe marvell_cesa
>>> > dmesg | tail -n 1
>>> > [ 9178.399357] marvell-cesa: probe of f1030000.crypto failed with error -524
>>> >
>>> > With kernel 4.3 it would fail with error -22 on that hardware. There
>>> > are scattered reports from other users experiencing the same issue
>>> > (1,2,3)
>>> >
>>> > I wonder if this is a result of an invalid definition of the
>>> > crypto-sram in the dts of this SoC, or perhaps some other problem
>>> > (PEBKAC included).
>>>
>>> Hi Jan
>>>
>>> Do you have SRAM enabled in your kernel configuration. The
>>> mvebu_v5_defconfig does not have it, which is a bug really.
>>
>> Hm, the CRYPTO_DEV_MARVELL_CESA option selects the SRAM one [1].
>> Anyway, I also think this error is related to the SRAM (not sure why the
>> driver is not able to get the SRAM though).
>>
>> Best Regards,
>>
>> Boris
>>
>> [1]http://lxr.free-electrons.com/source/drivers/crypto/Kconfig#L168
>>
>>
>> --
>> Boris Brezillon, Free Electrons
>> Embedded Linux and Kernel engineering
>> http://free-electrons.com
>
> Hi,
>
> Thanks for getting back to me. Indeed, CONFIG_SRAM is enabled, I put
> the complete .config here: http://pastebin.com/40eKMJqE
>
> If there is anything I can do to help squish this bug, please let me
> know.

How do you get your dts?
it seems that you generated it from your dtb (or from /proc).

I tried to do the same from arch/arm/boot/dts/kirkwood-ts219-6282.dtb,
but the resulting dts is too different for an easy comparison.

Could you also provide your dtb, maybe by using the same dtc with the
option -s I will manage to get the something easier to compare.

Gregory


>
> Best regards,
> Jan
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

-- 
Gregory Clement, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
