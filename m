From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Wed, 1 Jun 2016 20:14:39 +0200
Subject: [PATCH 3/5] spi: sunxi: expose maximum transfer size limit
In-Reply-To: <CAOMqctQdbipvvTnF253S4jGDos1crYXk9nuzDcRvy4geeS=GrQ@mail.gmail.com>
References: <cover.1464130597.git.hramrach@gmail.com>
 <5fffb7eca6f4b70853d92be2403595d6d06bede7.1464130597.git.hramrach@gmail.com>
 <20160530083745.GG4247@lukather>
 <CAOMqctQdbipvvTnF253S4jGDos1crYXk9nuzDcRvy4geeS=GrQ@mail.gmail.com>
Message-ID: <20160601181439.GB4908@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, May 30, 2016 at 10:57:10AM +0200, Michal Suchanek wrote:
> Hello,
> 
> On 30 May 2016 at 10:37, Maxime Ripard <maxime.ripard@free-electrons.com> wrote:
> > On Thu, May 26, 2016 at 07:25:24PM -0000, Michal Suchanek wrote:
> >> The sun4i spi hardware can trasfer at most 63 bytes of data without DMA
> >> support so report the limitation. Same on sun6i.
> >
> > Is it? Is there timeouts on the A31 and later SoCs?
> >
> 
> I have no sun6i hardware to test with.
> 
> This is an advisory limit you can query and it better be smaller
> rather than unreliable. The hard limit in the driver is still
> SUN6I_FIFO_DEPTH (which is 128 bytes on sun6i).
> 
> You can test his without any actual SPI device. Unused pins you can
> multiplex as SPI suffice.

Ok, for the time being:

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
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160601/13d59b09/attachment.sig>
