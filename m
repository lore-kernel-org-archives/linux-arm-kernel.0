From: festevam@gmail.com (Fabio Estevam)
Date: Fri, 5 Feb 2016 13:58:23 -0200
Subject: marvell_cesa fails to register on kirkwood (88F6282)
In-Reply-To: <CAKzmTe0mvZD5UwqM47uXbM7Z7oAJpE4g4BVMba1hkzqNu+Zbgw@mail.gmail.com>
References: <CAKzmTe0mvZD5UwqM47uXbM7Z7oAJpE4g4BVMba1hkzqNu+Zbgw@mail.gmail.com>
Message-ID: <CAOMZO5AkyVnfCnaOp=tNo3xe3HL7YMWgcJCNQqD0+jK3jBs5sQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Feb 5, 2016 at 3:01 AM, JM <fijam@archlinux.us> wrote:
> Hi,
>
> I am testing marvell_cesa on a kirkwood device (QNAP TS-212p, Marvell
> Kirkwood 88F6282, dts: http://pastebin.com/Gk95KFHf ).
> As of kernel 4.4 (4.4.0-trunk-kirkwood #1 Debian 4.4-1~exp1) it fails
> in the following way:
>
> modprobe marvell_cesa allhwsupport=1
> dmesg | tail -n 1
> [ 1057.855091] marvell-cesa: probe of f1030000.crypto failed with error -12

It seems like this is the similar issue I saw with the sahara driver.

Could you try a fix like this?
http://www.spinics.net/lists/linux-crypto/msg18393.html
