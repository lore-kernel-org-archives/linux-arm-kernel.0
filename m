From: broonie@kernel.org (Mark Brown)
Date: Fri, 10 May 2013 10:30:07 +0100
Subject: [PATCH 1/3] driver core: Add API to wait for deferred probe to
 complete during init
In-Reply-To: <CACxGe6sO7kEZgg6km4bzP1cq+2MqGb=D4cZbuWELoz+yhaO6KQ@mail.gmail.com>
References: <1368076726-11492-1-git-send-email-skannan@codeaurora.org>
 <1368076726-11492-2-git-send-email-skannan@codeaurora.org>
 <CACVXFVMd_iRtEM8ZLK6Ps66gZO6SCp1mXSgY6JbWtRJjJUh+ag@mail.gmail.com>
 <CACxGe6uHBNUcbD9SeRP5c3E8NN-Z2yjVV+9VAhuoJnXoBtTu2w@mail.gmail.com>
 <20130509135017.GD3200@sirena.org.uk>
 <20130509141444.GV18614@n2100.arm.linux.org.uk>
 <CACxGe6sO7kEZgg6km4bzP1cq+2MqGb=D4cZbuWELoz+yhaO6KQ@mail.gmail.com>
Message-ID: <20130510093007.GL3200@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 09, 2013 at 05:39:03PM +0100, Grant Likely wrote:

> +1. You can /minimize/ up-down cycles with the kind of optimization
> that is being attempted here, but the driver still *must* deal with
> bringing resources back up if they get requested "later than you would
> otherwise like".

Now that I think about it we should probably have a debug option like
the shared IRQ testing one which does actually disable all resources as
soon as the kernel gains control of them in order to help with test
coverage for this.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130510/974fe1f2/attachment.sig>
