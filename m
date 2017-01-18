From: JBeulich@suse.com (Jan Beulich)
Date: Wed, 18 Jan 2017 03:29:12 -0700
Subject: [RFC] Device memory mappings for Dom0 on ARM64 ACPI
 systems
In-Reply-To: <alpine.DEB.2.10.1701171309040.2347@sstabellini-ThinkPad-X260>
References: <alpine.DEB.2.10.1701171309040.2347@sstabellini-ThinkPad-X260>
Message-ID: <587F518802000078001312AB@prv-mh.provo.novell.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

>>> On 17.01.17 at 23:20, <sstabellini@kernel.org> wrote:
> b) Otherwise, we could write an alternative implementation of ioremap
> on arm64. The Xen specific ioremap would request a stage-2 mapping
> first, then create the stage-1 mapping as usual. However, this means
> issuing an hypercall for every ioremap call.

+1 for this being the best choice among the ones listed. In fact
this may also be a reasonable approach for PVHv2, unless facing
resistance by the x86 maintainers.

Jan
