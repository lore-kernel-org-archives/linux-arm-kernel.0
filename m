From: lorenzo.pieralisi@arm.com (Lorenzo Pieralisi)
Date: Mon, 25 Jan 2016 09:36:05 +0000
Subject: [PATCH v2] arm64: kernel: fix architected PMU registers
 unconditional access
In-Reply-To: <56A2E2CD.80904@roeck-us.net>
References: <1452696603-27611-1-git-send-email-lorenzo.pieralisi@arm.com>
 <56A2E2CD.80904@roeck-us.net>
Message-ID: <20160125093604.GA32652@red-moon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Guenter,

On Fri, Jan 22, 2016 at 06:17:49PM -0800, Guenter Roeck wrote:
> On 01/13/2016 06:50 AM, Lorenzo Pieralisi wrote:
> >The Performance Monitors extension is an optional feature of the
> >AArch64 architecture, therefore, in order to access Performance
> >Monitors registers safely, the kernel should detect the architected
> >PMU unit presence through the ID_AA64DFR0_EL1 register PMUVer field
> >before accessing them.
> >
> >This patch implements a guard by reading the ID_AA64DFR0_EL1 register
> >PMUVer field to detect the architected PMU presence and prevent accessing
> >PMU system registers if the Performance Monitors extension is not
> >implemented in the core.
> >
> >Fixes: 60792ad349f3 ("arm64: kernel: enforce pmuserenr_el0 initialization and restore")
> >Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> >Reported-by: Guenter Roeck <linux@roeck-us.net>
> >Tested-by: Guenter Roeck <linux@roeck-us.net>
> >Cc: Will Deacon <will.deacon@arm.com>
> >Cc: Peter Maydell <peter.maydell@linaro.org>
> >Cc: Mark Rutland <mark.rutland@arm.com>
> 
> Hi,
> 
> this patch is still missing in mainline.
> 
> Did it get lost ?

No it did not, it will be sent shortly, thanks.

Lorenzo
