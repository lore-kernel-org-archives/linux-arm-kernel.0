From: bjorn.andersson@linaro.org (Bjorn Andersson)
Date: Wed, 25 May 2016 21:48:10 -0700
Subject: [PATCH] soc: qcom: provide mechanism for drivers to access L2
 registers
In-Reply-To: <e0173486-896e-4897-702a-ccd1c1f6c609@codeaurora.org>
References: <1463771587-7438-1-git-send-email-nleeder@codeaurora.org>
 <20160523172527.GK4976@leverpostej>
 <f49d58ed-38b4-6284-11c2-8708d8443b14@codeaurora.org>
 <20160524112326.GC25374@leverpostej>
 <e0173486-896e-4897-702a-ccd1c1f6c609@codeaurora.org>
Message-ID: <20160526044810.GW1256@tuxbot>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue 24 May 12:54 PDT 2016, Neil Leeder wrote:

> 
> 
> On 5/24/2016 07:23 AM, Mark Rutland wrote:
> > On Mon, May 23, 2016 at 02:22:59PM -0400, Neil Leeder wrote:
> >>
> >> On 5/23/2016 01:25 PM, Mark Rutland wrote:
> >>> On Fri, May 20, 2016 at 03:13:07PM -0400, Neil Leeder wrote:
> 
> >>>> Signed-off-by: Neil Leeder <nleeder@codeaurora.org>
> >>>> ---
> >>>>  drivers/soc/qcom/Kconfig              |  9 +++++
> >>>>  drivers/soc/qcom/Makefile             |  1 +
> >>>>  drivers/soc/qcom/l2-accessors.c       | 66 +++++++++++++++++++++++++++++++++++
> >>>>  include/linux/soc/qcom/l2-accessors.h | 27 ++++++++++++++
> >>>>  4 files changed, 103 insertions(+)
> >>>>  create mode 100644 drivers/soc/qcom/l2-accessors.c
> >>>>  create mode 100644 include/linux/soc/qcom/l2-accessors.h
> >>>
> >>> These are awfully generic file names (and function names). Which SoCs
> >>> does this apply to?
> >>>
> >>> It would be good to give these more specific names.
> >>
> >> It's under soc/qcom, and dependent on ARCH_QCOM and (in v2) also on ARM64. It applies to all QCOM ARM64 SoCs.
> > 
> > Per Christopher's comment, it sounds like this applies to QDF24xx.
> > 
> > Given that the code uses IMPLEMENTATION DEFINED system registers, I
> > presume that this does not apply to MSM8916 which uses Cortex-A53, for
> > example (though perhaps it does, and I am mistaken).
> > 
> >> Given that it can only be used in a QCOM driver, and the include path has qcom in it, I'd
> >> prefer not to add redundancy by adding another qcom in there.
> > 
> > I'm not asking for another "qcom", but simply the SoC variant or family
> > (e.g. "qdf24xx" would be fine).
> > 
> 
> It applies to all ARMv8 SoCs with QCOM processors in them. So QDF24xx
> and mobile 820, but not SoCs with ARM processors in them such as
> MSM8916. So neither msm_ nor qdf_ are accurate prefixes.

What's the code name for the SoC in QDF24xx? The 820 is Kryo, is it the
same core in QDF24xx or does that have some other name.

We should try to pick something adding value, not adding another generic
thing.

> As Timur pointed out, the majority of source files in drivers/soc/qcom
> don't have any prefix, which is a reason why I didn't include one.
> 

There's no reason to add a generic "qcom" to the qcom folder, if
anything we should drop the "qcom" prefix of the only one in there.

Regards,
Bjorn
