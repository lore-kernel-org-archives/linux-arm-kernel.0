From: geoff.levand@linaro.org (Geoff Levand)
Date: Wed, 19 Nov 2014 10:32:51 -0800
Subject: [PATCH v5.5] of/fdt: export fdt blob as /sys/firmware/fdt
In-Reply-To: <1416402576.29243.35.camel@citrix.com>
References: <1415984735-32388-1-git-send-email-ard.biesheuvel@linaro.org>
 <20141118165145.4F6A8C40966@trevor.secretlab.ca>
 <20141118172545.GC14323@leverpostej>
 <20141118221103.4ECB3C40966@trevor.secretlab.ca>
 <1416402576.29243.35.camel@citrix.com>
Message-ID: <1416421971.23886.71.camel@smoke>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Ian,

On Wed, 2014-11-19 at 13:09 +0000, Ian Campbell wrote:
> On Tue, 2014-11-18 at 22:11 +0000, Grant Likely wrote:
> > > > * It also helps with exposing the reserved map to userspace, but kexec
> > > >   has done without that feature for years, and it is in the process of
> > > >   being deprecated in favour of /reserved-memory anyway.
> > > 
> > > This is the first I'd heard of the reserve map being deprecated, and
> > > we're going to have DTs with reserved map entries for a long time going
> > > forwards.
> > 
> > Deprecated, not removed or disabled. It will still work pretty much
> > forever, but users should be encouraged to move to the reserve-memory
> > tree.
> 
> I'm curious why that should be for the "OS should never touch this, here
> be dragons" type memory, what are the benefits of the new scheme in that
> case?

/memreserve/ device tree entries are not available in /proc/device-tree,
but reserved-memory nodes are.  Some solution is needed to get all
reserved memory info into the dtb passed to the second stage kernel
during a kexec re-boot.

-Geoff
