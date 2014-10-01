From: catalin.marinas@arm.com (Catalin Marinas)
Date: Wed, 1 Oct 2014 12:17:17 +0100
Subject: [PATCH 2/6] arm64: Add DTS support for Spreadtrum's Shark64 SoC
In-Reply-To: <4004425.NZAxCnE0qr@wuerfel>
References: <1411992293-7729-1-git-send-email-zhang.lyra@gmail.com>
 <1411992293-7729-3-git-send-email-zhang.lyra@gmail.com>
 <4004425.NZAxCnE0qr@wuerfel>
Message-ID: <20141001111717.GH12702@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Sep 29, 2014 at 02:47:47PM +0100, Arnd Bergmann wrote:
> On Monday 29 September 2014 20:04:49 zhang.lyra at gmail.com wrote:
> > +	cpus {
> > +		#address-cells = <2>;
> > +		#size-cells = <0>;
> > +
> > +		cpu at 0 {
> > +			device_type = "cpu";
> > +			compatible = "arm,armv8";
> > +			reg = <0x0 0x0>;
> > +			enable-method = "spin-table";
> > +			cpu-release-addr = <0x0 0x8000fff8>;
> > +		};
> 
> New platforms should avoid using "spin-table" method. Please
> change the boot loader to implement PSCI if you can.

As usual, I strongly recommend PSCI here if the CPU supports EL3. It
would solve the cpuidle kernel support as well with the generic cpuidle
driver and the PSCI back-end.

-- 
Catalin
