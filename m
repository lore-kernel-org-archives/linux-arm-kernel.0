From: broonie@kernel.org (Mark Brown)
Date: Tue, 10 Sep 2013 19:07:04 +0100
Subject: [PATCH v3 0/8] Add the Quadspi driver for vf610-twr
In-Reply-To: <522EC33B.9000009@freescale.com>
References: <593AEF6C47F46446852B067021A273D6D984000B@MUCSE039.lantiq.com>
 <20130905020435.GA3970@gmail.com>
 <20980858CB6D3A4BAE95CA194937D5E73EA0C7F4@DBDE04.ent.ti.com>
 <522817D7.1010206@freescale.com> <522D3B79.3060707@freescale.com>
 <20130909151450.GI29403@sirena.org.uk>
 <522EC33B.9000009@freescale.com>
Message-ID: <20130910180704.GB29403@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Sep 10, 2013 at 02:59:07PM +0800, Huang Shijie wrote:

> Since I do not expose any details in the spi-nor.h
> (i only add some commands in this header), how can i hides the details
> with an abstraction?

> could you explain it more clearly?

The code to work out what opcodes to send to the device should be split
out of the device driver so that other drivers talking to these chips
don't need to reimplement the logic and new chips with new opcodes don't
need to be added to multiple drivers.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130910/f128fe46/attachment-0001.sig>
