From: lee.jones@linaro.org (Lee Jones)
Date: Tue, 23 Jun 2015 08:06:51 +0100
Subject: [PATCH 8/8] dt: cpufreq: st: Provide bindings for ST's CPUFreq
 implementation
In-Reply-To: <20150623023458.GC16776@linux>
References: <1434987837-24212-1-git-send-email-lee.jones@linaro.org>
 <1434987837-24212-9-git-send-email-lee.jones@linaro.org>
 <20150623023458.GC16776@linux>
Message-ID: <20150623070651.GA3245@x1>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> [Adding Rob]

Rob is not the only DT Maintainer, there are many of them.  The DT
list was CC'ed, which they are all part of.  Adding them all
separately is not required IMO.

> On 22-06-15, 16:43, Lee Jones wrote:
> 
> At least some description was required here on why you need additional
> bindings are what are they.

Sure, I can do that.

> Over that, this patch should have been present before any other
> patches using these bindings.

I've never heard that one before, but it's easy to re-order the set.

> > Cc: devicetree at vger.kernel.org
> > Signed-off-by: Lee Jones <lee.jones@linaro.org>
> > ---
> >  .../devicetree/bindings/cpufreq/cpufreq-st.txt     | 48 ++++++++++++++++++++++
> >  1 file changed, 48 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/cpufreq/cpufreq-st.txt
> > 
> > diff --git a/Documentation/devicetree/bindings/cpufreq/cpufreq-st.txt b/Documentation/devicetree/bindings/cpufreq/cpufreq-st.txt
> > new file mode 100644
> > index 0000000..cfa8952
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/cpufreq/cpufreq-st.txt
> > @@ -0,0 +1,48 @@
> > +Binding for ST's CPUFreq driver
> > +===============================
> 
> OPP-v2 bindings are out now and you can probably use them to make life
> simple, they are part of Rafael's recent pull request:
> https://lkml.org/lkml/2015/6/22/606
> 
> > +Required properties:
> > +-------------------
> > +- compatible		: Supported values are:
> > +				"st,stih407-cpufreq"
> 
> Nodes for virtual devices aren't allowed in DT.

Then why do Exynos, Spear, HREF and Snowball have CPUFreq nodes?

One rule for one ... ?

> > +Required properties [for working voltage scaling]:
> > +-------------------------------------------------
> > +
> > +Located in CPUFreq's node:
> > +
> > +- st,syscfg		: Phandle to Major number register
> > +				First cell: offset to major number
> > +- st,syscfg-eng		: Phandle to Minor number and Pcode registers
> > +				First cell: offset to process code
> > +				Second cell: offset to minor number
> > +
> > +Located in CPU's node:
> > +
> > +- st,opp-list		: Bootloader provided node containing one or more 'opp at X' sub-nodes
> 
> I can see that this will be passed in from the bootloader. But at
> least an example on how exactly things would actually look would have
> been good. In logs if not in this file.

Sure.

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
