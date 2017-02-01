From: will.deacon@arm.com (Will Deacon)
Date: Wed, 1 Feb 2017 16:33:58 +0000
Subject: [PATCH v4 2/4] arm64: Work around Falkor erratum 1003
In-Reply-To: <b4cf83d2-ae05-3362-bc23-2341d00516dc@codeaurora.org>
References: <20170125155232.10277-1-cov@codeaurora.org>
 <20170125155232.10277-2-cov@codeaurora.org>
 <20170131123735.GD11191@leverpostej>
 <36478002-4cd8-7f1c-1a25-8bfe35022a47@codeaurora.org>
 <3cab36fb-984a-beae-64db-6ce830ba94f6@arm.com>
 <b4cf83d2-ae05-3362-bc23-2341d00516dc@codeaurora.org>
Message-ID: <20170201163358.GG8177@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 01, 2017 at 11:29:22AM -0500, Christopher Covington wrote:
> On 01/31/2017 12:56 PM, Marc Zyngier wrote:
> > Given that all ARMv8 CPUs can support SW_PAN, it is more likely to be
> > enabled than the ARMv8.1 PAN. I'd vote for supporting the workaround in
> > that case too, and hope that people do enable the HW version.
> 
> Okay, I'll do my best to add support for the SW PAN case. I rebased and
> submitted v6 of the E1009 patch [1] so that it no longer depends on this
> patch landing first, if you all are inclined to pick it up while work on
> this E1003 patch continues.

The alternative is not enabling SW_PAN (at runtime) if this errata is
present, along with a warning stating that hardware-PAN should be
enabled in kconfig instead. Not sure what distributions will make of that
though.

> 1. https://patchwork.kernel.org/patch/9547923/

Yup, I queued that one locally and I'll push to -next tomorrow.

Thanks,

Will
