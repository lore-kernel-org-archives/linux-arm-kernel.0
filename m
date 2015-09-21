From: broonie@kernel.org (Mark Brown)
Date: Mon, 21 Sep 2015 14:10:53 -0700
Subject: [PATCH v3 12/12] regulator: pwm: properly initialize the ->state
 field
In-Reply-To: <1442828009-6241-13-git-send-email-boris.brezillon@free-electrons.com>
References: <1442828009-6241-1-git-send-email-boris.brezillon@free-electrons.com>
 <1442828009-6241-13-git-send-email-boris.brezillon@free-electrons.com>
Message-ID: <20150921211053.GF30445@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Sep 21, 2015 at 11:33:29AM +0200, Boris Brezillon wrote:
> The ->state field is currently initialized to 0, thus referencing the
> voltage selector at index 0, which might not reflect the current voltage
> value.
> If possible, retrieve the current voltage selector from the PWM state, else
> return -EINVAL.

Acked-by: Mark Brown <broonie@kernel.org>
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150921/b202f168/attachment.sig>
