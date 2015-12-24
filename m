From: yingjoe.chen@mediatek.com (Yingjoe Chen)
Date: Thu, 24 Dec 2015 16:10:43 +0800
Subject: [PATCH] regulator: mt6397: convert to arch_initcall
In-Reply-To: <20151223120019.GU16023@sirena.org.uk>
References: <1450865768-10317-1-git-send-email-henryc.chen@mediatek.com>
 <20151223120019.GU16023@sirena.org.uk>
Message-ID: <1450944643.30352.9.camel@mtksdaap41>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 2015-12-23 at 12:00 +0000, Mark Brown wrote:
> On Wed, Dec 23, 2015 at 06:16:08PM +0800, Henry Chen wrote:
> 
> Please fix your mail client to word wrap within paragraphs at something
> substantially less than 80 columns.  Doing this makes your messages much
> easier to read and reply to.
> 
> > Due to some device may need reulator operation in earlier boot time like gpu module which
> > power domain need regulator power on first. Move regulator of mt6397
> > initialization earlier in boot so that real devices can use regulator
> > without probe deferring.
> 
> Several problems here.  One is that we usually use subsys_initcall() for
> working around the known broken subsystems here, why have you decided to
> go for arch_initcall() instead.  Another is that you're saying this is
> for GPUs but I'm not aware of any reason why GPUs are broken and we
> should not be introducing new problems here - what's going on?


These changes are related to pinctrl init order patch. The related
discussion is here:
http://lists.infradead.org/pipermail/linux-mediatek/2015-December/003298.html

and these should really be a series:

mediatek pwrap
http://lists.infradead.org/pipermail/linux-mediatek/2015-December/003347.html
mt6397 MFD core
http://lists.infradead.org/pipermail/linux-mediatek/2015-December/003348.html
mt6397 regulator
http://lists.infradead.org/pipermail/linux-mediatek/2015-December/003349.html


I think Henry use arch_initcall because that's what pinctrl patch was
using. In this case, we should use subsys_initcall for all these.

Joe.C
