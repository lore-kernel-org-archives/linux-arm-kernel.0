From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Thu, 26 Jul 2012 15:28:26 +0100
Subject: [PATCH 20/21] ASoC: codecs: Enable AB8500 CODEC for Device Tree
In-Reply-To: <50114D71.9060700@linaro.org>
References: <1343298534-13611-1-git-send-email-lee.jones@linaro.org>
 <1343298534-13611-21-git-send-email-lee.jones@linaro.org>
 <20120726115055.GD3099@opensource.wolfsonmicro.com>
 <50114D71.9060700@linaro.org>
Message-ID: <20120726142825.GK3099@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 26, 2012 at 03:00:17PM +0100, Lee Jones wrote:
> On 26/07/12 12:50, Mark Brown wrote:

> >Yet again no binding documentation....

> RFC. ;)

> I'll write the documentation when/if the properties are accepted.

No, write the documentation.  It's way too much effort to reverse
engineer the bindings from the code.

> >>+		default :
> >>+			codec->ear_cmv = EAR_CMV_UNKNOWN;
> >>+			dev_err(dev, "Unsuitable earpiece voltage found in DT\n");

> >The platform data code picks a default, can't the DT code do the same?

> No, I don't think that it does? The original code returns -EINVAL
> unless a value is specified.

The code doesn't specify values for the enumeration so it ought to
default to EAR_CMV_0_95V if nothing is specified.

> The original author is keen to have a clear error message in case
> users try to specify non-exact values. I'd rather we fail-out than
> use incorrect values which would be a great deal harder for a user
> to debug.

By that argument all the properties should be mandatory but it's only
this one IIRC.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120726/8a444efa/attachment.sig>
