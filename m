From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Fri, 30 Mar 2012 10:35:56 +0100
Subject: [PATCH] ARM: S3C64XX: Add basic cpuidle driver
In-Reply-To: <201203301032.54739.heiko@sntech.de>
References: <1323117169-9817-1-git-send-email-broonie@opensource.wolfsonmicro.com>
 <201112061231.22570.heiko@sntech.de>
 <20111222181359.GA19259@sirena.org.uk>
 <201203301032.54739.heiko@sntech.de>
Message-ID: <20120330093556.GA21950@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Mar 30, 2012 at 10:32:54AM +0200, Heiko St?bner wrote:
> Am Donnerstag, 22. Dezember 2011, 19:13:59 schrieb Mark Brown:

> > My plan there for the s3c64xx was to use pm_domain to figure out if the
> > system is idle enough to drop down, I've been adding some pm_runtime
> > support to provide the information to the core to let it figure this out.

> sorry for digging this up again, but do you happen to have some preliminary 
> code laying around for this, that I could "borrow"?

No, sorry.  The big problem is putting all the devices in power domains
since the Samsung port always has every single machine driver directly
register devices.  Until that problem is solved it's not possible to
figure out if we're idle.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120330/75918690/attachment-0001.sig>
