From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Thu, 5 Jul 2012 10:45:41 +0100
Subject: [PATCH 1/1] mfd: Fix runtime warning caused by duplicate device
 registration
In-Reply-To: <4FF54406.3000307@linaro.org>
References: <1341316788-12730-1-git-send-email-lee.jones@linaro.org>
 <20120703123552.GC25995@sirena.org.uk>
 <4FF2EEA1.6080204@linaro.org>
 <20120703132447.GN29030@opensource.wolfsonmicro.com>
 <4FF2F82D.9080507@linaro.org>
 <20120703142123.GQ29030@opensource.wolfsonmicro.com>
 <4FF54406.3000307@linaro.org>
Message-ID: <20120705094541.GK4111@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 05, 2012 at 08:36:38AM +0100, Lee Jones wrote:
> On 03/07/12 15:21, Mark Brown wrote:

> >This doesn't explain any of the issues, it just says that they exist.
> >My best guess would be that at least some of the issue is due to
> >instantiating the MFD cells from the device tree but it's hard to say
> >clearly.

> I'm guessing Arnd's email answered some of the questions you had.
> Let me know of you would like me to explain it in any greater
> detail.

No, frankly.  It was just a general "why might we put things in DT"
answer which (especially given what you say below) isn't related to the
issue at all.

> By the way, this patch has nothing to do with registering these
> devices when DT is enabled. The code already does that. This is a
> bug fix, to stop multiple registration of the ab8500 when DT is
> _not_ enabled.

Really?  It seems really surprising that adding more DT support to the
MFD core would have any bearing on something like this...
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120705/1c4ded73/attachment.sig>
