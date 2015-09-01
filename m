From: sboyd@codeaurora.org (Stephen Boyd)
Date: Tue, 1 Sep 2015 11:03:53 -0700
Subject: [PATCH 2/3] soc: qcom: smd: Use __iowrite32_copy() instead of
 open-coding it
In-Reply-To: <20150901045945.GC13472@usrtlx11787.corpusers.net>
References: <1441071594-15941-1-git-send-email-sboyd@codeaurora.org>
 <1441071594-15941-3-git-send-email-sboyd@codeaurora.org>
 <20150901045945.GC13472@usrtlx11787.corpusers.net>
Message-ID: <20150901180353.GB19120@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/31, Bjorn Andersson wrote:
> On Mon 31 Aug 18:39 PDT 2015, Stephen Boyd wrote:
> 
> > We already have a function to do this and it silences some sparse
> > warnings along the way.
> > 
> 
> Didn't know that, thanks. Do you know why there's no equivalent for
> transfers in the other direction? Should we hack one up to do the same
> simplification in smd_copy_from_fifo()?

Don't know. We can certainly write one although it would be nice
if we had two users. I'll take a look.

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
