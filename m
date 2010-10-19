From: anarsoul@gmail.com (Vasily khoruzhick)
Date: Tue, 19 Oct 2010 11:00:15 +0300
Subject: [alsa-devel] [PATCH 00/25] ASoC: Overhaul Samsung drivers
In-Reply-To: <053901cb6f5f$76b9dea0$642d9be0$%kim@samsung.com>
References: <1287471805-17952-1-git-send-email-jassisinghbrar@gmail.com>
	<053901cb6f5f$76b9dea0$642d9be0$%kim@samsung.com>
Message-ID: <20101019110015.49dcb79b@anarsoul-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 19 Oct 2010 16:30:09 +0900
Kukjin Kim <kgene.kim@samsung.com> wrote:

> Jassi Brar wrote:
> > 
> > From: Jassi Brar <jassi.brar@samsung.com>
> > 
> > Hi,
> 
> Hi :-)
> > 
> > Here come patches overhauling the Samsung ASoC support.
> > 
> > The AC97, PCM, SPDIF and ASoC-DMA related code has merely undergone
> > cosmetic changes - symbol, device & driver renaming and file moving.
> > 
> > A new I2S controller driver has been added to manage Samsung SoCs since
> > S3C64XX. Older driver has been changed only as is necessary.
> > Regarding I2S, I have left the s3c24xx series untouched because the
> > controllers are too different to run by a common driver. S3C2412's I2S
> > does have some similarities, but not important enough to warrant impact
> > on new driver design.
> > The new I2S driver has been designed around the notion of features/quirks.
> > The newer SoCs have revised version of I2S_0(usually) than previous ones.
> > So, I2S block is 'specified' in the platform code and the driver works on
> > that configuration.
> > For now, Secondary I2S DAI works only with System-DMAC. I2S-Internal DMA
> > and SRAM will be enabled later.
> > 
> > Testing:-
> >   Simple testing of 5.1 channel and hardware mixing seems to work (though
> > there seems to be some issue with symmetric_rates in soc-core.c which
> > would be tried to fix later as saperate issue).
> >  I would appreciate any test-results for GONI and SMARTQ.
> > 
> > I suggest the patches 13,14,16 & 17 go via Kgene's Tree, and the rest via
> > ASoC
> > tree due to tight dependencies.
> 
> Hmm...in my opinion, it would be better to me if could send arch/arm/ stuff
> to upstream via my tree even though there are dependencies.
> Mark, how do you think?

As for me, that's not a good idea. We'll get massive breakage during
2.6.37 merge window then. Here's example: my sound-related changes to
machine files are merged through Ben's tree, but these changes aren't
in asoc tree, so Jassi is no aware of them, but now these changes are
outdated a bit due to device renaming. And this introduce compile
breakage.

And if I understood correctly, merging these arch/arm changes through
your tree will result in temporary compile breakage for both trees -
your and asoc.

Keep changes consistent :)

Regards
Vasily
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 198 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20101019/323863c7/attachment.sig>
