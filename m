From: broonie@kernel.org (Mark Brown)
Date: Thu, 12 Sep 2013 23:01:38 +0100
Subject: [PATCH RESEND 1/2] i2c: prepare runtime PM support for I2C
 client devices
In-Reply-To: <87eh8trbob.fsf@linaro.org>
References: <1378733679-19500-1-git-send-email-mika.westerberg@linux.intel.com>
 <3397524.g9aUWuArnm@vostro.rjw.lan>
 <20130910213522.GG29403@sirena.org.uk>
 <2029393.u6DaKBPszu@vostro.rjw.lan> <522FC0DC.9030708@intel.com>
 <87eh8trbob.fsf@linaro.org>
Message-ID: <20130912220138.GY29403@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 12, 2013 at 02:07:48PM -0700, Kevin Hilman wrote:

> IMO, this decision belongs to the PM domain, not to the core.  We have
> an established legacy with the current core default (auto) and changing
> that means lots of breakage.

Yup.

> The "forbid by default" can just as easily be handled in the PM domain
> for the group of devices that need it, so why not do it there?

Or at the device level - I'd guess most I2C devices won't end up in a
domain outside of ACPI.  Mika's latest version of the patches address
this issue, the default is left alone.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130912/a652a8d3/attachment.sig>
