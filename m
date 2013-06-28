From: paul@pwsan.com (Paul Walmsley)
Date: Fri, 28 Jun 2013 18:45:38 +0000 (UTC)
Subject: OMAP baseline test results for v3.10-rc6
In-Reply-To: <51CBBCD8.5030600@ti.com>
References: <alpine.DEB.2.02.1306170521020.9909@utopia.booyaka.com>
 <20130625160243.GE22312@arwen.pp.htv.fi>
 <alpine.DEB.2.02.1306251746060.14373@utopia.booyaka.com>
 <51C9F0A8.1050607@ti.com> <87fvw6t136.fsf@linaro.org>
 <79CD15C6BA57404B839C016229A409A83ECC952D@DBDE04.ent.ti.com>
 <51CAEB33.5010101@ti.com>
 <alpine.DEB.2.02.1306261722520.6135@utopia.booyaka.com>
 <51CBBCD8.5030600@ti.com>
Message-ID: <alpine.DEB.2.02.1306281844090.8767@utopia.booyaka.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Lokesh

On Thu, 27 Jun 2013, Lokesh Vutla wrote:

> On Wednesday 26 June 2013 10:56 PM, Paul Walmsley wrote:
> > 
> > Here's how I do it:
> > 
> > ARCH=arm CROSS_COMPILE=${TOOLCHAIN_PATH}/bin/${TOOLCHAIN_PREFIX} nice make
> > -j$CORES zImage am335x-bone.dtb
> > 
> > cat arch/arm/boot/zImage arch/arm/boot/am335x-bone.dtb >
> > arch/arm/boot/zImage-dtb.am335x-bone
> Here is the catch..
> Your dtb is generated in arch/arm/boot/dts/ folder(before V3.8 dtb was
> generated in arch/arm/boot).

Ugh... that's probably it :-(

> You are using very old dtb file. Please delete all your dtb files in
> arch/arm/boot/ folder and check once.

The tree is freshly recreated for each build, so the most likely scenario 
is that there's no DTB file at all appended to the image.

> Here is the patch from Grant Likely which does that.
> https://patchwork.kernel.org/patch/1813321/
> Can you please give a try updating this ..:)

Yeah will try that, probably either today or tomorrow.


- Paul
