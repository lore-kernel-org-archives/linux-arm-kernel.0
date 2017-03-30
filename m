From: mark.rutland@arm.com (Mark Rutland)
Date: Thu, 30 Mar 2017 19:19:32 +0100
Subject: [PATCH v3 0/6] bus: brcmstb_gisb: add support for GISBv7 arbiter
In-Reply-To: <c3182c24-2245-cf2e-32e4-248b8046a30f@gmail.com>
References: <20170330002914.7371-1-opendmb@gmail.com>
 <c3182c24-2245-cf2e-32e4-248b8046a30f@gmail.com>
Message-ID: <20170330181932.GB8062@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 30, 2017 at 09:33:32AM -0700, Florian Fainelli wrote:
> On 03/29/2017 05:29 PM, Doug Berger wrote:
> > This patch set contains changes to enable the GISB arbiter driver
> > on the latest ARM64 architecture Set-Top Box chips from Broadcom.
> > 
> > Since the ARM64 architecture does not support the hooking of low
> > level fault handlers the driver has been adjusted to depend solely
> > on GISB interrupts and notify events to provide diagnostic
> > messaging.  The GISB hardware still triggers bus faults for the
> > processor so the default low-level aborts will occur and will be
> > handled based on the architecture specific kernel implementation.
> > 
> > While this tends to obsure the GISB error messaging it is still
> > reasonable so the same approach is applied to the ARM architecture
> > for consistency.
> > 
> > The patches also correct some issues with the existing driver
> > and add the new register map for the GISBv7 hardware first
> > appearing in the BCM7278 device.
> 
> This all looks great to me, and since there are no more ARM64
> dependencies I can take this via the Broadcom ARM/ARM64 SoC pull requests.
> 
> Mark, are you also happy with this v3?

It looks fine by me.

Thanks,
Mark.
