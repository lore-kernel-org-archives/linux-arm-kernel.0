From: sstabellini@kernel.org (Stefano Stabellini)
Date: Wed, 18 Jan 2017 11:05:32 -0800 (PST)
Subject: [RFC] Device memory mappings for Dom0 on ARM64 ACPI systems
In-Reply-To: <587F518802000078001312AB@prv-mh.provo.novell.com>
References: <alpine.DEB.2.10.1701171309040.2347@sstabellini-ThinkPad-X260>
 <587F518802000078001312AB@prv-mh.provo.novell.com>
Message-ID: <alpine.DEB.2.10.1701181054280.10192@sstabellini-ThinkPad-X260>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 18 Jan 2017, Jan Beulich wrote:
> >>> On 17.01.17 at 23:20, <sstabellini@kernel.org> wrote:
> > b) Otherwise, we could write an alternative implementation of ioremap
> > on arm64. The Xen specific ioremap would request a stage-2 mapping
> > first, then create the stage-1 mapping as usual. However, this means
> > issuing an hypercall for every ioremap call.
> 
> +1 for this being the best choice among the ones listed. In fact
> this may also be a reasonable approach for PVHv2, unless facing
> resistance by the x86 maintainers.

Adding more context so that the Linux folks can follow. PVHv2 is a new
Xen x86 virtual machine type with very similar requirements as Xen ARM
virtual machines.

In other words, PVHv2 has the same problems described here, except that
it's x86, rather than arm64.

With my ARM maintainer hat on, I described the issue for Xen on ARM, but
it pretty much applies to x86 as well.
