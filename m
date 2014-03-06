From: broonie@kernel.org (Mark Brown)
Date: Thu, 6 Mar 2014 17:32:34 +0800
Subject: [PATCH] regulator: helpers: Modify helpers enabling multi-bit
 control
In-Reply-To: <1394053889-7273-1-git-send-email-carlo@caione.org>
References: <1394053889-7273-1-git-send-email-carlo@caione.org>
Message-ID: <20140306093234.GN13126@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 05, 2014 at 10:11:29PM +0100, Carlo Caione wrote:
> This patch extends the regulator helpers to account for device that use
> multiple bits for control when using regmap enable/disable/bypass ops.

I've applied this to unblock your driver, however I think we should just
refactor the interface so that all users need to set enable and disable
values - this will make the code a lot simpler since it's now just
turned into a mass of special cases.  I'll do that myself though.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140306/e3e38420/attachment.sig>
