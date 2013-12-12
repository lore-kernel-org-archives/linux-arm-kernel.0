From: wens@csie.org (Chen-Yu Tsai)
Date: Thu, 12 Dec 2013 12:31:53 +0800
Subject: [PATCH 01/10] net: stmmac: Enable stmmac main clock when probing
 hardware
In-Reply-To: <20131210200529.GD3651@lukather>
References: <1386350983-13281-1-git-send-email-wens@csie.org>
 <1386350983-13281-2-git-send-email-wens@csie.org>
 <20131207103335.GL24519@lukather>
 <CAGb2v65YOSq_BMWSzSHX8w_hbo+0vwquBT2pnLuwNVZkWRfLvA@mail.gmail.com>
 <20131210200529.GD3651@lukather>
Message-ID: <CAGb2v67TkxcMSrFsMtAy8TaMG_VZWt73xZZcuqkJ71VO4y=7_w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Wed, Dec 11, 2013 at 4:05 AM, Maxime Ripard
<maxime.ripard@free-electrons.com> wrote:
> Hi,
>
> On Mon, Dec 09, 2013 at 10:43:29AM +0800, Chen-Yu Tsai wrote:
>> >> @@ -2759,15 +2760,18 @@ struct stmmac_priv *stmmac_dvr_probe(struct device *device,
>> >>               }
>> >>       }
>> >>
>> >> +     clk_disable_unprepare(priv->stmmac_clk);
>> >> +
>> >
>> > Hu? Why do you disable the clock? don't you need it afterwards?
>>
>> The clock is enabled in *_open (when the network interface is used),
>> and disabled in *_close.
>
> Maybe it is the real issue then.
>
> Why don't you move the clk_disable to _remove then?

I wasn't sure this was the proper way. However, looking around, it
seems other drivers enable the clock in, _probe, and disable it in
_remove. I will modify stmmac to do so as well.


ChenYu
