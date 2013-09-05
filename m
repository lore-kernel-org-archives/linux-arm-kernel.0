From: soren.brinkmann@xilinx.com (=?utf-8?B?U8O2cmVu?= Brinkmann)
Date: Thu, 5 Sep 2013 09:53:13 -0700
Subject: [PATCH 1/2] tick: broadcast: Deny per-cpu clockevents from being
 broadcast sources
In-Reply-To: <1377191201-14696-1-git-send-email-sboyd@codeaurora.org>
References: <52138784.7050703@linaro.org>
 <1377191201-14696-1-git-send-email-sboyd@codeaurora.org>
Message-ID: <5f2b2c3b-ed31-47c8-9008-c338492db7d4@VA3EHSMHS030.ehs.local>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Aug 22, 2013 at 10:06:40AM -0700, Stephen Boyd wrote:
> On most ARM systems the per-cpu clockevents are truly per-cpu in
> the sense that they can't be controlled on any other CPU besides
> the CPU that they interrupt. If one of these clockevents were to
> become a broadcast source we will run into a lot of trouble
> because the broadcast source is enabled on the first CPU to go
> into deep idle (if that CPU suffers from FEAT_C3_STOP) and that
> could be a different CPU than what the clockevent is interrupting
> (or even worse the CPU that the clockevent interrupts could be
> offline).
> 
> Theoretically it's possible to support per-cpu clockevents as the
> broadcast source but so far we haven't needed this and supporting
> it is rather complicated. Let's just deny the possibility for now
> until this becomes a reality (let's hope it never does!).
> 
> Reported-by: S?ren Brinkmann <soren.brinkmann@xilinx.com>
> Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>

Has this been merged anywhere?

	Thanks,
	S?ren
