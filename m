From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Mon, 30 May 2016 11:44:49 +0200
Subject: [PATCH 1/5] spi: sunxi: fix transfer timeout
In-Reply-To: <cb90b922caa6ac07c1425d726ea19709ee5284f4.1464130597.git.hramrach@gmail.com>
References: <cover.1464130597.git.hramrach@gmail.com>
 <cb90b922caa6ac07c1425d726ea19709ee5284f4.1464130597.git.hramrach@gmail.com>
Message-ID: <20160530094449.GJ4247@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 26, 2016 at 07:25:23PM -0000, Michal Suchanek wrote:
> The trasfer timeout is fixed at 1000 ms. Reading a 4Mbyte flash over
> 1MHz SPI bus takes way longer than that. Calculate the timeout from the
> actual time the transfer is supposed to take and multiply by 2 for good
> measure.
> 
> Signed-off-by: Michal Suchanek <hramrach@gmail.com>
> ---
> 
> v2:
> - fix build error
> - use unsigned instead of int in max_t

And this generates warnings in checkpatch. Please make sure that you
run it before submitting any patches.

Thanks!
Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160530/6e2521ef/attachment.sig>
