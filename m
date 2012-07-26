From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Thu, 26 Jul 2012 16:25:34 +0100
Subject: [PATCH 07/21] ASoC: io: Prevent use of regmap if request fails
In-Reply-To: <501160F5.5050807@linaro.org>
References: <1343298534-13611-1-git-send-email-lee.jones@linaro.org>
 <1343298534-13611-8-git-send-email-lee.jones@linaro.org>
 <20120726113204.GY3099@opensource.wolfsonmicro.com>
 <50112C29.6020606@linaro.org>
 <20120726114215.GB3099@opensource.wolfsonmicro.com>
 <50115961.6060509@linaro.org>
 <20120726151217.GO3099@opensource.wolfsonmicro.com>
 <501160F5.5050807@linaro.org>
Message-ID: <20120726152533.GS3099@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 26, 2012 at 04:23:33PM +0100, Lee Jones wrote:

> What's my 'control data'? It's not used in the original codec patch.

> The old way wants to go:

> snd_soc_update_bits() -> snd_soc_read() -> ab8500_codec_read_reg()

> When then calls back into the abx500.

> So what 'control data' should I be storing in the codec struct?

You're supposed to use it for the data you use to call back into the
underlying I/O code.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120726/759d5343/attachment.sig>
