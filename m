From: ijc@hellion.org.uk (Ian Campbell)
Date: Tue, 02 Sep 2014 16:54:59 +0100
Subject: Autoloading of SPI/nor driver on kirkwood (qnap devices)
Message-ID: <1409673299.14324.43.camel@dagon.hellion.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

I recently tried to switch to using the DT based kirkwood stuff with
v3.16.1 on a QNAP TS-419 for the Debian kernel. Most things seemed ok
except that the flash driver was not autoloaded -- as well as spi-nor.ko
I had to manually modprobe m25p80.ko. Once I loaded both the flash was
detected.

I noticed that many platforms declare the flash chip as compatible =
"st,m25pXXX" whereas the ts219.dtsi just said m25p128 but I tried
changing that and it didn't help. In any case without spi-nor.ko being
autoloaded I don't support m25p80.ko ever would be.

I could set these things to =m for the Debian kirkwood flavour, but
since this is supposed to be a distro-style kernel.

I'm not entirely sure how module loading of this SPI stuff is supposed
to fit together -- anyone got any hints?

Ian.
