From: broonie@kernel.org (Mark Brown)
Date: Tue, 5 Jul 2016 16:31:35 +0200
Subject: [PATCH v3 11/14] regulator: pwm: Properly initialize the ->state
 field
In-Reply-To: <1465895602-31008-12-git-send-email-boris.brezillon@free-electrons.com>
References: <1465895602-31008-1-git-send-email-boris.brezillon@free-electrons.com>
 <1465895602-31008-12-git-send-email-boris.brezillon@free-electrons.com>
Message-ID: <20160705143135.GY6247@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 14, 2016 at 11:13:19AM +0200, Boris Brezillon wrote:
> The ->state field is currently initialized to 0, thus referencing the
> voltage selector at index 0, which might not reflect the current
> voltage value.
> If possible, retrieve the current voltage selector from the PWM state,
> else return -EINVAL.

Acked-by: Mark Brown <broonie@kernel.org>
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160705/42b0fc2e/attachment.sig>
