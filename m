From: lrg@slimlogic.co.uk (Liam Girdwood)
Date: Tue, 15 Dec 2009 14:50:01 +0000
Subject: [PATCH 4/4] regulator: mc13783-regulator: correct the probing
	time.
In-Reply-To: <1260813215.2022.171.camel@climbing-alby>
References: <1260808880.2022.98.camel@climbing-alby>
	<1260810776.2022.130.camel@climbing-alby>
	<1260811085.2022.135.camel@climbing-alby>
	<1260811598.2022.144.camel@climbing-alby>
	<1260813215.2022.171.camel@climbing-alby>
Message-ID: <1260888601.3591.552.camel@odin>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 2009-12-14 at 18:53 +0100, Alberto Panizzo wrote:
> When the mc13783-regulator driver is built in kernel, probing it during
> the regulator subsystem initialisation result in a fault.
> 
> That is because regulator subsystem is planned to be initialised very early
> in the boot process, before the mfd subsystem initialisation.
> 
> The mc12783-regulator probing process need to access to the mc13783-core
> functionality to read/write mc13783 registers and so must be called after
> the mc13783-core driver initialisation.
> 
> The way to do this is to let the kernel probe the mc13783-regulator driver when 
> mc13783-core register his regulator subdevice.
> 
> Signed-off-by: Alberto Panizzo <maramaopercheseimorto@gmail.com>

Applied to 2.6.33

Thanks

Liam
