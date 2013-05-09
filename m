From: broonie@kernel.org (Mark Brown)
Date: Thu, 9 May 2013 14:50:17 +0100
Subject: [PATCH 1/3] driver core: Add API to wait for deferred probe to
 complete during init
In-Reply-To: <CACxGe6uHBNUcbD9SeRP5c3E8NN-Z2yjVV+9VAhuoJnXoBtTu2w@mail.gmail.com>
References: <1368076726-11492-1-git-send-email-skannan@codeaurora.org>
 <1368076726-11492-2-git-send-email-skannan@codeaurora.org>
 <CACVXFVMd_iRtEM8ZLK6Ps66gZO6SCp1mXSgY6JbWtRJjJUh+ag@mail.gmail.com>
 <CACxGe6uHBNUcbD9SeRP5c3E8NN-Z2yjVV+9VAhuoJnXoBtTu2w@mail.gmail.com>
Message-ID: <20130509135017.GD3200@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 09, 2013 at 12:50:46PM +0100, Grant Likely wrote:

> However, if a device that shuts down resources after init has
> completed and then cannot turn those resources back on when another
> driver requests them then it sounds like there is a bigger design
> problem. We're in a hotplug world and most of the time a driver cannot
> assume that a resource will never get requested after initcalls have
> completed. It sounds like a design bug in the driver if it cannot
> handle that use case.

Even if the driver copes fine it can still be desirable to avoid the
power down/up cycle if it involves some user visible effect - things
like blinking the display off then on for example.  That said I am a
little suspicious about this approach, it doesn't feel as robust as it
should to go round individual callers.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130509/a652d63c/attachment.sig>
