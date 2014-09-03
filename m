From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 03 Sep 2014 18:05:51 +0200
Subject: [PATCH V3 0/6] ARM64: Add support for FSL's LS2085A SoC
In-Reply-To: <20140903155654.GK3127@leverpostej>
References: <1409757194-28155-1-git-send-email-bhupesh.sharma@freescale.com>
 <9081864.6l1AHRQ5bg@wuerfel> <20140903155654.GK3127@leverpostej>
Message-ID: <2961958.2caI26WGbt@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 03 September 2014 16:56:55 Mark Rutland wrote:
> I had asked for the FW to patch up the enable-method (and omit this in
> the in-kernel dts) as this is something that may vary over the lifetime
> of the SoC independently from the fixed HW properties (it's a firmware
> property really).

I agree in principle.
 
> Personally I'd like to see such things patched by the firmware/loader
> where possible (ideally with some way of switching said patching off if
> we really know better). We already expect the loader to patch memory
> nodes where memory can be dynamically populated. 
> 
> I don't see why we should tie the in-kernel dts to a particular firmware
> revision. Having such properties in the in-kernel dts is only going to
> mislead. The arm64 boot-wrapper patches dts for PSCI, but for
> compatibility with old wrappers the in-kernel dts must forever say
> spin-table is used to bring up secondaries.

But the kernel has never supported this platform with a non-PSCI
enable method, why should we provide compatibility for something
we never had upstream?

	ARnd
