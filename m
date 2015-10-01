From: yitian.bu@tangramtek.com (yitian)
Date: Thu, 1 Oct 2015 10:39:09 +0800
Subject: [RESEND PATCH 1/1] ASoC: dwc: correct irq clear method
In-Reply-To: <20150930181751.GT15635@sirena.org.uk>
References: <006301d0fac4$94eb5890$bec209b0$@tangramtek.com>
 <20150930181751.GT15635@sirena.org.uk>
Message-ID: <00fe01d0fbf2$5a73cba0$0f5b62e0$@tangramtek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> From: linux-arm-kernel
> [mailto:linux-arm-kernel-bounces at lists.infradead.org] On Behalf Of Mark
> Brown
> Sent: Thursday, October 1, 2015 2:18 AM
> To: yitian <yitian.bu@tangramtek.com>
> Cc: alsa-devel at alsa-project.org; wsa at the-dreams.de;
> linux-kernel at vger.kernel.org; Andrew.Jackson at arm.com; tiwai at suse.com;
> lgirdwood at gmail.com; perex at perex.cz;
> linux-arm-kernel at lists.infradead.org
> Subject: Re: [RESEND PATCH 1/1] ASoC: dwc: correct irq clear method
> 
> On Tue, Sep 29, 2015 at 10:39:00PM +0800, yitian wrote:
> > from Designware I2S datasheet, irq is cleared by reading from
> > TOR/ROR registers, rather than by writing into them.
> 
> This doesn't apply against current code, please check and resend.
Hi Mark:

Thanks for your comments.
Maybe I misunderstand your meaning. Please correct me.

I synced up to latest kernel branch, the code is the same as what this patch
was
generated.

I checked designware I2S spec "version 1.08a June 2014", it specified that
the TOR
and ROR registers are read only and reading the last bit will clear tx/rx
overrun irq.

Also I have checked this register by writing its last bit, the overrun irq
is not cleared.
But if I read the last bit, the overrun irq is cleared. That means the spec
is correct.

Can you please let me know what else I should double check? Thanks.
