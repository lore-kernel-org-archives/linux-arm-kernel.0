From: mark.rutland@arm.com (Mark Rutland)
Date: Wed, 8 Jan 2014 14:32:35 +0000
Subject: [PATCH v2 2/9] devicetree: bindings: Document qcom,kpss-acc
In-Reply-To: <20140108142541.GK6701@e106331-lin.cambridge.arm.com>
References: <1387845593-10050-1-git-send-email-sboyd@codeaurora.org>
 <1387845593-10050-3-git-send-email-sboyd@codeaurora.org>
 <20140108142541.GK6701@e106331-lin.cambridge.arm.com>
Message-ID: <20140108143235.GA11753@e106331-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 08, 2014 at 02:25:41PM +0000, Mark Rutland wrote:
> On Tue, Dec 24, 2013 at 12:39:46AM +0000, Stephen Boyd wrote:
> > The kpss acc binding describes the clock, reset, and power domain
> > controller for a Krait CPU.
> > 
> > Cc: <devicetree@vger.kernel.org>
> > Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
> > ---
> >  .../devicetree/bindings/arm/msm/qcom,kpss-acc.txt  | 30 ++++++++++++++++++++++
> >  1 file changed, 30 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/arm/msm/qcom,kpss-acc.txt
> > 
> > diff --git a/Documentation/devicetree/bindings/arm/msm/qcom,kpss-acc.txt b/Documentation/devicetree/bindings/arm/msm/qcom,kpss-acc.txt
> > new file mode 100644
> > index 0000000..1333db9
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/arm/msm/qcom,kpss-acc.txt
> > @@ -0,0 +1,30 @@
> > +Krait Processor Sub-system (KPSS) Application Clock Controller (ACC)
> > +
> > +The KPSS ACC provides clock, power domain, and reset control to a Krait CPU.
> > +There is one ACC register region per CPU within the KPSS remapped region as
> > +well as an alias register region that remaps accesses to the ACC associated
> > +with the CPU accessing the region.
> 
> Is the mapping of ACC register to a specific processor well-defined? I
> assume it's just in order of MPIDR.Aff0.
> 
> To maintain our collective sanity in the face of possible future
> implementations, do you have an idea as to whether this might need to be
> extended in future for multiple clusters / reordered IDs and so on?
> 
> I assume we'd just allocate a new compatible string if those get a
> little crazy.

Actually, I'm getting too hung-up on future-proofing. Assuming the
mapping is well-defined for current implementations we can always add an
additional property later if required.

Acked-by: Mark Rutland <mark.rutland@arm.com>

Thanks,
Mark.
