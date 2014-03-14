From: broonie@kernel.org (Mark Brown)
Date: Fri, 14 Mar 2014 12:48:31 +0000
Subject: [PATCH v2 1/3] arm64: dts: add initial dts for Samsung GH7 SoC
 and SSDK-GH7 board
In-Reply-To: <20140313103329.GD5035@e106331-lin.cambridge.arm.com>
References: <1394491879-5320-1-git-send-email-kgene.kim@samsung.com>
 <1394491879-5320-2-git-send-email-kgene.kim@samsung.com>
 <20140311182922.GD3263@e106331-lin.cambridge.arm.com>
 <01c501cf3dac$022879b0$06796d10$@samsung.com>
 <20140313103329.GD5035@e106331-lin.cambridge.arm.com>
Message-ID: <20140314124831.GU366@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 13, 2014 at 10:33:29AM +0000, Mark Rutland wrote:
> On Wed, Mar 12, 2014 at 04:31:56AM +0000, Kukjin Kim wrote:

> > > > +/ {
> > > > +	model = "SAMSUNG SSDK-GH7 board based on GH7 SoC";

> > > Is the "based on GH7 SoC" part necessary? Does the "SSDK-GH7" not give
> > > that away?

> > In this case, yes, SSDK-GH7 is enough but I though, in case of different
> > board adding what SoC is used on the board in that is useful. Anyway, OK.

> Looking at ePAPR, the recommended format is "manufacturer,model", and
> the string is intended to identify a particular implementation. It is
> not intended to give details about the implementation that can be
> derived from the name.

> We seem to have ignored the format (and to some degree purpose) of the
> model property so far, but I don't see any reason to fill it with
> unnecessary information.

Might it be worth defining a property explicitly intended to be used as
a display name for human consumption?  Half the problem with model is
that we don't have a way to use it for quirking so nobody ever really
looks at it (though I guess we will want that at some point now we're
going for fixed ABI stuff), but not having a place to put a pretty name
does encourage this sort of thing.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140314/14d82e38/attachment.sig>
