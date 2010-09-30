From: viresh.kumar@st.com (viresh kumar)
Date: Thu, 30 Sep 2010 11:03:58 +0530
Subject: [PATCH 48/74] GIC: Added dummy handlers for Power Management
	Suspend Resume
In-Reply-To: <20100920180708.GB5177@n2100.arm.linux.org.uk>
References: <4C809486.2070308@st.com>
	<20100903073421.GF26319@n2100.arm.linux.org.uk>
	<4C84D6B3.80104@st.com>
	<20100908151232.GD32659@n2100.arm.linux.org.uk>
	<4C885FF2.7060201@st.com> <4C976541.6000203@st.com>
	<20100920134808.GD30793@n2100.arm.linux.org.uk>
	<4C97760A.60404@gmail.com>
	<20100920150749.GF30793@n2100.arm.linux.org.uk>
	<4C979216.3000706@gmail.com>
	<20100920180708.GB5177@n2100.arm.linux.org.uk>
Message-ID: <4CA42146.5020608@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/20/2010 11:37 PM, Russell King - ARM Linux wrote:
> On Mon, Sep 20, 2010 at 11:55:50AM -0500, Rob Herring wrote:
>> There is no programming distinction between an irq and an wakeup if the  
>> GIC is powered on in suspend which is platform dependent. It is only a  
>> s/w distinction of what interrupts you allow to wake you up. If GIC  
>> remains powered, then it can assert nirq to the core and wake-up. If the  
>> core is powered down, the external power controller can monitor the NIRQ  
>> line to wake-up the core. So the powergating of the core has no impact  
>> on the prvgramming of the GIC for wake-up.
> 
> Well, not everyone does this - and I know of no platforms where it has
> been reported for the GIC to be able to wake the system up.  TI OMAP
> doesn't allow it, neither does the one being discussed in this thread.
> 
> The system being discussed here has an external power controller which
> needs to be appropriately programmed.
> 
> You can see this because the proposed patch doesn't add code like that
> in vic.c, but adds a no-operation function so that set_wake() becomes
> a no-op returning zero.
> 
>> How about adding a set_wake function ptr as a parameter to  
>> gic_dist_init? If a platform needs more than the basic operation, they  
>> can override it.
> 
> As I can see, we're not talking about wake-up being able to be done from
> the IRQ controller here, but something entirely external and unrelated
> to it.
> .
> 

Russell,

Should i keep this patch in "SPEAr Support patch series version 2"?

viresh.
