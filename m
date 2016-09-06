From: takahiro.akashi@linaro.org (AKASHI Takahiro)
Date: Tue, 6 Sep 2016 09:29:59 +0900
Subject: Memory range end be inclusive or exclusive? Re: [PATCH v1 1/4]
 kexec: (bugfix) calc correct end address of memory ranges in device tree
In-Reply-To: <20160801045240.GD7995@linaro.org>
References: <cover.1468970114.git.geoff@infradead.org>
 <3562841.ROYbCgkeeq@hactar>
 <20160727232331.GY1041@n2100.armlinux.org.uk>
 <1860371.lT9GInp2C3@hactar>
 <20160729082714.GA1041@n2100.armlinux.org.uk>
 <1469812346.16559.40.camel@infradead.org>
 <20160729172356.GD1041@n2100.armlinux.org.uk>
 <20160801045240.GD7995@linaro.org>
Message-ID: <20160906002958.GB16712@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Simon,

What is your opinion on this issue?

On Mon, Aug 01, 2016 at 01:52:40PM +0900, AKASHI Takahiro wrote:
> On Fri, Jul 29, 2016 at 06:23:56PM +0100, Russell King - ARM Linux wrote:
> > On Fri, Jul 29, 2016 at 10:12:26AM -0700, Geoff Levand wrote:
> > > On Fri, 2016-07-29 at 09:27 +0100, Russell King - ARM Linux wrote:
> > > 
> > > > So, these functions are a mess and need fixing.
> > > 
> > > Since this change isn't really related to arm64 support, I'll
> > > drop this patch from my series.
> > 
> > Do you have a case which triggers bugs in this code?
> 
> Actually, this patch was necessary when my kdump used "usable-memory"
> properties in "memory" nodes, as on ppc64, to limit the usable memory
> regions that can be used by crash dump kernel.
> Since then, I've moved to the approach of using "mem=" kernel parameter,
> then introducing a new property, "linux,usable-memory-range," under /chosen
> and now we don't need this patch any more.
> 
> So, we can drop it but I still believe that it is buggy.

Due to the discussions[1], I may want to re-enable "usable-memory"
property on arm64. In addition, I would like to add a function,
dtb_add_usable_memory_properties(), a variant of
add_usable_memory_properties(), to kexec/dt-ops.c.
So this issue is quite crucial now.

[1] http://lists.infradead.org/pipermail/linux-arm-kernel/2016-August/452685.html

-Takahiro AKASHI

> Thanks,
> -Takahiro AKASHI
> 
> > -- 
> > RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
> > FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
> > according to speedtest.net.
