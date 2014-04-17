From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 17 Apr 2014 21:16:45 +0100
Subject: Change of TEXT_OFFSET for multi_v7_defconfig
In-Reply-To: <alpine.LFD.2.11.1404171549480.980@knanqh.ubzr>
References: <534D0D91.8020406@linaro.org> <534EAD6C.3040502@codeaurora.org>
 <alpine.LFD.2.11.1404161428280.980@knanqh.ubzr>
 <CAL_Jsq+aYXTQCzCtxPnS=zhBCba6-mEz+kT-mHTDW602E0vbDw@mail.gmail.com>
 <alpine.LFD.2.11.1404171549480.980@knanqh.ubzr>
Message-ID: <20140417201645.GU24070@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Apr 17, 2014 at 04:06:16PM -0400, Nicolas Pitre wrote:
> On Thu, 17 Apr 2014, Rob Herring wrote:
> > Better yet, we should adopt the arm64 Image header which has this and
> > other fields for arm Image files. We're going to have to deal with raw
> > Image (and Image.gz) in bootloaders for arm64, so we might as well
> > align things.
> 
> We could use the same header as ARM64 if we want to add more information 
> to the uncompressed kernel image.
> 
> However I really don't want to encourage the proliferation of yet 
> another kernel image formats on ARM32.  We've had zImage for the last 20 
> years and that's what ARM32 bootloaders should support.  The 
> introduction of the uImage format caused enough pain already.
> 
> Booting uncompressed kernel image on ARM32 may be useful for some 
> debugging setups.  I don't see other cases where it would be legitimate 
> to break existing practices.

Me neither.  We even have good enough reasons (such as the issue in this
thread to do with where the image should be placed) no longer support
uncompressed images anymore.  (Yes, they'll still be generated because
we need the input to compress them, but we should stop advertising them
as a make target.)

-- 
FTTC broadband for 0.8mile line: now at 9.7Mbps down 460kbps up... slowly
improving, and getting towards what was expected from it.
