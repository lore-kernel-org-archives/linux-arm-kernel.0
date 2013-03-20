From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Wed, 20 Mar 2013 09:23:18 +0100
Subject: [PATCH V4 6/9] ARM: mxs: Provide regulator to pwm-backlight
In-Reply-To: <5148E252.9050900@wwwdotorg.org>
References: <1363719573-20926-1-git-send-email-achew@nvidia.com>
 <1363719573-20926-7-git-send-email-achew@nvidia.com>
 <201303192227.21717.marex@denx.de> <5148E252.9050900@wwwdotorg.org>
Message-ID: <20130320082318.GA28775@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Mar 19, 2013 at 04:10:26PM -0600, Stephen Warren wrote:
> On 03/19/2013 03:27 PM, Marek Vasut wrote:

> > Do we really need a mandatory regulator? Why can't it be optional?

> IIRC, the previous advice I've seen is that if a device (driver) uses a
> regulator, it must /require/ a regulator, and if a particular board
> doesn't actually have a SW-controlled regulator, then a fixed- or dummy-
> regulator should be provided to satisfy this requirement.

> CC'ing Mark Brown to make sure I really do Recall Correctly.

Yes, and it should be fixed rather than dummy.  The issue is partly that
it's probably important that the device has power so we don't want to
just ignore errors and partly that this is something which applies to
essentially all devices so whatever we do for this case ought to be done
by the core so all devices can benefit and we don't have to duplicate
lots of code in individual drivers.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130320/4d5a045b/attachment-0001.sig>
