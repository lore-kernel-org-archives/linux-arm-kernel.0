From: soren.brinkmann@xilinx.com (=?utf-8?B?U8O2cmVu?= Brinkmann)
Date: Mon, 12 Aug 2013 09:43:42 -0700
Subject: Enable arm_global_timer for Zynq brakes boot
In-Reply-To: <52091014.3040301@codeaurora.org>
References: <1c83c081-60c6-49e3-a85c-f64dd5be0e60@CH1EHSMHS030.ehs.local>
 <51FA9F54.3060704@linaro.org>
 <c44e700d-64da-487b-a975-1263d7505371@CH1EHSMHS043.ehs.local>
 <5204C54A.9020105@st.com> <5204FA5D.3060908@linaro.org>
 <20130809172757.GD14845@codeaurora.org>
 <c1e112a3-cfed-4e53-951e-b1a9208d7dc8@TX2EHSMHS038.ehs.local>
 <52090B43.9090000@codeaurora.org>
 <b246ae2f-4841-4bc0-80b3-0bd65269b83f@CH1EHSMHS039.ehs.local>
 <52091014.3040301@codeaurora.org>
Message-ID: <70974708-d076-4123-a62a-f5d18e7b145c@CH1EHSMHS007.ehs.local>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Aug 12, 2013 at 09:40:52AM -0700, Stephen Boyd wrote:
> On 08/12/13 09:24, S?ren Brinkmann wrote:
> > On Mon, Aug 12, 2013 at 09:20:19AM -0700, Stephen Boyd wrote:
> >> On 08/12/13 09:03, S?ren Brinkmann wrote:
> >>> On Fri, Aug 09, 2013 at 10:27:57AM -0700, Stephen Boyd wrote:
> >>>> On 08/09, Daniel Lezcano wrote:
> >>>>> yes, but at least the broadcast mechanism should send an IPI to cpu0 to
> >>>>> wake it up, no ? As Stephen stated this kind of configuration should has
> >>>>> never been tested before so the tick broadcast code is not handling this
> >>>>> case properly IMHO.
> >>>>>
> >>>> If you have a per-cpu tick device that isn't suffering from
> >>>> FEAT_C3_STOP why wouldn't you use that for the tick versus a
> >>>> per-cpu tick device that has FEAT_C3_STOP? It sounds like there
> >>>> is a bug in the preference logic or you should boost the rating
> >>>> of the arm global timer above the twd. Does this patch help? It
> >>>> should make the arm global timer the tick device and whatever the
> >>>> cadence timer you have into the broadcast device.
> >>> I finally got to test your patch. Unfortunately, it makes the system
> >>> hang even earlier:
> >> Sorry it had a bug depending on the registration order. Can you try this
> >> one (tabs are probably spaces, sorry)? I will go read through this
> >> thread to see if we already covered the registration order.
> > What is the base for your patch? I based my GT enable patch on 3.11-rc3
> > and for consistency in our debugging, I didn't move it elsewhere since.
> > Your patch doesn't apply cleanly on it. I see if I can work it out, just
> > let me know if it depends on something not available in 3.11-rc3.
> 
> I applied this on 3.11-rc4. I don't think anything has changed there
> between rc3 and rc4. so you're probably running into the whitespace problem.

That or the scissors are my problem. I never worked with scissors and it
looks kinda odd what happened when I am'ed the patch. Anyway, I just
manually merged it in.

	S?ren
