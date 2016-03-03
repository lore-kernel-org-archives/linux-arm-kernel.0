From: wsa@the-dreams.de (Wolfram Sang)
Date: Thu, 3 Mar 2016 22:18:35 +0100
Subject: [PATCH v2] i2c: mediatek: i2c multi transfer optimization
In-Reply-To: <1456421739-5450-1-git-send-email-liguo.zhang@mediatek.com>
References: <1456421739-5450-1-git-send-email-liguo.zhang@mediatek.com>
Message-ID: <20160303211835.GC1501@katana>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Feb 26, 2016 at 01:35:39AM +0800, Liguo Zhang wrote:
> Send the next transfer in the i2c irq handler, and only signal
> complete() when the entire transaction has been completed.

This describes what you do. But not why. Is this an improvment of
throughput? Is there a downside of interrupt latency?

Thanks.

> 
> Signed-off-by: Liguo Zhang <liguo.zhang@mediatek.com>
> ---
> change in v2:
> Remove the unused variable left_num in mtk_i2c_transfer().
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160303/273deaa9/attachment.sig>
