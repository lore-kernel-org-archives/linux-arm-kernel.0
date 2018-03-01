From: broonie@kernel.org (Mark Brown)
Date: Thu, 1 Mar 2018 21:28:44 +0000
Subject: [PATCH v3 10/25] ASoC: qcom: q6asm: Add support to memory map
 and unmap
In-Reply-To: <20180213165837.1620-11-srinivas.kandagatla@linaro.org>
References: <20180213165837.1620-1-srinivas.kandagatla@linaro.org>
 <20180213165837.1620-11-srinivas.kandagatla@linaro.org>
Message-ID: <20180301212844.GU12864@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Feb 13, 2018 at 04:58:22PM +0000, srinivas.kandagatla at linaro.org wrote:

> +	num_regions = is_contiguous ? 1 : periods;
> +	buf_sz = is_contiguous ? (period_sz * periods) : period_sz;

Please write normal if statements, it's much easier to read.

> +	buf_sz = PAGE_ALIGN(buf_sz);

I don't understand what this is doing, buf_sz is a length not an address
so why are we attempting to align it?
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 488 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180301/30808dfe/attachment.sig>
