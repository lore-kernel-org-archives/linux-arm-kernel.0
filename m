From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Thu, 26 Jul 2012 12:42:16 +0100
Subject: [PATCH 07/21] ASoC: io: Prevent use of regmap if request fails
In-Reply-To: <50112C29.6020606@linaro.org>
References: <1343298534-13611-1-git-send-email-lee.jones@linaro.org>
 <1343298534-13611-8-git-send-email-lee.jones@linaro.org>
 <20120726113204.GY3099@opensource.wolfsonmicro.com>
 <50112C29.6020606@linaro.org>
Message-ID: <20120726114215.GB3099@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 26, 2012 at 12:38:17PM +0100, Lee Jones wrote:
> On 26/07/12 12:32, Mark Brown wrote:

> >Again, this makes no sense.  If we're explicitly being asked to use
> >regmap then we should be using regmap or just failing to set up I/O
> >(which is obviously a catastrophic failure).

> How much work is there involved in regmap:ing a device, so that
> dev_get_regmap() doesn't fail?

Trivial if it's on a supported bus, otherwise you just need to write the
bus.  But why do you care if dev_get_regmap() fails?  We only try to use
regmap if the driver asked for regmap I/O (or doesn't have registers at
all in which case it doesn't matter since we never do any I/O).  What
you appear to be saying here is that you're using regmap on a device
which doesn't have a regmap set up which is clearly never going to work
terribly well...
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120726/6f924f01/attachment.sig>
