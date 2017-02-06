From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 6 Feb 2017 14:44:13 +0100
Subject: [PATCH RESEND 1/3] arm64: add THUNDER2 processor family
In-Reply-To: <20170206100608.GA8540@arm.com>
References: <1486233461-2679-1-git-send-email-jnair@caviumnetworks.com>
 <1486233461-2679-2-git-send-email-jnair@caviumnetworks.com>
 <20170206100608.GA8540@arm.com>
Message-ID: <CAK8P3a1_dQZd3RRyavMKqBFcHsXTQ2oAUO5vaLhyTiH99XhqrQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Feb 6, 2017 at 11:06 AM, Will Deacon <will.deacon@arm.com> wrote:
> On Sat, Feb 04, 2017 at 06:37:39PM +0000, Jayachandran C wrote:
>> Add support for ThunderX2 CN99XX arm64 server processors.
>>
>> Introduce a new arm64 platform config option ARCH_THUNDER2 for these
>> processors. Add device tree files boot/dts/cavium/thunder-99xx.dtsi for
>> on-chip devices and boot/dts/cavium/thunder-99xx.dts for the evaluation
>> board.
>>
>> Signed-off-by: Jayachandran C <jnair@caviumnetworks.com>
>> ---
>>  arch/arm64/Kconfig.platforms                 |   7 ++
>>  arch/arm64/boot/dts/cavium/Makefile          |   1 +
>>  arch/arm64/boot/dts/cavium/thunder-99xx.dts  |  34 +++++++
>>  arch/arm64/boot/dts/cavium/thunder-99xx.dtsi | 147 +++++++++++++++++++++++++++
>
> This is basically identical to vulcan.dtsi. Do we really need both in the
> tree?

Hmm, an alternative would be to add the new .dtsi file and start out with an
#include of the existing file, with overrides for anything that needs changing.
Similarly, the Kconfig symbol could just 'select ARCH_VULCAN' for now.

     Arnd
