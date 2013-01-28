From: mark.rutland@arm.com (Mark Rutland)
Date: Mon, 28 Jan 2013 09:02:40 +0000
Subject: [PATCH 5/6] ARM: dts: Add basic dts include files for Samsung
 S3C64xx SoCs
In-Reply-To: <016c01cdfb30$64f80430$2ee80c90$@samsung.com>
References: <1358039458-31960-1-git-send-email-tomasz.figa@gmail.com>
 <20130114150531.GE21142@e102568-lin.cambridge.arm.com>
 <20130116105957.GA1963@linaro.org> <3747315.IyCCRDXgbD@flatron>
 <016c01cdfb30$64f80430$2ee80c90$@samsung.com>
Message-ID: <20130128090240.GA7754@e106331-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jan 25, 2013 at 07:15:48PM +0000, Kukjin Kim wrote:
> Tomasz Figa wrote:
> 
> [...]
> 
> > > Well, the number of CPU types does not grow rapidly.  It will be much
> > > less than one per SoC -- so keeping the list up to date shouldn't be
> > > that much effort.
> > >
> > > For ARM1176JZF-S, it could make sense for the comatible list to be
> > >
> > > 	"arm,arm1176jzf-s", "arm,arm1176"
> > >
> > > ...since the differences between 1176 variants are software probeable
> > > (i.e., whether there is an FPU or not).  AFAIK the J, Z apply to all
> > > ARM1176, and the -S (synthesisable RTL) is nothing to do with software.
> > > The kernel probably only really needs to know "arm,arm1176".
> > 
> > OK. So the conclusion is that I should change the cpus node to following:
> > 
> >        cpus {
> >                cpu {
> 
> cpu at 0 { ?

As the CPU has no MPIDR, and thus doesn't have a reg property, there's no reason
to have a unit address. Just "cpu" should be fine.

> 
> >                        compatible = "arm,arm1176jzf-s", "arm,arm1176";
> >                };
> >        };
> > 
> > Am I right?
> > 
> I think so :-)
> 
> - Kukjin
> 

As Dave pointed out, the "jzf-s" portion might be superfluous. It's worth
having the "arm,arm1176", though.

Thanks,
Mark.
