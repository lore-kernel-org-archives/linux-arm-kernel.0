From: broonie@kernel.org (Mark Brown)
Date: Fri, 18 Oct 2013 00:36:07 +0100
Subject: [PATCH 1/3] ALSA: pxa: slightly refactor reset handling
In-Reply-To: <1382004097-6350-1-git-send-email-dbaryshkov@gmail.com>
References: <1382004097-6350-1-git-send-email-dbaryshkov@gmail.com>
Message-ID: <20131017233607.GW2443@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Oct 17, 2013 at 02:01:35PM +0400, Dmitry Eremin-Solenikov wrote:
> PXA25x also shows some problems when using interrupts during reset
> handling. Thus do not use interrupts on all pxa kinds (to detect codec
> ready state). Instead use a common mdelay-loop on all platforms to
> detect codecs becoming ready.

Applied all, thanks.  I'm somewhat surprised nobody noticed the reset
issues on the pxa25x before - this stuff all got really heavily tested
back in the day.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20131018/98e1ba80/attachment.sig>
