From: broonie@kernel.org (Mark Brown)
Date: Sat, 14 Oct 2017 01:59:45 -0700
Subject: [RESEND PATCH 1/2] spi: rockchip: Convert to late and early
 system PM callbacks
In-Reply-To: <1617641.TtuYKIH8aZ@aspire.rjw.lan>
References: <20171013104138.3216-1-jeffy.chen@rock-chips.com>
 <20171013183750.piabs7m3dnpabnkm@sirena.co.uk>
 <20171013234511.dxazu5wvvz7sjiiu@dtor-ws>
 <1617641.TtuYKIH8aZ@aspire.rjw.lan>
Message-ID: <20171014085945.grm6gtdzuunogbwf@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Oct 14, 2017 at 02:15:34AM +0200, Rafael J. Wysocki wrote:

> The infrastructure in the core is there, the part related to getting that
> information from firmware is (mostly) missing.

Ah, yes - now I remember.  We want this for probe ordering so we don't
really want to be doing it in the subsystems when they request resources
as that's too late (though I guess duplication there won't hurt).  Fun.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 488 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20171014/6de47038/attachment.sig>
