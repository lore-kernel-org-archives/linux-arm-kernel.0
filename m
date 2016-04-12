From: wsa@the-dreams.de (Wolfram Sang)
Date: Tue, 12 Apr 2016 23:13:56 +0200
Subject: [PATCH v3] i2c: mediatek: i2c multi transfer optimization
In-Reply-To: <1457375031-3769-1-git-send-email-liguo.zhang@mediatek.com>
References: <1457375031-3769-1-git-send-email-liguo.zhang@mediatek.com>
Message-ID: <20160412211355.GA1526@katana>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

thanks for the submission!

On Tue, Mar 08, 2016 at 02:23:51AM +0800, Liguo Zhang wrote:
> Signal complete() in the i2c irq handler after one transfer done,
> and then wait_for_completion_timeout() will return, this procedure
> may cost much time, so only signal complete() when the entire
> transaction has been completed, it will reduce the entire transaction
> time.
> 
> Signed-off-by: Liguo Zhang <liguo.zhang@mediatek.com>

I wonder. You have less context switches, yes. On the other hand, you
likely have bigger interrupt latency because you do more stuff in the
interrupt handler. Is it really a gain in the end?

Regards,

   Wolfram

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160412/d949e8c7/attachment.sig>
