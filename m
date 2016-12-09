From: sboyd@codeaurora.org (Stephen Boyd)
Date: Thu, 8 Dec 2016 16:26:35 -0800
Subject: [PATCH 3/3] ASoC: simple-card-utils: enable
 clocks/clock-names/clock-ranges
In-Reply-To: <874m2eymu3.wl%kuninori.morimoto.gx@renesas.com>
References: <874m2jvtmw.wl%kuninori.morimoto.gx@renesas.com>
 <87zikbuezr.wl%kuninori.morimoto.gx@renesas.com>
 <20161208220901.GN5423@codeaurora.org>
 <874m2eymu3.wl%kuninori.morimoto.gx@renesas.com>
Message-ID: <20161209002635.GD5423@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12/09, Kuninori Morimoto wrote:
> 
> Hi Stephen
> 
> > > From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> > > 
> > > Current simple-card is supporting this style for clocks
> > > 
> > > 	sound {
> > > 		...
> > > 		simple-audio-card,cpu {
> > > 			sound-dai = <&xxx>;
> > > 			clocks = <&cpu_clock>;
> > > 		};
> > > 		simple-audio-card,codec {
> > > 			sound-dai = <&xxx>;
> > > 			clocks = <&codec_clock>;
> > > 		};
> > > 	};
> > > 
> > > Now, it can support this style too, because we can use
> > > devm_get_clk_from_child() now.
> > > 
> > > 	sound {
> > > 		...
> > > 		clocks = <&cpu_clock>, <&codec_clock>;
> > > 		clock-names = "cpu", "codec";
> > > 		clock-ranges;
> > > 		...
> > > 		simple-audio-card,cpu {
> > > 			sound-dai = <&xxx>;
> > > 		};
> > > 		simple-audio-card,codec {
> > > 			sound-dai = <&xxx>;
> > > 		};
> > > 	};
> > > 
> > > Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> > 
> > I don't see any reason why we need this patch though. The binding
> > works as is, so supporting different styles doesn't seem like a
> > good idea to me. Let's just keep what we have? Even if a sub-node
> > like cpu or codec gets more than one element in the clocks list
> > property, we can make that work by passing a clock-name then
> > based on some sort of other knowledge.
> 
> OK, thanks. Let's skip this patch.
> But I believe this idea/method itself is not wrong (?)
> 

Right it's not wrong, just seems confusing to have two methods.

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
