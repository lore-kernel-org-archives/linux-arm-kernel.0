From: broonie@kernel.org (Mark Brown)
Date: Wed, 19 Feb 2014 12:38:01 +0900
Subject: PMIC driver prevents gpio-leds to work
In-Reply-To: <CAOMZO5DWkxv8q+1+LsOYPPLqxXCAW2q9LRXyn-zV-SSSW10AwQ@mail.gmail.com>
References: <CAOMZO5D0fa0yzwQbNLG_=oJ_8_WBBqWBF=D9QzSwLwC0jh+deQ@mail.gmail.com>
 <1392749026.163265479@f312.i.mail.ru>
 <CAOMZO5DWkxv8q+1+LsOYPPLqxXCAW2q9LRXyn-zV-SSSW10AwQ@mail.gmail.com>
Message-ID: <20140219033801.GN2669@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Feb 18, 2014 at 03:59:27PM -0300, Fabio Estevam wrote:

> I thought that 'regulator-always-on' was enough, but I also need
> 'regulator-boot-on' as well.

That sounds wrong, like something is forgetting to do an enable at some
point or there's some problem with the enable operation.  What's the
actual root cause here?  boot-on should really only be needed for
regulators where you can't read the status.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140219/29c12895/attachment.sig>
