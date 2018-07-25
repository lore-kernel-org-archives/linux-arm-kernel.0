From: robh@kernel.org (Rob Herring)
Date: Wed, 25 Jul 2018 08:00:20 -0600
Subject: [PATCH 1/2] pinctrl: stm32: fix bank io port number
In-Reply-To: <ed56c8d3-f354-d311-8407-66268bcdf7a6@st.com>
References: <1531745857-5561-1-git-send-email-alexandre.torgue@st.com>
 <1531745857-5561-2-git-send-email-alexandre.torgue@st.com>
 <20180720163515.GA16515@rob-hp-laptop>
 <ed56c8d3-f354-d311-8407-66268bcdf7a6@st.com>
Message-ID: <CAL_Jsq+awnVr0qOtyMRYJzDON6k0c-G+bqLYz+WL5LNpigKhpg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 24, 2018 at 10:07 AM Alexandre Torgue
<alexandre.torgue@st.com> wrote:
>
> Hi Rob
>
> On 07/20/2018 06:35 PM, Rob Herring wrote:
> > On Mon, Jul 16, 2018 at 02:57:36PM +0200, Alexandre Torgue wrote:
> >> In case the exti line is not in line with the bank number (that is the case
> >> when there is an hole between two banks, for example GPIOK and then GPIOZ),
> >> use "st,bank-ioport" DT property to get the right exti line.
> >>
> >> Signed-off-by: Amelie Delaunay <amelie.delaunay@st.com>
> >> Signed-off-by: Alexandre Torgue <alexandre.torgue@st.com>
> >>
> >> diff --git a/Documentation/devicetree/bindings/pinctrl/st,stm32-pinctrl.txt b/Documentation/devicetree/bindings/pinctrl/st,stm32-pinctrl.txt
> >> index 9a06e1f..60c678a 100644
> >> --- a/Documentation/devicetree/bindings/pinctrl/st,stm32-pinctrl.txt
> >> +++ b/Documentation/devicetree/bindings/pinctrl/st,stm32-pinctrl.txt
> >> @@ -55,6 +55,8 @@ Optional properties:
> >>      NOTE: If "gpio-ranges" is used for a gpio controller, all gpio-controller
> >>      have to use a "gpio-ranges" entry.
> >>      More details in Documentation/devicetree/bindings/gpio/gpio.txt.
> >> + - st,bank-ioport: should correspond to the EXTI IOport selection (EXTI line
> >> +   used to select GPIOs as interrupts).
> >
> > ioport sounds like something else. Perhaps '-exti-line'?
>
> IOport is actually what is described in our datasheet. I could change it
> to -exti-line but I would prefer to match with the datasheet.

Okay.

Reviewed-by: Rob Herring <robh@kernel.org>
