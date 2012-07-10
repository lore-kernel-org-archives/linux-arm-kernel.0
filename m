From: tony@atomide.com (Tony Lindgren)
Date: Tue, 10 Jul 2012 02:43:08 -0700
Subject: [PATCH] ARM: OMAP2+: cpu: Make cpu_class_is_omap2 true for all
 non-omap1 platforms
In-Reply-To: <79CD15C6BA57404B839C016229A409A83EA69AFE@DBDE01.ent.ti.com>
References: <1339420974-23695-1-git-send-email-hvaibhav@ti.com>
 <79CD15C6BA57404B839C016229A409A83EA5096A@DBDE01.ent.ti.com>
 <20120627133950.GJ3483@atomide.com>
 <20120627161745.GO3483@atomide.com>
 <79CD15C6BA57404B839C016229A409A83EA5C2C4@DBDE01.ent.ti.com>
 <20120710084107.GO1122@atomide.com>
 <79CD15C6BA57404B839C016229A409A83EA69AA3@DBDE01.ent.ti.com>
 <20120710091820.GR1122@atomide.com>
 <79CD15C6BA57404B839C016229A409A83EA69AFE@DBDE01.ent.ti.com>
Message-ID: <20120710094308.GS1122@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Hiremath, Vaibhav <hvaibhav@ti.com> [120710 02:29]:
> On Tue, Jul 10, 2012 at 14:48:21, Tony Lindgren wrote:
> > 
> > We have quite a few initcalls that exit early with various soc_is, cpu_is,
> > cpu_class_is tests that would fail for multi zImage kernels. Some of these
> > have been patched away with additional calls in MACHINE_START, but some
> > still remain.
> > 
> Let me check on this inside code but if you have any quick reference, please 
> let me know, I can fix it and submit the patch.

Any initcall that returns early if (!cpu_class_is_omap2()) would continue
running on multi zImage kernel on other SoCs compiled in unless we check
for each cpu_is_omapxxxx() || soc_is_omapxxxx() tests like we currently
do.

Regards,

Tony
