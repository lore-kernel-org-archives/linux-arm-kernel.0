From: sboyd@codeaurora.org (Stephen Boyd)
Date: Tue, 1 Sep 2015 11:04:54 -0700
Subject: [PATCH 3/3] soc: qcom: smd: Handle big endian CPUs
In-Reply-To: <20150901050644.GD13472@usrtlx11787.corpusers.net>
References: <1441071594-15941-1-git-send-email-sboyd@codeaurora.org>
 <1441071594-15941-4-git-send-email-sboyd@codeaurora.org>
 <20150901050644.GD13472@usrtlx11787.corpusers.net>
Message-ID: <20150901180453.GC19120@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/31, Bjorn Andersson wrote:
> On Mon 31 Aug 18:39 PDT 2015, Stephen Boyd wrote:
> 
> > The smd structures are always in little endian, but the smd
> > driver is not capable of being used on big endian CPUs. Annotate
> > the little endian data members and update the code to do the
> > proper byte swapping.
> > 
> 
> I think this looks good, but I think it would be better to reference
> the 8-bit entries of the info struct as "flags" rather than INFO8s.
> 
> Could you please change the name of the macros to
> {G,S}ET_{R,T}X_CHANNEL_FLAG() to make the code slightly easier to

Sure. I also found another missing __le32 marking on the "hdr"
stack structure. I'll test out some smd sending before resending
the patches.

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
