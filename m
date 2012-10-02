From: jgunthorpe@obsidianresearch.com (Jason Gunthorpe)
Date: Tue, 2 Oct 2012 11:50:02 -0600
Subject: [PATCH] [ARM] Build failure CONFIG_ARCH_KIRKWOOD_DT relies on
 CACHE_FEROCEON_L2
In-Reply-To: <CAOesGMhQpqdCRoV85vW+7THstbx+HWmCkR3Q6bpK6uLEmhKqfw@mail.gmail.com>
References: <20120930232253.GD30637@obsidianresearch.com>
 <CAOesGMgpDs60jGsV4Wu-A7M+ThXh7YVkgb_mPgMJfPwNa_QbSw@mail.gmail.com>
 <20121001044337.GA8446@obsidianresearch.com>
 <CAOesGMhQpqdCRoV85vW+7THstbx+HWmCkR3Q6bpK6uLEmhKqfw@mail.gmail.com>
Message-ID: <20121002175002.GD23733@obsidianresearch.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Oct 01, 2012 at 07:31:58AM -0700, Olof Johansson wrote:

> Ah. diff took out the #else in the middle and I didn't look at the
> file. Obviously correct as-is.
> 
> In some other places we choose to put the ifdef outside the function
> and provide a static inline stub in the header file instead. Either
> way works fine though.

I don't actually expect anyone will run CONFIG_ARCH_KIRKWOOD_DT
without CACHE_FEROCEON_L2 - I had thought about just forcing kconfig
to include CACHE_FEROCEON_L2, but figured there was some reason they
were separate.. 

Is there anything further I should do to get this patch upstream?

Thanks,
Jason
