From: broonie@kernel.org (Mark Brown)
Date: Tue, 21 Apr 2015 11:05:15 +0100
Subject: [RESEND RFC PATCH 3/3] ASoC: mediatek: Add AFE platform driver
In-Reply-To: <1429583233.14794.40.camel@mtksdaap41>
References: <1428653649-38200-1-git-send-email-koro.chen@mediatek.com>
 <1428653649-38200-4-git-send-email-koro.chen@mediatek.com>
 <20150418175139.GG26185@sirena.org.uk>
 <1429510944.30743.36.camel@mtksdaap41>
 <20150420205511.GL14892@sirena.org.uk>
 <1429583233.14794.40.camel@mtksdaap41>
Message-ID: <20150421100515.GB22845@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Apr 21, 2015 at 10:27:13AM +0800, Koro Chen wrote:

> The SRAM size to be used is defined by params_buffer_bytes(params), not
> fixed (of course limited by the actual available SRAM size on HW), so
> the latency should be the same compared to a DRAM having the same size. 

Right, some systems have the SRAM as essentially a big FIFO but this
doesn't have that problem.

> The SRAM can be used by any memif, and that's why the plan was let DT
> make the decision.

OK, if it's for any interface rather than just DL1 like Sascha said then
it does need to be selectable, but DT doesn't seem the platce to do it.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150421/9f438000/attachment.sig>
