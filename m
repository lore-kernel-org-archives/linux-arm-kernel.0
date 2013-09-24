From: broonie@kernel.org (Mark Brown)
Date: Tue, 24 Sep 2013 16:54:43 +0100
Subject: [PATCH] media: i2c: adv7343: fix the DT binding properties
In-Reply-To: <3002978.Cb6jL1xtkE@avalon>
References: <1379073471-7244-1-git-send-email-prabhakar.csengg@gmail.com>
 <523C1AE0.9020603@samsung.com>
 <CA+V-a8u5_rhxTgkVgCbtmGpaZCt2ciu4vABW4t80aSp7csttnw@mail.gmail.com>
 <3002978.Cb6jL1xtkE@avalon>
Message-ID: <20130924155443.GH3226@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Sep 23, 2013 at 01:50:51PM +0200, Laurent Pinchart wrote:

> Isn't regulator_get_optional() intended for devices that can have supplies 
> unconnected in normal use ? The ADV7343 supplies are mandatory from a hardware 
> point of view, so I think we should use regulator_get(). Otherwise the driver 
> won't be able to tell the difference between a regulator that isn't present 
> yet (for instance because the regulator device/driver hasn't been probed yet), 
> which should result in deferred probing, and an always-on regulator that has 
> been left out.

Yes, everything you say here is correct.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130924/fc1dba98/attachment-0001.sig>
