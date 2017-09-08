From: takahiro.akashi@linaro.org (AKASHI Takahiro)
Date: Fri, 8 Sep 2017 11:54:22 +0900
Subject: [PATCH 14/14] arm64: kexec_file: add vmlinux format support
In-Reply-To: <20170825061353.GB8604@dhcp-128-65.nay.redhat.com>
References: <20170824081811.19299-1-takahiro.akashi@linaro.org>
 <20170824081811.19299-15-takahiro.akashi@linaro.org>
 <20170824173049.GG29665@leverpostej>
 <20170825020348.GA7308@akashi-kouhiroshi-no-MacBook-Air.local>
 <20170825061353.GB8604@dhcp-128-65.nay.redhat.com>
Message-ID: <20170908025421.GE17186@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Aug 25, 2017 at 02:13:53PM +0800, Dave Young wrote:
> On 08/25/17 at 11:03am, AKASHI Takahiro wrote:
> > On Thu, Aug 24, 2017 at 06:30:50PM +0100, Mark Rutland wrote:
> > > On Thu, Aug 24, 2017 at 05:18:11PM +0900, AKASHI Takahiro wrote:
> > > > The first PT_LOAD segment, which is assumed to be "text" code, in vmlinux
> > > > will be loaded at the offset of TEXT_OFFSET from the begining of system
> > > > memory. The other PT_LOAD segments are placed relative to the first one.
> > > 
> > > I really don't like assuming things about the vmlinux ELF file.
> > 
> > If so, vmlinux is not an appropriate format for loading.
> > 
> > > > Regarding kernel verification, since there is no standard way to contain
> > > > a signature within elf binary, we follow PowerPC's (not yet upstreamed)
> > > > approach, that is, appending a signature right after the kernel binary
> > > > itself like module signing.
> > > 
> > > I also *really* don't like this. It's a bizarre in-band mechanism,
> > > without explcit information. It's not a nice ABI.
> > > 
> > > If we can load an Image, why do we need to be able to load a vmlinux?
> > 
> > Well, kexec-tools does. I don't know why Geoff wanted to support vmlinux.
> > I'm just trying to support what kexec-tools does support.
> 
> We only add things when it is really necessary, kexec-tools
> functionalities should have some historic reasons.

Geoff had been working on kexec since old kernels (3.14 or 15?).

> If only for doing kexec-tools has done I would say just not to do it.

Sure

-Takahiro AKASHI

> Thanks
> Dave
