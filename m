From: peter.maydell@linaro.org (Peter Maydell)
Date: Thu, 3 Jul 2014 19:38:55 +0100
Subject: Android and compatibility with deprecated armv7 instructions
In-Reply-To: <6860270.v9z8a8Se80@wuerfel>
References: <CAMbhsRSzDYqDnLbicYYNq+=J1N8hZ0fu-mik+UNLs0cBfUf8DA@mail.gmail.com>
 <20140703170558.GZ32514@n2100.arm.linux.org.uk>
 <20140703173226.GC17372@arm.com> <6860270.v9z8a8Se80@wuerfel>
Message-ID: <CAFEAcA9-S1XJCwg7Y5=Ke1esE7mdwyhZ8kay+Bn6BrsmW02LtA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 3 July 2014 19:23, Arnd Bergmann <arnd@arndb.de> wrote:
> E.g. does ARMv8 allow implementations that cannot
> switch endianess at all?

Yes, the architecture permits single-endianness implementations
(in which case SCTLR.SED is RES1, and the various other
endianness controls are RES0 or RES1 depending on whether
the CPU is always-little-endian or always-big-endian). It also
permits "EL0 is mixed-endianness but EL1/2/3 are always
big/little endian". (See the "Mixed-endian support" section
in the v8 ARM ARM.)

-- PMM
