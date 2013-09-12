From: dwmw2@infradead.org (David Woodhouse)
Date: Thu, 12 Sep 2013 16:22:02 +0100
Subject: [PATCH v3 0/8] Add the Quadspi driver for vf610-twr
In-Reply-To: <20130913025827.GA3051@gmail.com>
References: <593AEF6C47F46446852B067021A273D6D984000B@MUCSE039.lantiq.com>
 <20130905020435.GA3970@gmail.com>
 <20980858CB6D3A4BAE95CA194937D5E73EA0C7F4@DBDE04.ent.ti.com>
 <522817D7.1010206@freescale.com> <522D3B79.3060707@freescale.com>
 <52318953.6090405@freescale.com>
 <1378979431.2627.402.camel@shinybook.infradead.org>
 <20130913025827.GA3051@gmail.com>
Message-ID: <1378999322.4210.95.camel@i7.infradead.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 2013-09-12 at 22:58 -0400, Huang Shijie wrote:
> 
> But for the quadspi driver, it does not need this information.
> 
> When the drivers knows that it is a Quad-read transaction, it will uses
> the relative LUT sequence which uses the 4 lines.

But the controller driver shouldn't *have* that incestuous knowledge of
the command set of the chip that happens to be connected to it.

That's what we're *complaining* about.

It *should* "need this information", and should just do what it's *told*
to do by the slave device driver.

-- 
dwmw2
-------------- next part --------------
A non-text attachment was scrubbed...
Name: smime.p7s
Type: application/x-pkcs7-signature
Size: 5745 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130912/a88c7648/attachment.bin>
