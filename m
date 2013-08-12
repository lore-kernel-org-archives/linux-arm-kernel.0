From: soren.brinkmann@xilinx.com (=?utf-8?B?U8O2cmVu?= Brinkmann)
Date: Mon, 12 Aug 2013 09:17:28 -0700
Subject: Enable arm_global_timer for Zynq brakes boot
In-Reply-To: <5209088E.20404@linaro.org>
References: <a48f159a-e88c-42fa-b76b-662302d3a585@AM1EHSMHS003.ehs.local>
 <51FA9AE8.1060004@linaro.org>
 <1c83c081-60c6-49e3-a85c-f64dd5be0e60@CH1EHSMHS030.ehs.local>
 <51FA9F54.3060704@linaro.org>
 <c44e700d-64da-487b-a975-1263d7505371@CH1EHSMHS043.ehs.local>
 <5204C54A.9020105@st.com> <5204FA5D.3060908@linaro.org>
 <20130809172757.GD14845@codeaurora.org>
 <c1e112a3-cfed-4e53-951e-b1a9208d7dc8@TX2EHSMHS038.ehs.local>
 <5209088E.20404@linaro.org>
Message-ID: <ca0a49c2-37c8-4ff8-bc02-22158633d469@TX2EHSMHS012.ehs.local>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Aug 12, 2013 at 06:08:46PM +0200, Daniel Lezcano wrote:
> On 08/12/2013 06:03 PM, S?ren Brinkmann wrote:
> > On Fri, Aug 09, 2013 at 10:27:57AM -0700, Stephen Boyd wrote:
> >> On 08/09, Daniel Lezcano wrote:
> >>>
> >>> yes, but at least the broadcast mechanism should send an IPI to cpu0 to
> >>> wake it up, no ? As Stephen stated this kind of configuration should has
> >>> never been tested before so the tick broadcast code is not handling this
> >>> case properly IMHO.
> >>>
> >>
> >> If you have a per-cpu tick device that isn't suffering from
> >> FEAT_C3_STOP why wouldn't you use that for the tick versus a
> >> per-cpu tick device that has FEAT_C3_STOP? It sounds like there
> >> is a bug in the preference logic or you should boost the rating
> >> of the arm global timer above the twd. Does this patch help? It
> >> should make the arm global timer the tick device and whatever the
> >> cadence timer you have into the broadcast device.
> > 
> > I finally got to test your patch. Unfortunately, it makes the system
> > hang even earlier:
> 
> [ ... ]
> 
> Can you boot with maxcpus=1 and then give the result of timer_list ?

That doesn't seem to help anymore. It hangs too. Same picture w/ and w/o
'maxcpus', except for
	[    0.000000] Kernel command line: console=ttyPS0,115200 earlyprintk maxcpus=1


	S?ren
