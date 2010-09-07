From: viresh.kumar@st.com (viresh kumar)
Date: Tue, 7 Sep 2010 14:05:14 +0530
Subject: [PATCH 15/74] ST SPEAr: adding support for rtc
In-Reply-To: <20100906224516.GB8153@game.jcrosoft.org>
References: <cover.1283161023.git.viresh.kumar@st.com>
	<d9930e7793964f07a2e0acf7f52b45306e308ddd.1283161023.git.viresh.kumar@st.com>
	<20100906224516.GB8153@game.jcrosoft.org>
Message-ID: <4C85F942.2080200@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 9/7/2010 4:15 AM, Jean-Christophe PLAGNIOL-VILLARD wrote:
>> > diff --git a/arch/arm/mach-spear13xx/include/mach/generic.h b/arch/arm/mach-spear13xx/include/mach/generic.h
>> > index 41c1a53..dc80421 100644
>> > --- a/arch/arm/mach-spear13xx/include/mach/generic.h
>> > +++ b/arch/arm/mach-spear13xx/include/mach/generic.h
>> > @@ -30,6 +30,7 @@
>> >  
>> >  /* Add spear13xx family device structure declarations here */
>> >  extern struct amba_device uart_device;
>> > +extern struct platform_device rtc_device;
> no need to export all theres platform devices
> 
> it will be better to export funtion as done on AT91
> 
> to register the device
> 
> as
> 
> spear_rtc_device_add();
> 
> and the sme for the other devices etc...

We don't want to create unnecessary abstraction. Even if we add functions
then these function prototypes have to be added in generic.h. This will
increase lines of code, without much advantages.

> 
> btw you do not respect the kernel coding style please check your patches

Sorry!! But we have been following coding style, have run checkpatch too...
Can you please pin point where are we wrong, so that we don't commit same
mistakes again next time.

regards,
viresh.
