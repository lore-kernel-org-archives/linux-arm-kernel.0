From: broonie@kernel.org (Mark Brown)
Date: Fri, 11 Apr 2014 10:28:56 +0100
Subject: [PATCH v4 2/3] rtc: Add APM X-Gene SoC RTC driver
In-Reply-To: <CAPw-ZTns1EOT0inn0hq0Xh+CdjMkxhOkvL+_BnRThnm7HQC=BQ@mail.gmail.com>
References: <1397155678-26607-1-git-send-email-lho@apm.com>
 <1397155678-26607-2-git-send-email-lho@apm.com>
 <1397155678-26607-3-git-send-email-lho@apm.com>
 <20140410224244.GH6518@sirena.org.uk>
 <CAPw-ZTns1EOT0inn0hq0Xh+CdjMkxhOkvL+_BnRThnm7HQC=BQ@mail.gmail.com>
Message-ID: <20140411092856.GL6518@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Apr 10, 2014 at 09:22:43PM -0700, Loc Ho wrote:

> I was modeled after driver rtc-coh901331.c. It seems like all I need
> here is to call clk_disable_unprepare() instead clk_disable for
> suspend. For resume, call clk_prepare_disable() instead clk_enable().
> No need to split them up. Am I correct?

Yes, the only reason the two operations are split is to support enabling
and disabling in interrupt context but you're not doing that.

> Given that Andrew Morton applied v2, should I post an patch against v2
> going forward?

Yes, once something has been applied you should only be sending
incremental patches.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140411/f3325293/attachment.sig>
