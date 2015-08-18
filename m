From: balbi@ti.com (Felipe Balbi)
Date: Tue, 18 Aug 2015 09:43:47 -0500
Subject: [PATCH v3] i2c: omap: improve duty cycle on SCL
In-Reply-To: <CAFqkuUbO1CZ8bu8g8O7SsLF-0nUV274GZ08=6J1sVS4Foy+_EA@mail.gmail.com>
References: <1434569475-17378-1-git-send-email-balbi@ti.com>
 <55827CD7.7030207@nokia.com>
 <20150618172558.GC27790@saruman.tx.rr.com>
 <20150709194241.GF4744@katana>
 <20150710172714.GC20408@saruman.tx.rr.com>
 <20150813143651.GG27560@saruman.tx.rr.com>
 <CAFqkuUbO1CZ8bu8g8O7SsLF-0nUV274GZ08=6J1sVS4Foy+_EA@mail.gmail.com>
Message-ID: <20150818144347.GD9143@saruman.tx.rr.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

HI,

On Mon, Aug 17, 2015 at 06:28:11PM -0700, Matt Reimer wrote:
> This doesn't seem to work for higher speeds, like 2.6 MHz. hssclh and
> hsscll end up going negative.
> 
> My case is an OMAP3 trying to configure i2c1 at 2.6 MHz, on which it talks
> to TPS65950. I end up with the following values:
> 
>         SCLL 0x0000fd12 SCLH 0x0000fe13
> 
> The end result is that the high-speed part gets configured way too slow and
> so the OMAP3 can't talk to the TPS65950.

hmm, indeed. Seems like anything above 1MHz would have an issue. I'll
see what can be done there.

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150818/1ab4b88c/attachment.sig>
