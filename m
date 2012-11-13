From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Tue, 13 Nov 2012 15:35:50 +0900
Subject: [PATCH] RFC: pinctrl: grab default handler with bus notifiers
In-Reply-To: <50A15A54.3090803@wwwdotorg.org>
References: <1352636539-6318-1-git-send-email-linus.walleij@stericsson.com>
 <50A15A54.3090803@wwwdotorg.org>
Message-ID: <20121113063546.GD18224@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 12, 2012 at 01:21:40PM -0700, Stephen Warren wrote:
> On 11/11/2012 05:22 AM, Linus Walleij wrote:

> > Another solution that was discussed was whether to move
> > the default pinctrl handle and state grab to the device
> > core as an optional field in struct device itself, but
> > I'd like to first propose this less intrusive mechanism.

> I think doing that approach makes a lot more sense; wouldn't it
> completely avoid the issues with deferred probe that this notifier-based
> method can't solve? It would also be very much in line with e.g.
> dev_get_regmap() - if every resource that a driver required were handled
> like that, then deferred probe could be significantly isolated into the
> driver core rather than in every driver...

I have to say that I agree with this, notifiers seem to make life more
complicated for limited gain.  Otherwise I guess we could enhance
notifiers so that they're able to trigger deferrals?
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20121113/1dba210d/attachment.sig>
