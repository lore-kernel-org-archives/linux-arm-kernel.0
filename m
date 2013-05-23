From: broonie@kernel.org (Mark Brown)
Date: Thu, 23 May 2013 09:24:19 -0500
Subject: [PATCH] regulator: ab8500-ext: Don't register without
 initialisation data
In-Reply-To: <20130523070905.GD18714@gmail.com>
References: <1369226853-16978-1-git-send-email-lee.jones@linaro.org>
 <1369226853-16978-3-git-send-email-lee.jones@linaro.org>
 <20130522155347.GJ1627@sirena.org.uk>
 <20130522165353.GB18714@gmail.com>
 <20130522174516.GT1627@sirena.org.uk>
 <20130523070905.GD18714@gmail.com>
Message-ID: <20130523142419.GG2412@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 23, 2013 at 08:09:05AM +0100, Lee Jones wrote:
> On Wed, 22 May 2013, Mark Brown wrote:

> > OK, so the regulator driver is buggy and insisting on having constraints
> > passed in for every regulator then?

> If that's not how it's meant to work then, yes.

Yes, that's the intention - it should be possible to just not pass in
anything in and have the driver start up in read only mode (partly to
save having to do things like what you're doing).
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130523/3b48a1f1/attachment.sig>
