From: yamada.masahiro@socionext.com (Masahiro Yamada)
Date: Wed, 14 Oct 2015 11:14:21 +0900
Subject: [PATCH] ARM64: dts: vexpress: Use a symlink to
 vexpress-v2m-rs1.dtsi from arch=arm
In-Reply-To: <20151012153750.GE7452@leverpostej>
References: <1444046032-31310-1-git-send-email-ian.campbell@citrix.com>
 <20151012153750.GE7452@leverpostej>
Message-ID: <CAK7LNAQsckXsoPgBmowu4mHi4kemM5i=Fq4z7BwuKbNv7Ur54w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Ian, Rob, Olof,


2015-10-13 0:37 GMT+09:00 Mark Rutland <mark.rutland@arm.com>:
> On Mon, Oct 05, 2015 at 12:53:52PM +0100, Ian Campbell wrote:
>> Commit 9ccd608070b6 "arm64: dts: add device tree for ARM SMM-A53x2 on
>> LogicTile Express 20MG" added a new dts file to arch/arm64 which
>> included "../../../../arm/boot/dts/vexpress-v2m-rs1.dtsi", i.e. a
>> .dtsi supplied by arch/arm.
>>
>> Unfortunately this causes some issues for the split device tree
>> repository[0], since things get moved around there. In that context
>> the new .dts ends up at src/arm64/arm/vexpress-v2f-1xv7-ca53x2.dts
>> while the include is at src/arm/vexpress-v2m-rs1.dtsi.
>>
>> The sharing of the .dtsi is legitimate since the baseboard is the same
>> for various vexpress systems whatever processor they use.
>>
>> Previously I attempted to resolve this by creating a shared location
>> for such things but we have been unable to come to a consensus on
>> where that should be.
>>
>> Instead this patch simply replaces the use of ../../ in the dts
>> /include/ with a symlink in arch/arm64/boot/dts/arm pointing to the
>> file arch/arm/boot/dts.
>>
>> Since the split device tree repo will shortly be required to flatten
>> symlinks for other reasons this will cause the dtsi file to appear in
>> both src/arm and src/arm64 in the split repo, which is an improvement
>> on not building for arm64 now.
>>
>> [0] https://git.kernel.org/cgit/linux/kernel/git/devicetree/devicetree-rebasing.git/
>>
>> Signed-off-by: Ian Campbell <ian.campbell@citrix.com>
>> Cc: Rob Herring <robh+dt@kernel.org>
>> Cc: Pawel Moll <pawel.moll@arm.com>
>> Cc: Mark Rutland <mark.rutland@arm.com>
>> Cc: Kumar Gala <galak@codeaurora.org>
>> Cc: Liviu Dudau <liviu.dudau@arm.com>
>> Cc: Sudeep Holla <sudeep.holla@arm.com>
>> Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
>> Cc: Russell King <linux@arm.linux.org.uk>
>> Cc: Catalin Marinas <catalin.marinas@arm.com>
>> Cc: Will Deacon <will.deacon@arm.com>
>> Cc: Kristina Martsenko <kristina.martsenko@arm.com>
>> Cc: Kevin Hilman <khilman@linaro.org>
>> Cc: Frank Rowand <frank.rowand@sonymobile.com>
>> Cc: Olof Johansson <olof@lixom.net>
>> Cc: devicetree at vger.kernel.org
>> Cc: linux-kernel at vger.kernel.org
>> Cc: linux-arm-kernel at lists.infradead.org
>> Cc: arm at kernel.org
>> Cc: linux-kbuild at vger.kernel.org


I have a similar issue to vexpress, so I want to consult experts.

I am trying to support a new ARM64 SoC and
want to share some DTSI files between arch/arm/boot/dts and arch/arm64/boot/dts.


I think Ian's "dtb: Create a common home for cross-architecture dtsi files"
is under way (or rejected?).

I can live with the symbolic link.
Is it OK (at least for now)?



-- 
Best Regards
Masahiro Yamada
