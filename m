From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Mon, 14 Sep 2015 22:34:47 +0200
Subject: [PATCH] dmaengine: sun4i: fix unsafe list iteration
In-Reply-To: <1442175353-4433-1-git-send-email-emilio@elopez.com.ar>
References: <1442175353-4433-1-git-send-email-emilio@elopez.com.ar>
Message-ID: <20150914203447.GH4684@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Sep 13, 2015 at 05:15:53PM -0300, Emilio L?pez wrote:
> Currently, sun4i_dma_free_contract iterates over lists and frees memory
> as it goes through them, causing reads to recently freed memory to
> be performed. Fix this by using the safe version of the iterator, so
> freed memory is not referenced at all.
> 
> Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
> Signed-off-by: Emilio L?pez <emilio@elopez.com.ar>

Acked-by: Maxime Ripard <maxime.ripard@free-electrons.com>

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
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150914/2f38ad27/attachment.sig>
