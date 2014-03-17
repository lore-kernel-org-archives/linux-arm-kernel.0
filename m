From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 17 Mar 2014 21:14:55 +0000
Subject: PL310 errata workarounds
In-Reply-To: <alpine.LFD.2.11.1403171651440.1291@knanqh.ubzr>
References: <20140314144835.GP21483@n2100.arm.linux.org.uk>
 <20140314150110.GQ21483@n2100.arm.linux.org.uk>
 <CAL_JsqLuNz4EzGaQdb5eFSX5ip-spcDTFsNaFN094=XB_iPV3g@mail.gmail.com>
 <20140316115207.GW21483@n2100.arm.linux.org.uk>
 <CAL_Jsq+9Dm9S6rhQAt_umOM6T_x21O=Y_PPg0QyCH1zR_=yWoA@mail.gmail.com>
 <20140317153738.GB21483@n2100.arm.linux.org.uk>
 <20140317172943.GI24070@arm.com>
 <20140317194440.GG21483@n2100.arm.linux.org.uk>
 <alpine.LFD.2.11.1403171651440.1291@knanqh.ubzr>
Message-ID: <20140317211455.GM21483@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Mar 17, 2014 at 05:09:46PM -0400, Nicolas Pitre wrote:
> L2 is normally a per cluster resource.  It is flushed by the last man 
> standing when no other CPUs might contend for the L2 controller.  And if 
> the outer cache is shared by multiple clusters then some additional 
> handling (such as "last cluster standing") would need to be implemented.
> 
> Clearly this outer_cache_flush() call is just a hint if someone were to 
> copy that file to write their own backend.  If it is causing problems 
> then it should just be removed altogether.  No platforms with MCPM that 
> I know of have an actual outer cache at the moment.  And certainly not 
> the platform where dcscb.c is used.

This sounds to me like an invitation to kill it :)  Killing it off
would be good, though maybe a comment should be left behind at this
site?

As you're the most familiar with this code, I'd prefer to commit a
patch from you rather than just deleting the reference myself.

Thanks.

-- 
FTTC broadband for 0.8mile line: now at 9.7Mbps down 460kbps up... slowly
improving, and getting towards what was expected from it.
