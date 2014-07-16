From: holgerschurig@gmail.com (Holger Schurig)
Date: Wed, 16 Jul 2014 16:03:21 +0200
Subject: BUG: i.MX6-FEC: broken TCP tx checksumming
In-Reply-To: <20140716095850.GO21766@n2100.arm.linux.org.uk>
References: <CAOpc7mFpW=ZDdF3g-MK4TaNje5KBWimUwUgxoebg-wmb+OQ8zA@mail.gmail.com>
 <20140716095850.GO21766@n2100.arm.linux.org.uk>
Message-ID: <CAOpc7mGrZXbr-cytzSHLUjgoYz88ZFeuv2g0kJ2kzOnbF7Uz5g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

>> So I tried "ethtool -K eth0 tx off" (on the i.MX6 board) and suddenly
>> ssh worked.
>
> That sounds like the hardware IP header checksumming isn't working.  Is
> there anything specific to your setup?  VLAN maybe?

No, no games, I just did a normal "ifconfig eth0 192.168.200.199".

> Which gcc version are you using?

Currently http://releases.linaro.org/14.04/components/toolchain/binaries/gcc-linaro-arm-linux-gnueabihf-4.8-2014.04_linux.tar.xz
 But I could try a different one.

> That's a little heavy-weight, but let's use the sledge hammer first...

The sledge hammer worked!

Do you want to to find out which of the for wmb() is actually needed?
