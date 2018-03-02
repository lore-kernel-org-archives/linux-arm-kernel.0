From: wsa@the-dreams.de (Wolfram Sang)
Date: Fri, 2 Mar 2018 11:29:26 +0100
Subject: [PATCH] i2c: s3c2410: Properly handle interrupts of number 0
In-Reply-To: <1519936484-23132-1-git-send-email-krzk@kernel.org>
References: <1519936484-23132-1-git-send-email-krzk@kernel.org>
Message-ID: <20180302102926.fuqmfyaxiujjwill@ninjato>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 01, 2018 at 09:34:44PM +0100, Krzysztof Kozlowski wrote:
> Interrupt number 0 (returned by platform_get_irq()) might be a valid IRQ
> so do not treat it as an error.  If interrupt 0 was configured, the driver
> would exit the probe early, before finishing initialization, but with
> 0-exit status.
> 
> Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
> Cc: stable at vger.kernel.org
> Fixes: e0d1ec97853f ("i2c-s3c2410: Change IRQ to be plain integer.")

Please configure git to use 14 digits here.

> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>

Applied to for-current, thanks!

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180302/998dce37/attachment.sig>
