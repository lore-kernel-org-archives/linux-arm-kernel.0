From: broonie@kernel.org (Mark Brown)
Date: Wed, 12 Mar 2014 00:40:30 +0000
Subject: [PATCH v3 2/5] mfd: add bcm590xx pmu driver
In-Reply-To: <20140311232545.GP25092@beef>
References: <1394552775-31264-1-git-send-email-mporter@linaro.org>
 <1394552775-31264-3-git-send-email-mporter@linaro.org>
 <20140311160837.GP21216@lee--X1> <20140311221938.GO25092@beef>
 <20140311224517.GA5672@lee--X1> <20140311232545.GP25092@beef>
Message-ID: <20140312004030.GH28112@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Mar 11, 2014 at 07:25:45PM -0400, Matt Porter wrote:
> On Tue, Mar 11, 2014 at 10:45:17PM +0000, Lee Jones wrote:

> > Are there any inter-patch dependencies in the set? If so, we should
> > know about them so we can coordinate a sensible solution.

> Yes, the regulator driver (3/5) that Mark applied is dependent on this
> patch...the regulator driver includes include/linux/mfd/bcm590xx.h.

There's no actual dependency though - the regulator driver can only be
built if the MFD is enabled in Kconfig since it depends on it so until
the MFD is present in the tree it won't get built.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140312/d57ecd17/attachment.sig>
