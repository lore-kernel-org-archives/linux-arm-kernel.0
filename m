From: soren.brinkmann@xilinx.com (=?utf-8?B?U8O2cmVu?= Brinkmann)
Date: Fri, 9 Aug 2013 10:48:05 -0700
Subject: Enable arm_global_timer for Zynq brakes boot
In-Reply-To: <20130809172757.GD14845@codeaurora.org>
References: <15e19315-ce88-4d3c-bad9-0a37d9e52f6b@CO1EHSMHS007.ehs.local>
 <51F99747.4060901@linaro.org>
 <a48f159a-e88c-42fa-b76b-662302d3a585@AM1EHSMHS003.ehs.local>
 <51FA9AE8.1060004@linaro.org>
 <1c83c081-60c6-49e3-a85c-f64dd5be0e60@CH1EHSMHS030.ehs.local>
 <51FA9F54.3060704@linaro.org>
 <c44e700d-64da-487b-a975-1263d7505371@CH1EHSMHS043.ehs.local>
 <5204C54A.9020105@st.com> <5204FA5D.3060908@linaro.org>
 <20130809172757.GD14845@codeaurora.org>
Message-ID: <3a4049f6-aad6-4730-86e3-210afbc3836b@DB9EHSMHS028.ehs.local>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Aug 09, 2013 at 10:27:57AM -0700, Stephen Boyd wrote:
> On 08/09, Daniel Lezcano wrote:
> > 
> > yes, but at least the broadcast mechanism should send an IPI to cpu0 to
> > wake it up, no ? As Stephen stated this kind of configuration should has
> > never been tested before so the tick broadcast code is not handling this
> > case properly IMHO.
> > 
> 
> If you have a per-cpu tick device that isn't suffering from
> FEAT_C3_STOP why wouldn't you use that for the tick versus a
> per-cpu tick device that has FEAT_C3_STOP? It sounds like there
> is a bug in the preference logic or you should boost the rating
> of the arm global timer above the twd. Does this patch help? It
> should make the arm global timer the tick device and whatever the
> cadence timer you have into the broadcast device.

I'm not sure I'm getting this right. But neither the cadence_ttc nor the
arm_global_timer have the FEAT_C3_STOP flag set. So, shouldn't they be
treated equally even with your change?

	S?ren
