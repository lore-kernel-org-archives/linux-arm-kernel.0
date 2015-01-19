From: catalin.marinas@arm.com (Catalin Marinas)
Date: Mon, 19 Jan 2015 10:37:39 +0000
Subject: [PATCH v7 06/17] ARM64 / ACPI: Make PCI optional for ACPI on ARM64
In-Reply-To: <20150118092955.GE6182@xora-haswell.xora.org.uk>
References: <1421247905-3749-1-git-send-email-hanjun.guo@linaro.org>
 <1421247905-3749-7-git-send-email-hanjun.guo@linaro.org>
 <20150116094913.GA13634@e104818-lin.cambridge.arm.com>
 <54BB51F1.8000900@linaro.org>
 <508480149.12941388.1421562696311.JavaMail.zimbra@zmail15.collab.prod.int.phx2.redhat.com>
 <54BB56CB.7040701@linaro.org>
 <20150118092955.GE6182@xora-haswell.xora.org.uk>
Message-ID: <20150119103737.GD11835@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Jan 18, 2015 at 09:29:56AM +0000, Graeme Gregory wrote:
> On Sun, Jan 18, 2015 at 02:46:35PM +0800, Hanjun Guo wrote:
> > On 2015?01?18? 14:31, Jon Masters wrote:
> > >Hi Folks,
> > >
> > >Sorry for top posting from bed. The mainstream servers will all likely do
> > > PCIe but there are several that may not. They should not be excluded. That
> > said,
> > >if we booted a previously built kernel on a system without an MCFG and
> > > got no ECAM/root then things would probably still work.
> > >
> > >I think it'll work out either way but for the record there is no requirement to do PCIe on ARM servers that conform to spec.
> > 
> > OK, Catalin already said that was not the main point of the
> > comments for this patch, I think the title and change log
> > of the patch is inconsistent with the code makes Catalin confused,
> > I will update them in next version.
> 
> Well what we are talking about is the presence of CONFIG_PCI=y which even
> in Jons case will be true as he wants to run the same kernel on both
> sets of hardware.
> 
> Now the architecture has PCI support I think its safe to remove the make
> PCI optional part of the patch as this should be handled runtime not
> compile time.

I agree, if we never see a reason to build a kernel image with
!PCI && ACPI, we can simplify this patch.

-- 
Catalin
