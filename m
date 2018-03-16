From: jcrouse@codeaurora.org (Jordan Crouse)
Date: Fri, 16 Mar 2018 12:27:01 -0600
Subject: [PATCH 1/2] dt-bindings: Document qcom,adreno-gmu
In-Reply-To: <CAL_Jsq+OJ0jon2uFb6oMKjZuw4iPQxkxfBrbDyMN-BrNZfTRzA@mail.gmail.com>
References: <20180302215638.6145-1-jcrouse@codeaurora.org>
 <20180302215638.6145-2-jcrouse@codeaurora.org>
 <CAL_Jsq+OJ0jon2uFb6oMKjZuw4iPQxkxfBrbDyMN-BrNZfTRzA@mail.gmail.com>
Message-ID: <20180316182701.GC28808@jcrouse-lnx.qualcomm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Mar 05, 2018 at 01:38:59PM -0600, Rob Herring wrote:
> On Fri, Mar 2, 2018 at 3:56 PM, Jordan Crouse <jcrouse@codeaurora.org> wrote:
> > Document the device tree bindings for the Adreno GMU device
> > available on Adreno a6xx targets.
> >
> > Change-Id: I3cfd5fb35ab0045e39905ff12393006e60f1a124
> 
> Gerrit!
> 
> > Signed-off-by: Jordan Crouse <jcrouse@codeaurora.org>
> > ---
> >  .../devicetree/bindings/display/msm/gmu.txt        | 54 ++++++++++++++++++++++
> >  .../devicetree/bindings/display/msm/gpu.txt        | 10 +++-
> >  2 files changed, 62 insertions(+), 2 deletions(-)
> >  create mode 100644 Documentation/devicetree/bindings/display/msm/gmu.txt
> >
> > diff --git a/Documentation/devicetree/bindings/display/msm/gmu.txt b/Documentation/devicetree/bindings/display/msm/gmu.txt
> > new file mode 100644
> > index 000000000000..f65bb49fff36
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/display/msm/gmu.txt
> > @@ -0,0 +1,54 @@
> > +Qualcomm adreno/snapdragon GMU (Graphics management unit)
> > +
> > +The GMU is a programmable power controller for the GPU. the CPU controls the
> > +GMU which in turn handles power controls for the GPU.
> > +
> > +Required properties:
> > +- compatible:
> > +  * "qcom,adreno-gmu"
> 
> Kind of generic. All the features are discoverable?

I was just prepping a new version and I realized I never responded to this.
Sorry.

Yes, all the features are discoverable. Since the GMU is on the same die as the
GPU we would use the GPU revision as the criteria for applying hardware
workarounds and whatnot. I can't think of any current situation that would
require us to uniquely identify the GMU from DT.

Jordan

-- 
The Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
