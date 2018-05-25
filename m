From: tony@atomide.com (Tony Lindgren)
Date: Fri, 25 May 2018 09:01:19 -0700
Subject: [PATCH v3 08/15] ARM: spectre-v2: harden user aborts in kernel
 space
In-Reply-To: <20180525155207.GF17671@n2100.armlinux.org.uk>
References: <20180525135938.GE17671@n2100.armlinux.org.uk>
 <E1fMDHD-00073Q-Ob@rmk-PC.armlinux.org.uk>
 <20180525154742.GA77025@atomide.com>
 <20180525155207.GF17671@n2100.armlinux.org.uk>
Message-ID: <20180525160119.GC98604@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Russell King - ARM Linux <linux@armlinux.org.uk> [180525 15:54]:
> On Fri, May 25, 2018 at 08:47:42AM -0700, Tony Lindgren wrote:
> > We can now get this with the whole series applied:
> > 
> > CPU0: Spectre v2: firmware did not set auxiliary control register
> > IBE bit, system vulnerable
> > CPU: Spectre v2: using ICIALLU workaround
> > 
> > So maybe change the wording from "using %s workaround" to
> > "chosen workaround %s"?
> > 
> > Or I guess disabling the pr_info when not functional can
> > be done in the later patches based on some variable set
> > by check_spectre_auxcr() would be doable too.
> 
> You should not be getting both messages.  It looks like you're using
> an older series - I assumed you pulled my git tree rather than the
> patches?  The public git tree isn't up to date with these changes.

Yes I just fetched your git tree because it allows using
git mergetool because of the conflicts with next. I'll apply
manually and test again.

Thanks,

Tony
