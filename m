From: fijam@archlinux.us (JM)
Date: Fri, 5 Feb 2016 16:00:49 +0100
Subject: marvell_cesa fails to register on kirkwood (88F6282)
In-Reply-To: <20160205112907.796afb05@bbrezillon>
References: <CAKzmTe0mvZD5UwqM47uXbM7Z7oAJpE4g4BVMba1hkzqNu+Zbgw@mail.gmail.com>
 <20160205090246.GE32272@lunn.ch> <20160205112907.796afb05@bbrezillon>
Message-ID: <CAKzmTe20fT8BcRaDaf2gz92KMAK0kEUkaD-kPq_cPF1WKBdroA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Feb 5, 2016 at 11:29 AM, Boris Brezillon
<boris.brezillon@free-electrons.com> wrote:
> Jan, Andrew
>
> On Fri, 5 Feb 2016 10:02:46 +0100
> Andrew Lunn <andrew@lunn.ch> wrote:
>
>> On Fri, Feb 05, 2016 at 06:01:18AM +0100, JM wrote:
>> > Hi,
>> >
>> > I am testing marvell_cesa on a kirkwood device (QNAP TS-212p, Marvell
>> > Kirkwood 88F6282, dts: http://pastebin.com/Gk95KFHf ).
>> > As of kernel 4.4 (4.4.0-trunk-kirkwood #1 Debian 4.4-1~exp1) it fails
>> > in the following way:
>> >
>> > modprobe marvell_cesa allhwsupport=1
>> > dmesg | tail -n 1
>> > [ 1057.855091] marvell-cesa: probe of f1030000.crypto failed with error -12
>> >
>> > or:
>> >
>> > modprobe marvell_cesa
>> > dmesg | tail -n 1
>> > [ 9178.399357] marvell-cesa: probe of f1030000.crypto failed with error -524
>> >
>> > With kernel 4.3 it would fail with error -22 on that hardware. There
>> > are scattered reports from other users experiencing the same issue
>> > (1,2,3)
>> >
>> > I wonder if this is a result of an invalid definition of the
>> > crypto-sram in the dts of this SoC, or perhaps some other problem
>> > (PEBKAC included).
>>
>> Hi Jan
>>
>> Do you have SRAM enabled in your kernel configuration. The
>> mvebu_v5_defconfig does not have it, which is a bug really.
>
> Hm, the CRYPTO_DEV_MARVELL_CESA option selects the SRAM one [1].
> Anyway, I also think this error is related to the SRAM (not sure why the
> driver is not able to get the SRAM though).
>
> Best Regards,
>
> Boris
>
> [1]http://lxr.free-electrons.com/source/drivers/crypto/Kconfig#L168
>
>
> --
> Boris Brezillon, Free Electrons
> Embedded Linux and Kernel engineering
> http://free-electrons.com

Hi,

Thanks for getting back to me. Indeed, CONFIG_SRAM is enabled, I put
the complete .config here: http://pastebin.com/40eKMJqE

If there is anything I can do to help squish this bug, please let me know.

Best regards,
Jan
