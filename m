From: viresh.kumar@st.com (viresh kumar)
Date: Thu, 3 Mar 2011 09:12:42 +0530
Subject: [PATCH 1/8 resend] dw_dmac: Remove compilation dependency from
	AVR32
In-Reply-To: <1299084372.6974.91.camel@vkoul-udesk3>
References: <cover.1298889267.git.viresh.kumar@st.com>	
	<d41145ce4d5e3d870f720709f68d5b1dbf34d6a0.1298889267.git.viresh.kumar@st.com>
	<1299084372.6974.91.camel@vkoul-udesk3>
Message-ID: <4D6F0E32.6050505@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/02/2011 10:16 PM, Koul, Vinod wrote:
> On Mon, 2011-02-28 at 16:11 +0530, Viresh Kumar wrote:
>> This will be used in SPEAr, ARM family.
> Does this mean it can be used on AVR32 now? Did you implay it will
> *also* be....

Yes, also be used in spear.

>>
>> Signed-off-by: Viresh Kumar <viresh.kumar@st.com>
>> ---
>>  drivers/dma/Kconfig |    1 -
>>  1 files changed, 0 insertions(+), 1 deletions(-)
>>
>> diff --git a/drivers/dma/Kconfig b/drivers/dma/Kconfig
>> index 1c28816..95c7db7 100644
>> --- a/drivers/dma/Kconfig
>> +++ b/drivers/dma/Kconfig
>> @@ -82,7 +82,6 @@ config INTEL_IOP_ADMA
>>  
>>  config DW_DMAC
>>  	tristate "Synopsys DesignWare AHB DMA support"
>> -	depends on AVR32
> Shouldn't you be adding a corresponding depends on new arch? And since
> this supports old arch as well, it should say depends on both...

Why should this driver be dependent on ARM or AVR32? It can be present
on any other arch too.. So i thought removing this dependency all together
is better.
