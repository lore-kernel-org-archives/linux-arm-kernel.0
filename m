From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Tue, 26 Jul 2011 15:10:05 -0400 (EDT)
Subject: PLEA: Please fix mach/gpio.h includes (was: Re: [RFC PATCH 2/2]
	GPIO: add gpiolib and irqchip for CSR SiRFprimaII GPIO controller)
In-Reply-To: <20110726183958.GG1655@n2100.arm.linux.org.uk>
References: <1311667993-27189-1-git-send-email-bs14@csr.com>
	<1311667993-27189-3-git-send-email-bs14@csr.com>
	<20110726100928.GO9653@n2100.arm.linux.org.uk>
	<20110726104628.GP9653@n2100.arm.linux.org.uk>
	<CAMbhsRRr5FPtu-kUbcLO56=rsHkb2XNDf21-G3pymPBTcmYmRQ@mail.gmail.com>
	<20110726183958.GG1655@n2100.arm.linux.org.uk>
Message-ID: <alpine.LFD.2.00.1107261502251.12766@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 26 Jul 2011, Russell King - ARM Linux wrote:

> I don't think there's any plans to break the:
> 
> linux/gpio.h -> asm/gpio.h -> mach/gpio.h
> 
> include path at the moment, as platforms do define ARCH_NR_GPIO,
> which has to be done before asm-generic/gpiolib.h is included.

Well, this GPIO business is the biggest hurdle towards a single kernel 
image that can support multiple SOCs at the moment, and the only one for 
which I have no solution yet.  Anything that could help removing 
mach/gpio.h from asm/gpio.h would be welcome.


Nicolas
