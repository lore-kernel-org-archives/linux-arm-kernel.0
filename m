From: slash.tmp@free.fr (Mason)
Date: Fri, 9 Oct 2015 21:01:44 +0200
Subject: [PATCH v3] arm-soc: Add support for Sigma Designs Tango4
In-Reply-To: <5898159.aPJzsGHAv7@wuerfel>
References: <560EAA7C.3070302@free.fr> <5612A473.8030405@sigmadesigns.com>
 <5613EF4C.30603@sigmadesigns.com> <5898159.aPJzsGHAv7@wuerfel>
Message-ID: <56180F18.9010801@free.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/10/2015 15:18, Arnd Bergmann wrote:
> On Tuesday 06 October 2015 17:57:00 Marc Gonzalez wrote:
>> This patch adds support for Sigma Designs "Tango4" platform, which is
>> built around the ARM Cortex A9 MPCore (single and dual core SoCs).
>>
>> Tango4 is not to be confused with Tango3, which was built around a
>> MIPS 74kf CPU.
>>
>> Signed-off-by: Marc Gonzalez <marc_gonzalez@sigmadesigns.com>
>> ---
>> v3 changes: Updated clock tree DT (clk driver submitted)
>>
> 
> Looks all reasonable to me now. Can I get an Ack from M?ns? It sounds
> like he is the original author of the port.

Arnd,

It seems that Mans has a problem with my submission :-(

I understand that there is some bad blood between him and Sigma.
I also understand that Sigma's open source track record is below par.

However, I think it needs to be pointed out that:

1) I don't speak for Sigma, I merely work for them; and I always
try to "do the right thing".

2) I accept valid technical criticism of my code, but Mans' points
are sometimes clouded in a bit of hyperbole. (Especially wrt to the
clk driver)

Looking at the diffstat:

 arch/arm/Kconfig                          |   2 +
 arch/arm/Makefile                         |   1 +
 arch/arm/boot/dts/Makefile                |   2 +
 arch/arm/boot/dts/tango4-vantage-1172.dts |  17 ++++
 arch/arm/boot/dts/tango4.dtsi             | 133 ++++++++++++++++++++++++++++++
 arch/arm/mach-tangox/Kconfig              |  11 +++
 arch/arm/mach-tangox/Makefile             |   1 +
 arch/arm/mach-tangox/setup.c              |   7 ++

it can be argued that /all/ my changes are trivial, except for
the device tree. Perhaps I should credit Mans by adding his
copyright at the top of the tango4.dtsi? (Although he has
expressed disdain for it, so I'm not sure he would welcome
such an addition.)

Arnd, I understand you are the arm-soc maintainer? How am I
supposed to resolve this gridlock?

Regards.
