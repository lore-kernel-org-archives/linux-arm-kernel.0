From: wsa@the-dreams.de (Wolfram Sang)
Date: Thu, 9 Jun 2016 22:46:55 +0200
Subject: [PATCH V3 1/2] i2c: qup: Fix broken dma when CONFIG_DEBUG_SG is
 enabled
In-Reply-To: <002201d1b79a$22862bc0$67928340$@codeaurora.org>
References: <1464164212-11377-1-git-send-email-sricharan@codeaurora.org>
 <1464164212-11377-2-git-send-email-sricharan@codeaurora.org>
 <20160526184805.GC1614@katana>
 <002201d1b79a$22862bc0$67928340$@codeaurora.org>
Message-ID: <20160609204655.GN23522@katana>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


>  The coherency is not dropped here. dma_map/unmap used
>  makes the buffer coherent before passing it to
>  dmaengine. Previously it was not required.
>  I can add this in description if its not clear.

Please do.

> 
>  >> @@ -1268,6 +1260,8 @@ static int qup_i2c_xfer_v2(struct i2c_adapter *adap,
> >>  		}
> >>  	}
> >>
> >> +	idx = 0;
> >> +
> >
> >This looks like an unrelated change.
>     Ha, wrong. This should have been in a separate patch.

Exactly this is what I meant with "unrelated" :)

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160609/e8532ae9/attachment.sig>
