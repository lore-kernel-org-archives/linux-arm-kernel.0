From: robh@kernel.org (Rob Herring)
Date: Wed, 15 Jun 2016 07:44:32 -0500
Subject: [PATCH v5] ASoC: rockchip: Add machine driver for RK3399 GRU
 Boards
In-Reply-To: <20160615095312.GY2282@sirena.org.uk>
References: <1465807339-1100-1-git-send-email-zhengxing@rock-chips.com>
 <20160614223810.GA7925@rob-hp-laptop> <20160615095312.GY2282@sirena.org.uk>
Message-ID: <CAL_JsqKEDw14HmbW=78_4P03nFDfmT7kOn4RsTF-PrBi+jWr0g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 15, 2016 at 4:53 AM, Mark Brown <broonie@kernel.org> wrote:
> On Tue, Jun 14, 2016 at 05:38:10PM -0500, Rob Herring wrote:
>> On Mon, Jun 13, 2016 at 04:42:18PM +0800, Xing Zheng wrote:
>
>> > +sound {
>> > +   compatible = "rockchip,rk3399-gru-sound";
>> > +   rockchip,cpu = <&i2s0>;
>> > +   rockchip,codec = <&max98357a &rt5514 &da7219>;
>
>> These seem fairly standard though a variety of versions in the bindings.
>> Can we use audio-codec and audio-cpu (or cpu or audio-dai) here? Mark?
>
> Well, the roles aren't actually that standard (the fact that there's
> multiple CODECs and one CPU DAI here is really odd and definitely needs
> a very system specific interpretation).  If they were standard we
> already have the simple-card binding that things should be using.
> There's no point in standard property names if the interpretation has to
> be non-standard.

Okay, I agree with the system specific interpretation part. However, I
don't think using simple-card or not determines using common
properties.

> The vendor specific prefixes are there because all bindings are supposed
> to add prefixes to property names.

...unless they are common.

Rob
