From: wsa@the-dreams.de (Wolfram Sang)
Date: Tue, 3 Apr 2018 17:39:25 +0200
Subject: [PATCH v2 5/6] i2c: i2c-stm32f7: Add DMA support
In-Reply-To: <1521650940-11651-6-git-send-email-pierre-yves.mordret@st.com>
References: <1521650940-11651-1-git-send-email-pierre-yves.mordret@st.com>
 <1521650940-11651-6-git-send-email-pierre-yves.mordret@st.com>
Message-ID: <20180403153925.lg37rezuvs6hefks@ninjato>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


> +#define STM32F7_I2C_DMA_LEN_MIN			0x1
...

> +	if (i2c_dev->dma && f7_msg->count >= STM32F7_I2C_DMA_LEN_MIN) {

Are you using DMA for every message with a length >= 1? The setup of
that might be more expensive than the DMA gain, if so.

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180403/ac57ea74/attachment.sig>
