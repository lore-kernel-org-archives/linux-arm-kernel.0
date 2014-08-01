From: wsa@the-dreams.de (Wolfram Sang)
Date: Fri, 1 Aug 2014 19:57:05 +0200
Subject: [PATCH v2] i2c: pca954x: put the mux to disconnected state after
 resume
In-Reply-To: <1406289466-936-1-git-send-email-jszhang@marvell.com>
References: <1406289466-936-1-git-send-email-jszhang@marvell.com>
Message-ID: <20140801175705.GE3277@katana>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 25, 2014 at 07:57:46PM +0800, Jisheng Zhang wrote:
> pca954x may be power lost during suspend, so after resume we also suffer
> the issue fixed by commit cd823db8b1161ef0d756514d280715a576d65cc3,
> 
>  "pca954x power-on default is channel 0 connected. If multiple pca954x
>  muxes are connected to the same physical I2C bus, the parent bus will
>  see channel 0 devices behind both muxes by default."
> 
> What's more, when resume bootloader may also operate the mux, so the
> the channel connected after that may not be the one driver thought.
> 
> We fix this problem by putting the mux to disconnected state and
> clearing last_chan in the resume hook.
> 
> Signed-off-by: Jisheng Zhang <jszhang@marvell.com>

Applied to for-next, thanks!

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140801/64d439fd/attachment-0001.sig>
