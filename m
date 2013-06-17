From: tomasz.figa@gmail.com (Tomasz Figa)
Date: Mon, 17 Jun 2013 20:27:20 +0200
Subject: [RFC PATCH 05/11] dma: amba-pl08x: Add support for different
 maximum transfer size
In-Reply-To: <CACRpkdaHpNVXueXy0HRnKTshn4ZZSPFh-pgav6B0UAU1xqsNCg@mail.gmail.com>
References: <1371416058-22047-1-git-send-email-tomasz.figa@gmail.com>
 <1371416058-22047-6-git-send-email-tomasz.figa@gmail.com>
 <CACRpkdaHpNVXueXy0HRnKTshn4ZZSPFh-pgav6B0UAU1xqsNCg@mail.gmail.com>
Message-ID: <5634002.KI4n5O8hcE@flatron>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 17 of June 2013 15:42:15 Linus Walleij wrote:
> On Sun, Jun 16, 2013 at 10:54 PM, Tomasz Figa <tomasz.figa@gmail.com> 
wrote:
> > PL080S has separate register to store transfer size in, allowing
> > single
> > transfer to be much larger than in standard PL080.
> > 
> > This patch makes the amba-pl08x driver aware of this and removes
> > writing transfer size to reserved bits of CH_CONTROL register on
> > PL080S, which was not a problem witn transfer sizes fitting the
> > original bitfield of PL080, but now would overwrite other fields.
> > 
> > Signed-off-by: Tomasz Figa <tomasz.figa@gmail.com>
> 
> Very straight-forward.
> Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Thanks.

Actually today I found another way of doing this, which wouldn't require 
checking PL08X_IS_PL080S flag at all.

Simply masking the transfer size in pl08x_cctl_bits() with mask of the 
original bitfield would be enough I think, as writes to those bits seem to 
be ignored on PL080S.

Best regards,
Tomasz
