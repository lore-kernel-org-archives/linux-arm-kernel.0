From: khilman@baylibre.com (Kevin Hilman)
Date: Tue, 22 Nov 2016 08:39:03 -0800
Subject: [PATCH] ARM: davinci: PM: fix build when da850 not compiled in
In-Reply-To: <b36c5d16-9d49-e4db-8992-c02e9244f04c@ti.com> (Sekhar Nori's
 message of "Sun, 20 Nov 2016 16:59:06 +0530")
References: <20161116164438.9881-1-khilman@baylibre.com>
 <b36c5d16-9d49-e4db-8992-c02e9244f04c@ti.com>
Message-ID: <m2k2bvzcyg.fsf@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Sekhar Nori <nsekhar@ti.com> writes:

> On Wednesday 16 November 2016 10:14 PM, Kevin Hilman wrote:
>> Currently, suspend/resume support is only available on da850 platforms,
>> and the platform PM code has dependencies on da850 functions.  However,
>> CONFIG_SUSPEND might be enabled even when da850 support is not, causing
>> build failure:
>> 
>> arch/arm/mach-davinci/built-in.o: In function `davinci_pm_init':
>> pm_domain.c:(.init.text+0x1fb8): undefined reference to `da8xx_get_mem_ctlr'
>> pm_domain.c:(.init.text+0x20b0): undefined reference to `da8xx_syscfg1_base'
>> 
>> Fix this by only building the PM core when da850 is enabled.
>> 
>> Reported-by: Sekhar Nori <nsekhar@ti.com>
>> Fixes: aa9aa1ec2df6 ARM: davinci: PM: rework init, remove platform device
>> Signed-off-by: Kevin Hilman <khilman@baylibre.com>
>
> Applied. Documentation asks for ("") around commit headline in Fixes:
> tag, so I added that.

Thanks,

Kevin
