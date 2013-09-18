From: srinivas.kandagatla@st.com (Srinivas KANDAGATLA)
Date: Wed, 18 Sep 2013 13:57:06 +0100
Subject: [PATCH 2/4] ARM: STi: Supply I2C configuration to STiH416 SoC
In-Reply-To: <84625B87D65BCF478CC1E9C886A4C314DEF1BD9578@SAFEX1MAIL4.st.com>
References: <1379498483-4236-1-git-send-email-maxime.coquelin@st.com>
 <1379498483-4236-3-git-send-email-maxime.coquelin@st.com>
 <20130918120340.GF16984@lee--X1>
 <84625B87D65BCF478CC1E9C886A4C314DEF1BD9578@SAFEX1MAIL4.st.com>
Message-ID: <5239A322.5010004@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 18/09/13 13:46, Maxime COQUELIN wrote:
> On 09/18/2013 02:03 PM, Lee Jones wrote:
>>> >> This patch supplies I2C configuration to STiH416 SoC.
>>> >>
>>> >> Cc: Srinivas Kandagatla <srinivas.kandagatla@st.com>
>>> >> Signed-off-by: Maxime Coquelin <maxime.coquelin@st.com>
>>> >> ---
>>> >>  arch/arm/boot/dts/stih416-pinctrl.dtsi |   35 ++++++++++++++++++++
>>> >>  arch/arm/boot/dts/stih416.dtsi         |   57 ++++++++++++++++++++++++++++++++
>>> >>  2 files changed, 92 insertions(+)
>>> >>
>>> >> diff --git a/arch/arm/boot/dts/stih416-pinctrl.dtsi b/arch/arm/boot/dts/stih416-pinctrl.dtsi
>> > I genuinely don't know the answer to this question, but are these
>> > nodes identical to the ones you've just put in the stih415 DTSI file?
>> > If so, I think it will be worth creating a stih41x DTSI rather than
>> > duplicating lots of stuff unnecessarily.
> There are close to be identical indeed.
> For the clocks and pinctrl, the references names are the same, but they are
> pointing on different nodes, as STiH415 and STiH416 have their own
> clocks and pinctrl dtsi files.
> 
> Srini, what is opinion about this?

There is already a stih41x.dtsi file, but I don't think it is the right
place for the pinctrl nodes there.

Am not OK with the idea of common pinctrl nodes for STiH415 and STiH416
for two reasons.

1> If we common up the pinctrl nodes, it will be very difficult to
accommodate new pinctrls layout which is not guaranteed to be in same
layout in future SOCs.

2> The retiming values in the pinctrl nodes tend to change as per SOC,
so it will be difficult to manage it if we common it up.

Am sure we can come up with a dt layout which can reduce duplication,
but we have to be careful here not to lose the flexiblity to accommodate
new picntrl layouts, new retimings values based on SOC.


thanks,
srini

>> >
