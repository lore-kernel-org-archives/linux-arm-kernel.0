From: krzk@kernel.org (Krzysztof Kozlowski)
Date: Mon, 9 Oct 2017 18:59:20 +0200
Subject: [RFC 2/2] phy: exynos5-usbdrd: remove disable and enable of phy
 clk
In-Reply-To: <CANAwSgRmyEqTbw1ZfZhenC8Cs4ffgeYB4vyDNsGeX-zvg92aPw@mail.gmail.com>
References: <1507264595-3565-1-git-send-email-linux.amoon@gmail.com>
 <1507264595-3565-2-git-send-email-linux.amoon@gmail.com>
 <CAJKOXPe9FCKqrvsgdohTAN9tXXwbMOuyaDiHPxZ1Ym1LLPD41w@mail.gmail.com>
 <CANAwSgSbHR+e_2wX3i3VoVxPe10mUOoS94uRpvebfUfybaNQ+g@mail.gmail.com>
 <20171008155015.252gefhsc4tks7k6@kozik-lap>
 <CANAwSgSMFBS8n48=_OnNNs_=Di9Oqq2tNeiwZM9u1qaLevLP4w@mail.gmail.com>
 <CANAwSgRmyEqTbw1ZfZhenC8Cs4ffgeYB4vyDNsGeX-zvg92aPw@mail.gmail.com>
Message-ID: <20171009165920.rha76yayrid6eghz@kozik-lap>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Oct 09, 2017 at 08:46:48PM +0530, Anand Moon wrote:
> hi Krzysztof,
> 
> On 9 October 2017 at 02:37, Anand Moon <linux.amoon@gmail.com> wrote:
> > Hi Krzysztof,
> >
> > On 8 October 2017 at 21:20, Krzysztof Kozlowski <krzk@kernel.org> wrote:
> >> On Sun, Oct 08, 2017 at 06:11:12PM +0530, Anand Moon wrote:
> >>> Hi Krzysztof,
> >>>
> >>> On 6 October 2017 at 12:12, Krzysztof Kozlowski <krzk@kernel.org> wrote:
> >>> > On Fri, Oct 6, 2017 at 6:36 AM, Anand Moon <linux.amoon@gmail.com> wrote:
> >>> >> remove the disable and enable of phy clk.
> >>> >> phy clk is needed to tune the phy controller.
> >>> >
> >>> > Drivers should in general enable and disable the clocks they use. Just
> >>> > like in patch #1 please describe why you are doing this, what kind of
> >>> > problem are you trying to solve and what exactly are you trying to do
> >>> > here.
> >>> >
> >>> > BR,
> >>> > Krzysztof
> >>> >
> >>>
> >>> [snip]
> >>>
> >>> Usually we would disable the clk on error patch and return with failed.
> >>> but in the current code we disable the clk in init routine and
> >>> enable the clk in disable routine which seem incorrect.
> >>
> 
> disable of clk could affect the PMU used to control the phy driver.

Disabling device's clock affects the device but the PMU rather not...
but I might misunderstood you cause this sounds quite unprecise.

Best regards,
Krzysztof
