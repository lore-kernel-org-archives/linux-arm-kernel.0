From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Thu, 26 Jul 2012 16:12:17 +0100
Subject: [PATCH 07/21] ASoC: io: Prevent use of regmap if request fails
In-Reply-To: <50115961.6060509@linaro.org>
References: <1343298534-13611-1-git-send-email-lee.jones@linaro.org>
 <1343298534-13611-8-git-send-email-lee.jones@linaro.org>
 <20120726113204.GY3099@opensource.wolfsonmicro.com>
 <50112C29.6020606@linaro.org>
 <20120726114215.GB3099@opensource.wolfsonmicro.com>
 <50115961.6060509@linaro.org>
Message-ID: <20120726151217.GO3099@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 26, 2012 at 03:51:13PM +0100, Lee Jones wrote:

> I don't think we want to use regmap at all, but we're forced to by
> soc-core. How do we over-ride that behavior? By writing some
> nonsense into codec->control_data?

You should use that for your control data, yes - you're not forced to
use regmap at all.  Like I say we've got a bunch of drivers doing so
already.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120726/b69c5c54/attachment.sig>
