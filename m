From: tony@atomide.com (Tony Lindgren)
Date: Thu, 8 Aug 2013 22:11:47 -0700
Subject: [PATCHv3 2/9] ARM: OMAP2+: AM33XX: control: Add some control
 module registers and APIs
In-Reply-To: <5203C457.80301@ti.com>
References: <1375811376-49985-1-git-send-email-d-gerlach@ti.com>
 <1375811376-49985-3-git-send-email-d-gerlach@ti.com>
 <5203A0BC.8060205@ti.com> <5203C457.80301@ti.com>
Message-ID: <20130809051146.GB7656@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Dave Gerlach <d-gerlach@ti.com> [130808 09:23]:
> On 08/08/2013 08:44 AM, Santosh Shilimkar wrote:
> >Lets address the above better. I don't see a need of 8 functions
> >exported doing one or 2 register writes.
> >
> >Look M3 based handling is going to be there on future SOCs
> >as well and this kind of handling of IPC is very short cited.
> >
> 
> The idea here was to move all control module register accesses into
> one file in planning of implementing a driver for the control module
> itself in the future.
> 
> >Probably we should have a separate driver for M3 in linux which
> >can have all this local code instead of all these exports.
> 
> The wkup_m3 code has been moved to a small driver found in patch 8
> of this series, would it better to move this code there rather than
> with the rest of the control module code?

Please make everything you can into regular device drivers.

We still have some dependencies to mach-omap2 code for PRCM
for example, but we're trying to get all that to live in
drivers.

So for new pieces, let's not add further dependencies to
complicate moving things to drivers.

Regards,

Tony
