From: broonie@kernel.org (Mark Brown)
Date: Fri, 1 Jul 2016 18:11:05 +0200
Subject: [alsa-devel] [PATCH v5 7/9] ASoC: bt-sco: extend rate and add a
 general compatible string
In-Reply-To: <1467341386.21689.6.camel@mtksdaap41>
References: <1466149440-23889-1-git-send-email-garlic.tseng@mediatek.com>
 <1466149440-23889-8-git-send-email-garlic.tseng@mediatek.com>
 <20160629191500.GU6247@sirena.org.uk>
 <1467291345.11091.16.camel@mtksdaap41>
 <1467341386.21689.6.camel@mtksdaap41>
Message-ID: <20160701161105.GY6247@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 01, 2016 at 10:49:46AM +0800, Garlic Tseng wrote:
> On Thu, 2016-06-30 at 20:55 +0800, Garlic Tseng wrote:

> > If you worry about some potential risk (I don't see any) maybe we have
> > to develop another dummy bt-sco codec driver which support both 8k and
> > 16k?

> Ah! If someone whose bluetooth modules only support 8k use the driver,
> they might be broken, right? Maybe we can add another snd_soc_dai_driver
> which can support both 8k and 16k.
> (Actually I found the issue is discussed before
> http://mailman.alsa-project.org/pipermail/alsa-devel/2014-November/084687.html )

Yes, that'd be fine - it could be the same driver and register different
parameters depending on config/compatible.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160701/c7971a12/attachment.sig>
