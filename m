From: gabriel.fernandez@linaro.org (Gabriel Fernandez)
Date: Mon, 30 May 2016 09:30:06 +0200
Subject: [STLinux Kernel] [PATCH 02/11] drivers: clk: st: Add clock
 propagation for audio clocks
In-Reply-To: <20160527154159.GA17818@rob-hp-laptop>
References: <1463560892-7209-1-git-send-email-gabriel.fernandez@linaro.org>
 <1463560892-7209-3-git-send-email-gabriel.fernandez@linaro.org>
 <20160525172409.GA27913@rob-hp-laptop>
 <CAG374jDTCJfZB+PuAnggjXhbcd3NjJqrESpe_EnMniCAeoph9A@mail.gmail.com>
 <CAL_JsqLOG4P0H+HkQ3mJhfibatuV2T51KqOn-+U+LK8WUx7QgA@mail.gmail.com>
 <5746F486.602@st.com>
 <CAL_JsqLeD8uTmMYLFZ5Sh9=JV5s1xthvruXL-W=c=zcVS=G-ZA@mail.gmail.com>
 <5747F5E8.5030300@st.com> <20160527154159.GA17818@rob-hp-laptop>
Message-ID: <CAG374jBTLDiXHQVuxKMA2-xZr1yHUBLmSdT2HAZhp16dTsQDoQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 27 May 2016 at 17:41, Rob Herring <robh@kernel.org> wrote:
> On Fri, May 27, 2016 at 09:23:20AM +0200, loic pallardy wrote:
>>
>>
>> On 05/26/2016 03:20 PM, Rob Herring wrote:
>> >On Thu, May 26, 2016 at 8:05 AM, loic pallardy <loic.pallardy@st.com> wrote:
>> >>
>> >>
>> >>On 05/26/2016 02:46 PM, Rob Herring wrote:
>> >>>
>> >>>On Thu, May 26, 2016 at 4:49 AM, Gabriel Fernandez
>> >>><gabriel.fernandez@linaro.org> wrote:
>> >>>>
>> >>>>On 25 May 2016 at 19:24, Rob Herring <robh@kernel.org> wrote:
>> >>>>>
>> >>>>>
>> >>>>>On Wed, May 18, 2016 at 10:41:23AM +0200, Gabriel Fernandez wrote:
>> >>>>>>
>> >>>>>>This patch allows fine tuning of the quads FS for audio clocks
>> >>>>>>accuracy.
>> >>>>>>
>
>> >>>
>> >>>That is no different and suffers the same point I raised. It requires
>> >>>updating the DT for any clock configuration change or enhancement.
>> >>>
>> >>Agree with you, DT update is needed as soon as a clock configuration should
>> >>be changed. This is due to STiH clock driver design based on DT description
>> >>of SoC clock tree.
>> >>
>> >>This clock driver was accepted 2 years ago. At the time being there was
>> >>discussion about clock tree description location: driver or DT.
>> >>Bad choice was done for this driver...
>> >>
>> >>If we decide to redesign STiH clock driver using in-driver clock tree
>> >>description, this will modify STiH clock DT nodes description and so break
>> >>DT backward compatibility.
>> >>
>> >>What's from your pov the best option?
>> >
>> >You can break it once or every time you need a clock change. I'd go
>> >with the former. Maybe more specific compatible strings throughout
>> >alone would be enough rather than a flag day changing the binding.
>>
>> So if I understand you correctly, main issue is d0 and d2 signification.
>> d0 and d2 are indeed location of the flexgen in the SoC. But that's right
>> flexgen are dedicated to clocks generation for features (system, audio,
>> video).
>> What about "st,flexgen-audio" and "st,flexgen-video"?
>
> It is not so much the name of these 2, but whether there are other cases
> for different clock nodes that could need the same thing. If so, update
> them all now rather than 1 by 1.
>
> Rob

Hi Rob,
Ok i will send a V2 for that.

Mike,
the first patch "drivers: clk: st: Add fs660c32 synthesizer algorithm"  can
be taken into account regardless the remark of Rob. Can you have a look ?

Thanks.
Best Regards

Gabriel
