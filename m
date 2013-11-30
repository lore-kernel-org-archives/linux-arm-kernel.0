From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Sat, 30 Nov 2013 15:13:15 +0100
Subject: [RFC PATCH 0/3] DT support for ST micro accelerometers and
 gyroscopes
In-Reply-To: <5299D3BA.8080700@kernel.org>
References: <1384876234-1211-1-git-send-email-maxime.ripard@free-electrons.com>
 <528DF164.8060009@st.com> <20131121131402.GF1029@lukather>
 <52926901.9080004@kernel.org> <20131125094044.GE3176@lukather>
 <5299D3BA.8080700@kernel.org>
Message-ID: <20131130141315.GC3002@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Nov 30, 2013 at 12:02:02PM +0000, Jonathan Cameron wrote:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
> 
> On 11/25/13 09:40, Maxime Ripard wrote:
> > Hi Jonathan,
> > 
> > On Sun, Nov 24, 2013 at 09:00:49PM +0000, Jonathan Cameron wrote:
> >> -----BEGIN PGP SIGNED MESSAGE----- Hash: SHA1
> >> 
> >> On 11/21/13 13:14, Maxime Ripard wrote:
> >>> Hi Denis,
> >>> 
> >>> On Thu, Nov 21, 2013 at 12:41:24PM +0100, Denis CIOCCA wrote:
> >>>> only one point: it's possible to use the same names with DT? (using _ instead of -)
> >>> 
> >>> Yes, it is, but only for i2c as far as I'm aware, and usually the DT compatibles are with - as a separator (I
> >>> looked into the ePAPR, but couldn't get any explanations or requirements on this, even though it's used in all
> >>> of their examples)
> >> 
> >> In other discussions, where the defacto i2c device tree bindings have been followed, the conclusion has been that
> >> to change to a - from _ would result in userspace ABI changes, so whilst no one wants _ the discussion has
> >> concluded we can't really avoid it.
> > 
> > What kind of userspace ABI changes are we talking about?
> IIRC:
> 
> i2c has a generic binding that matches to the name bit of the i2c_device_id
> array.  That is then exported in sysfs.  There are quite a lot of instances
> of underscores out there in these names.  Thus unforutnately they can't
> be changed without possibly breaking userspace.  Typically those same names
> are also output by IIO though obviously we could keep that the same whilst
> changing the dt binding.
> 
> Also the i2c binding allows binding after dropping the vendor prefix which
> is even more 'interesting'. See of_modialias_node in drivers/of/base.c
> 
> I'd therefore argue in favour of just leaving the underscores in existing
> drivers as a nasty bit of legacy and doing our best to not introduce any
> new ones!

Except I'm not removing anything, just adding new stuff. Therefore,
I'm not breaking anything. The existing users of the underscore stuff
in DT will still work, (if some ever exist, last time I checked, it
wasn't the case) just like they used to.

If we have the occasion of having the thing done like it's done
anywhere else, at no cost, I don't get what the issue is.

Especially since these devices are also usable on other buses than
i2c, which make it quite inconsistent from one bus to another.

Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20131130/6c6f0e85/attachment.sig>
