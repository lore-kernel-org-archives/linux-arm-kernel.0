From: wens@csie.org (Chen-Yu Tsai)
Date: Fri, 6 Oct 2017 18:25:54 +0800
Subject: [PATCH 13/20] ARM: dts: sun4i: Remove gpio-keys warnings
In-Reply-To: <20171006092757.eexffejnralxlguf@flea>
References: <cover.f5f905a5434f2a540d6844d23369a04af9f5314c.1507198895.git-series.maxime.ripard@free-electrons.com>
 <247d527cb833713f487b97a2c95e30545273ac92.1507198895.git-series.maxime.ripard@free-electrons.com>
 <CAGb2v64df+tQnM1W=KDWNXsnRhEVo2hsTB1YJsPJkzvgw8J1ig@mail.gmail.com>
 <20171006092757.eexffejnralxlguf@flea>
Message-ID: <CAGb2v67muF0J_YsoZSvRSGiHJzJC+-2CS1SDtBhm9bg+Q09gig@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Oct 6, 2017 at 5:27 PM, Maxime Ripard
<maxime.ripard@free-electrons.com> wrote:
> On Thu, Oct 05, 2017 at 03:51:02PM +0000, Chen-Yu Tsai wrote:
>> On Thu, Oct 5, 2017 at 6:49 PM, Maxime Ripard
>> <maxime.ripard@free-electrons.com> wrote:
>> > Some gpio-keys definitions in our DTs were having buttons defined with a
>> > unit-address and that would generate a DTC warning.
>> >
>> > Change the buttons node names to remove the warnings.
>> >
>> > Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
>> > ---
>> >  arch/arm/boot/dts/sun4i-a10-inet9f-rev03.dts | 40 ++++++++++-----------
>> >  arch/arm/boot/dts/sun4i-a10-pcduino.dts      |  6 +--
>> >  2 files changed, 23 insertions(+), 23 deletions(-)
>> >
>> > diff --git a/arch/arm/boot/dts/sun4i-a10-inet9f-rev03.dts b/arch/arm/boot/dts/sun4i-a10-inet9f-rev03.dts
>> > index 7c7f12132ea3..13224f5ac166 100644
>> > --- a/arch/arm/boot/dts/sun4i-a10-inet9f-rev03.dts
>> > +++ b/arch/arm/boot/dts/sun4i-a10-inet9f-rev03.dts
>> > @@ -67,7 +67,7 @@
>> >                 #size-cells = <0>;
>> >                 poll-interval = <20>;
>> >
>> > -               button at 0 {
>> > +               left-joystick-left {
>>
>> Does this fit the naming scheme? Should we have "-button" suffices?
>
> The example binding of gpio-keys just have the key name as node name,
> just like most of the DT out there I could find.

OK. Then

Acked-by: Chen-Yu Tsai <wens@csie.org>

On the topic of having the class in the node name, I'm not aware of
any rules governing it. It feels like I made it up along the way.
I'm not even sure if it is supposed to be context-specific, like
if the node is the pin controller, then all child nodes would be
pin mux settings, and don't need to have "pins" in their names.

So I'm not so sure about this anymore. Feel free to ignore these
types of comments. :)

ChenYu
