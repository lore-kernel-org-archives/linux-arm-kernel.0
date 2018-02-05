From: andre.przywara@arm.com (Andre Przywara)
Date: Mon, 5 Feb 2018 10:14:54 +0000
Subject: [PATCH v4 0/6] 32bit ARM branch predictor hardening
In-Reply-To: <20180201110738.5421-1-marc.zyngier@arm.com>
References: <20180201110738.5421-1-marc.zyngier@arm.com>
Message-ID: <cc28e6aa-e02d-cbc2-3ecb-b696bef4ce36@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On 01/02/18 11:07, Marc Zyngier wrote:
> This small series implements some basic BP hardening by invalidating
> the BTB on 32bit ARM CPUs that are known to be susceptible to aliasing
> attacks (Spectre variant 2). It doesn't help non-ARM 32bit CPUs, nor
> 32bit kernels that run on 64bit capable CPUs. This series doesn't
> mitigate Spectre variant 1 either.

I gave this a test with running both native workloads and some tests in
a KVM guest, both with an unpatched and a patched firmware on a Calxeda
Midway (Cortex-A15 cores).

Tested-by: Andre Przywara <andre.przywara@arm.com>

Thanks!
Andre.
