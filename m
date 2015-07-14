From: broonie@kernel.org (Mark Brown)
Date: Tue, 14 Jul 2015 11:51:55 +0100
Subject: [RFC PATCH 15/15] regulator: pwm: properly initialize the
 ->state field
In-Reply-To: <1435738921-25027-16-git-send-email-boris.brezillon@free-electrons.com>
References: <1435738921-25027-1-git-send-email-boris.brezillon@free-electrons.com>
 <1435738921-25027-16-git-send-email-boris.brezillon@free-electrons.com>
Message-ID: <20150714105155.GS11162@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 01, 2015 at 10:22:01AM +0200, Boris Brezillon wrote:
> The ->state field is currently initialized to 0, thus referencing the
> voltage selector at index 0, which might not reflect the current voltage
> value.

This looks like it'll need reworking on top of Lee's recent changes to
implement continuous voltage support for PWM regulators - we may be
calculating the values to set dynamically at runtime.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150714/e2e961c0/attachment.sig>
