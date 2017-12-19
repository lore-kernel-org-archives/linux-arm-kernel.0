From: mark.rutland@arm.com (Mark Rutland)
Date: Tue, 19 Dec 2017 10:45:00 +0000
Subject: Linux Kernel handling AXI DECERR/SLVERR
In-Reply-To: <BLUPR0201MB1505A278D2EF1EABD80555EEA50F0@BLUPR0201MB1505.namprd02.prod.outlook.com>
References: <BLUPR0201MB1505A278D2EF1EABD80555EEA50F0@BLUPR0201MB1505.namprd02.prod.outlook.com>
Message-ID: <20171219104500.5otagp7m7dqretd2@lakrids.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Dec 19, 2017 at 10:23:25AM +0000, Bharat Kumar Gogada wrote:
> Hi All,

Hi,

> When Linux is booted on ARM64 platform and an access to peripheral returns
> DECERR or SLVERR on AXI.
> 
> In the above error cases how would Linux kernel handle these faults ? Will it
> hang/recover ?

I believe that on contemporary CPUs these will result in an SError. As
SErrors are asynchronous, and (in the absence of RAS extensions) their
cause cannot be determined, these are treated as fatal, and the kernel
will panic().

Thanks,
Mark.
