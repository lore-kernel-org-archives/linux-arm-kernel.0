From: shiraz.hashim@st.com (Shiraz Hashim)
Date: Mon, 6 Sep 2010 13:14:22 +0530
Subject: [PATCH 45/74] SPEAr : SEV Send event to secondary CPUs
In-Reply-To: <20100902102256.GO26319@n2100.arm.linux.org.uk>
References: <cover.1283161023.git.viresh.kumar@st.com>
	<861ddbfab51ade4893ef92df4bcfa9b203844a9c.1283161023.git.viresh.kumar@st.com>
	<20100902102256.GO26319@n2100.arm.linux.org.uk>
Message-ID: <4C849BD6.90007@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Russell,

On 9/2/2010 3:52 PM, Russell King - ARM Linux wrote:
> On Mon, Aug 30, 2010 at 04:09:09PM +0530, Viresh KUMAR wrote:
>> diff --git a/arch/arm/mach-spear13xx/include/mach/smp.h b/arch/arm/mach-spear13xx/include/mach/smp.h
>> index 6e028a1..e2e55fc 100644
>> --- a/arch/arm/mach-spear13xx/include/mach/smp.h
>> +++ b/arch/arm/mach-spear13xx/include/mach/smp.h
>> @@ -24,6 +24,12 @@
>>  		cpunum &= 0x0F;				\
>>  	})
>>  
>> +/*
>> + * set_event() is used to wake up secondary core from wfe using sev. Booting
>> + * code puts the second core into wfe(standby).
>> + */
>> +#define set_event()	__asm__ __volatile__ ("sev" : : : "memory")
> 
> This shouldn't be something that platforms define on their own.  Please
> add a sev() macro to arch/arm/include/asm/system.h instead.  Also take a
> look at arch/arm/mach-omap2/omap-smp.c for an alternative idea about how
> to handle this.

OK.
 
> Lastly, consider rolling the OMAP solution into the patch which adds SMP
> support for spear13xx.

OK. I would merge it.

regards
Shiraz
