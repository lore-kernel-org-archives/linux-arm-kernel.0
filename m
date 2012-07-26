From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Thu, 26 Jul 2012 21:23:11 +0100
Subject: [PATCH 07/21] ASoC: io: Prevent use of regmap if request fails
In-Reply-To: <50116ADF.4050700@linaro.org>
References: <1343298534-13611-1-git-send-email-lee.jones@linaro.org>
 <1343298534-13611-8-git-send-email-lee.jones@linaro.org>
 <20120726113204.GY3099@opensource.wolfsonmicro.com>
 <50112C29.6020606@linaro.org>
 <20120726114215.GB3099@opensource.wolfsonmicro.com>
 <50115961.6060509@linaro.org>
 <20120726151217.GO3099@opensource.wolfsonmicro.com>
 <501160F5.5050807@linaro.org>
 <20120726152533.GS3099@opensource.wolfsonmicro.com>
 <50116ADF.4050700@linaro.org>
Message-ID: <20120726202311.GC4560@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 26, 2012 at 05:05:51PM +0100, Lee Jones wrote:
> On 26/07/12 16:25, Mark Brown wrote:

> >You're supposed to use it for the data you use to call back into the
> >underlying I/O code.

> I don't understand. What 'data'?

Whatever your I/O layer so desires, the core doesn't care.  It's
generally whatever the lower layer that does your I/O takes to identify
the device.

> Surely if .read and .write are populated in 'struct
> snd_soc_codec_driver', then it should just call back into those?

Yes, and in fact that's what we do!
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120726/317693c5/attachment.sig>
