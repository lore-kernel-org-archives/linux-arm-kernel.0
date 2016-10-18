From: takahiro.akashi@linaro.org (AKASHI Takahiro)
Date: Tue, 18 Oct 2016 15:26:19 +0900
Subject: [PATCH v26 0/7] arm64: add kdump support
In-Reply-To: <3400bddc-9c6e-b69a-b57d-62921197bef9@cisco.com>
References: <20160907042908.6232-1-takahiro.akashi@linaro.org>
 <3400bddc-9c6e-b69a-b57d-62921197bef9@cisco.com>
Message-ID: <20161018062617.GN19531@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Ruslan,

On Mon, Oct 17, 2016 at 06:41:01PM +0300, Ruslan Bilovol wrote:
> Hi,
> 
> On 09/07/2016 07:29 AM, AKASHI Takahiro wrote:
> >     v26-specific note: After a comment from Rob[0], an idea of adding
> >     "linux,usable-memory-range" was dropped. Instead, an existing
> >     "reserved-memory" node will be used to limit usable memory ranges
> >     on crash dump kernel.
> >     This works not only on UEFI/ACPI systems but also on DT-only systems,
> >     but if he really insists on using DT-specific "usable-memory" property,
> >     I will post additional patches for kexec-tools. Those would be
> >     redundant, though.
> >     Even in that case, the kernel will not have to be changed.
> >
> >This patch series adds kdump support on arm64.
> >There are some prerequisite patches [1],[2].
> >
> >To load a crash-dump kernel to the systems, a series of patches to
> >kexec-tools, which have not yet been merged upstream, are needed.
> >Please always use my latest kdump patches, v3 [3].
> >
> >To examine vmcore (/proc/vmcore) on a crash-dump kernel, you can use
> >   - crash utility (coming v7.1.6 or later) [4]
> >     (Necessary patches have already been queued in the master.)
> >
> >
> >[0] http://lists.infradead.org/pipermail/linux-arm-kernel/2016-August/452582.html
> >[1] "arm64: mark reserved memblock regions explicitly in iomem"
> >     http://lists.infradead.org/pipermail/linux-arm-kernel/2016-August/450433.html
> >[2] "efi: arm64: treat regions with WT/WC set but WB cleared as memory"
> >     http://lists.infradead.org/pipermail/linux-arm-kernel/2016-August/451491.html
> >[3] T.B.D.
> >[4] https://github.com/crash-utility/crash.git
> 
> Are you going to rebase your patch series onto v4.9-rc1 tag soon? I see

Yes, definitely as soon as possible! (actually I've done it.)
But before submitting a new version, I need to convince Rob (Herring)
that he would accept my old approach (v25) regarding specifying usable
memory for crash dump kernel:
   http://lists.infradead.org/pipermail/linux-arm-kernel/2016-September/459379.html 

> that patches [1] and [2] are already in v4.9-rc1, but when tried to apply
> this series, I've got conflict on first patch of the series ("arm64: kdump:
> reserve memory for crash dump kernel"). I want to try arm64 kdump
> patches again on my board, so I'm interested in this. The question is
> whether I need to rebase it myself or you will do the same (and address
> comments) soon.

Thank you for your interests and sorry for any inconvenience.

-Takahiro AKASHI

> Also I see Geoff published v6 of arm64 kexec-tools patches, so same
> question is applicable to "(kexec-tools) arm64: add kdump support"
> patch series.
> 
> Thanks,
> Ruslan
> 
