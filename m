From: rk.raggit@gmail.com (RK Raggit)
Date: Mon, 10 May 2010 12:18:05 +0530
Subject: cortex-m3 booting failure
In-Reply-To: <1273153908.2094.5.camel@e102109-lin.cambridge.arm.com>
References: <h2zec1f3d401005060330n22178e21ve22265bd37006825@mail.gmail.com>
	<1273153908.2094.5.camel@e102109-lin.cambridge.arm.com>
Message-ID: <o2hec1f3d401005092348rcbf5b3eayc31eca6e15963e8b@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Catalin,


>
> I can't really tell what's happening but I'm going to release a new set
> of patches against 2.6.33 sometime next week and there are some improved
> error messages for Cortex-M3 support.
>
> Do you have KALLSYMS enabled in the kernel?

Yes. Debugging a bit further i enabled the hard fault processor
exception catch in
RVD. On doing this i notice that when running commands (like 'ls' or
'date') on console
the processor hard faults. The HFSR shows "0x40000000" while BFSR
reads "0x04" indicating an imprecise data access fault. Other U/MMFSR are 0x0.

I am wondering why an imprecise data access fault could happen at this stage ?

--RK
