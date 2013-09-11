From: broonie@kernel.org (Mark Brown)
Date: Wed, 11 Sep 2013 11:41:26 +0100
Subject: [PATCH v3 0/8] Add the Quadspi driver for vf610-twr
In-Reply-To: <522FD78A.6080900@freescale.com>
References: <593AEF6C47F46446852B067021A273D6D984000B@MUCSE039.lantiq.com>
 <20130905020435.GA3970@gmail.com>
 <20980858CB6D3A4BAE95CA194937D5E73EA0C7F4@DBDE04.ent.ti.com>
 <522817D7.1010206@freescale.com> <522D3B79.3060707@freescale.com>
 <20130909151450.GI29403@sirena.org.uk>
 <522EC33B.9000009@freescale.com>
 <20130910180704.GB29403@sirena.org.uk>
 <522FD78A.6080900@freescale.com>
Message-ID: <20130911104126.GN29403@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Sep 11, 2013 at 10:38:02AM +0800, Huang Shijie wrote:
> ? 2013?09?11? 02:07, Mark Brown ??:

> > don't need to reimplement the logic and new chips with new opcodes don't
> > need to be added to multiple drivers.

> Since there is no standard for SPI-NOR commands, we _should_ add new
> code for
> new chips with new opcodes. For example, if a new chip supports the
> quad-read with
> a new command 0xef, we can submit a small patch for m25p80 to fix it.

> We have to do it in such way, no shortcut.

So why does the SPI driver have references to the opcodes in it?
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130911/39d0f44d/attachment-0001.sig>
