From: lars@metafoo.de (Lars-Peter Clausen)
Date: Mon, 7 Mar 2016 21:09:32 +0100
Subject: [PATCH v2 1/2] iio: core: introduce IIO_CHAN_INFO_SIGNED
In-Reply-To: <1457360997-29179-2-git-send-email-ludovic.desroches@atmel.com>
References: <1457360997-29179-1-git-send-email-ludovic.desroches@atmel.com>
 <1457360997-29179-2-git-send-email-ludovic.desroches@atmel.com>
Message-ID: <56DDDFFC.5010100@metafoo.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/07/2016 03:29 PM, Ludovic Desroches wrote:
> The same channel can be used to perform a signed or an unsigned
> conversion. Add a new infomask element to be able to select the type of
> conversion wanted: a raw one or a signed raw one.

If this is the difference between offset binary and two's complement then it
makes no sense to expose this at this level. Both are the same number just
in a different representation and converting between them is cheap. A few
magnitudes cheaper than reading the result over sysfs. So, if your device
supports both, just pick one.

For the buffered interface it may make sense to expose this, since the per
sample overhead is a lot lower. But still doing the conversion should be
cheap enough that it does not really matter. Before this is implemented I'd
like to see hard performance numbers that this actually makes a difference.

- Lars
