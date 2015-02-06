From: mark.rutland@arm.com (Mark Rutland)
Date: Fri, 6 Feb 2015 19:29:25 +0000
Subject: [PATCHv6 0/5] Add Altera peripheral memories to EDAC framework
In-Reply-To: <54CA9DB2.4070109@opensource.altera.com>
References: <1420772036-3112-1-git-send-email-tthayer@opensource.altera.com>
 <54CA9DB2.4070109@opensource.altera.com>
Message-ID: <20150206192925.GG10324@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 29, 2015 at 08:53:06PM +0000, Thor Thayer wrote:
> Hi Device Tree Maintainers,

Hi Thor,

Apologies for being silent for so long on this.

> On 01/08/2015 08:53 PM, tthayer at opensource.altera.com wrote:
> > From: Thor Thayer <tthayer@opensource.altera.com>
> >
> > This patch adds the L2 cache and OCRAM peripherals to the EDAC framework
> > using the EDAC device framework. The ECC is enabled early in the boot
> > process in the platform specific code.
> >
> 
> The changes in this patch series revision were mainly to address device 
> tree concerns. There were changes in other areas of the code to address 
> these changes but I believe the other maintainers are waiting to see if 
> these changes are accepted before they will review (they had approved 
> the previous patch changes).
> 
> How does the this patch series appear from a device tree perspective?

While this looks better than before (thank you for no longer treating
the PL310 registers as a syscon), I have a couple of quibbles with the
binding:

* It's not clear to me whether the L2 and OCRAM EDACs are fundamentally
  different in interface, or whether they simply happen to be monitoring
  different memories. The former would mean a common compatible string
  for both EDAC block instances, and another property to determine
  what the other end was.

* It relies on a single instance of OCRAM or L2 existing, rather than
  describing the relationship with the particular memory explicitly. In
  general it's better to be explicit -- this means it can more easily be
  generalised to multiple OCRAMs as might occur in a later SoC (in
  addition to the reasons laid out in the first point.

Thanks,
Mark.
