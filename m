From: afzal@ti.com (Mohammed, Afzal)
Date: Fri, 19 Oct 2012 10:58:56 +0000
Subject: [PATCH 2/3] RTC: omap-rtc: enable pm_runtime
In-Reply-To: <79CD15C6BA57404B839C016229A409A83EB43BD9@DBDE01.ent.ti.com>
References: <1350575631-15523-1-git-send-email-zonque@gmail.com>
 <1350575631-15523-2-git-send-email-zonque@gmail.com>
 <50802A87.9010409@ti.com> <50802C20.9040408@gmail.com>
 <79CD15C6BA57404B839C016229A409A83EB43BD9@DBDE01.ent.ti.com>
Message-ID: <C8443D0743D26F4388EA172BF4E2A7A93EA00B18@DBDE01.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Daniel,

On Thu, Oct 18, 2012 at 22:03:13, Hiremath, Vaibhav wrote:
> On Thu, Oct 18, 2012 at 21:49:44, Daniel Mack wrote:
> > On 18.10.2012 18:12, Vaibhav Hiremath wrote:

> > > It would be really helpful if you could test these patches and ack them.

> > Ok, will do tomorrow. What's missing there is support for writing to the
> > OMAP_RTC_OSC_REG (path 3/3 in my series). Would like me to rebase the
> > functionality? I need thatkind of setup for my board ...

> This is bit tricky and required more discussion before merging it, 
> let me reopen the old discussion which I had started some time back -
> 
> 
> RTC OSC clock is required to configure clocksource systemtimer for the 
> kernel, and it is important when you get into PM related features.
> 
> Please refer the below commit for more reference,
> 
> http://marc.info/?l=u-boot&m=135057734713796&w=2

Newer version (v4) of omap rtc patches for am335x has been
posted, "rtc: omap dt support (for am33xx)".
In case you can test, please do it over the new series.

You would need also need DT patch that adds DT node to
test (it has been separated from the series as it is
felt that it should not be part of same series),
"arm/dts: am33xx rtc node"

If you are using mainline uboot, you would need the fix as
mentioned by Vaibhav H (as in the link he provided above),
expecting it to reach uboot mainline soon.

If the above is being attempted to achieve in Kernel it
would cause 2-3 seconds delay in boot time (else it had
to be made a module), please refer link provided by
Vaibhav H for more details.

else you can do in current mainline uboot,

mw.l 0x44e3e06c 0x83e70b13
mw.l 0x44e3e070 0x95a4f1e0
mw.b 0x44e3e054 0x48

and then boot kernel.

Regards
Afzal
