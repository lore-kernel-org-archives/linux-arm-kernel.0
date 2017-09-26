From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Tue, 26 Sep 2017 15:20:55 +0200
Subject: [PATCH 2/2] iio: adc: sun4i-gpadc-iio: do not fail probing when
 no thermal DT node
In-Reply-To: <160cf183a167ef841c96c5626f42e23b7195effa.1506430136.git-series.quentin.schulz@free-electrons.com>
References: <f7b1b9c493c563a2f5b5f5f44596d45d3d719d26.1506430136.git-series.quentin.schulz@free-electrons.com>
 <160cf183a167ef841c96c5626f42e23b7195effa.1506430136.git-series.quentin.schulz@free-electrons.com>
Message-ID: <20170926132055.6wcrbxem3fxwhojh@flea>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Sep 26, 2017 at 12:52:19PM +0000, Quentin Schulz wrote:
> Before this patch, forgetting to put a thermal-zones DT node would
> result in the driver failing to probe.
> 
> It should be perfectly acceptable to have the driver probe even if no
> thermal-zones DT is found. However, it shouldn't want to fail if the
> thermal registering fail for any other reason (waiting for other drivers
> for example) so check on ENODEV only.
> 
> Signed-off-by: Quentin Schulz <quentin.schulz@free-electrons.com>

For both patches:
Acked-by: Maxime Ripard <maxime.ripard@free-electrons.com>

Thanks!
Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 801 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170926/b3bfe2ea/attachment.sig>
