From: ccross@google.com (Colin Cross)
Date: Thu, 2 Sep 2010 14:54:52 -0700
Subject: [PATCH] [ARM] tegra: Add i2c support
In-Reply-To: <4C6168E9.1070405@compulab.co.il>
References: <1280450180-25016-1-git-send-email-ccross@google.com>
	<4C6168E9.1070405@compulab.co.il>
Message-ID: <AANLkTimd2D+_xQ_CH-e+jgn+rZgMpJY6Zkc-SSVdFzMt@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Aug 10, 2010 at 7:57 AM, Mike Rapoport <mike@compulab.co.il> wrote:
> Hi Colin,
> Two more comments.
>
> Colin Cross wrote:
>>
>> From: Colin Cross <ccross@android.com>
>>
>> CC: linux-i2c at vger.kernel.org
>> Signed-off-by: Colin Cross <ccross@android.com>
>> ---
>> ?drivers/i2c/busses/Kconfig ? ? | ? ?7 +
>> ?drivers/i2c/busses/Makefile ? ?| ? ?1 +
>> ?drivers/i2c/busses/i2c-tegra.c | ?665
>> ++++++++++++++++++++++++++++++++++++++++
>> ?include/linux/i2c-tegra.h ? ? ?| ? 25 ++
>
> This should probably go to arch/arm/mach-tegra/include/mach/ to minimize the
> pollution in include/linux
The existing standard seems to be to use include/linux

>> ?4 files changed, 698 insertions(+), 0 deletions(-)
>> ?create mode 100644 drivers/i2c/busses/i2c-tegra.c
>> ?create mode 100644 include/linux/i2c-tegra.h
>>
>
> [ snip ]
>
>> +
>> +static int __init tegra_i2c_init_driver(void)
>> +{
>> + ? ? ? return platform_driver_register(&tegra_i2c_driver);
>> +}
>> +module_init(tegra_i2c_init_driver);
>
> subsys_initcall would be better here.
This can be compiled as a module, subsys_initcall would break that.
