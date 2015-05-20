From: sboyd@codeaurora.org (Stephen Boyd)
Date: Tue, 19 May 2015 18:01:44 -0700
Subject: [PATCH v2 1/2] clk: change clk_ops' ->round_rate() prototype
In-Reply-To: <5557267D.7080209@kapsi.fi>
References: <1430407809-31147-1-git-send-email-boris.brezillon@free-electrons.com>
 <1430407809-31147-2-git-send-email-boris.brezillon@free-electrons.com>
 <20150507063953.GC32399@codeaurora.org>
 <20150507093702.0b58753d@bbrezillon>
 <20150515174048.4a31af49@bbrezillon> <5557267D.7080209@kapsi.fi>
Message-ID: <20150520010144.GA31054@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/16, Mikko Perttunen wrote:
> On 05/15/2015 06:40 PM, Boris Brezillon wrote:
> >Hi Stephen,
> >
> >Adding Mikko in the loop (after all, he was the one complaining about
> >this signed long limitation in the first place, and I forgot to add
> >him in the Cc list :-/).
> 
> I think I got it through linux-tegra anyway, but thanks :)
> 
> >
> >Mikko, are you okay with the approach proposed by Stephen (adding a
> >new method) ?
> 
> Yes, sounds good to me. If a driver uses the existing methods with
> too large frequencies, the issue is pretty discoverable anyway. I
> think "adjust_rate" sounds a bit too much like it sets the clock's
> rate, though; perhaps "adjust_rate_request" or something like that?
> 

Well I'm also OK with changing the determine_rate API one more
time, but we'll have to be careful. Invariably someone will push
a new clock driver through some non-clk tree path and we'll get
build breakage. They shouldn't be doing that, so either we do the
change now and push it to -next and see what breaks, or we do
this after -rc1 comes out and make sure everyone has lots of
warning.

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
