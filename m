From: oss@buserror.net (Scott Wood)
Date: Thu, 16 Mar 2017 15:08:32 -0500
Subject: [PATCH 06/10] soc/qbman: Add ARM equivalent for
 flush_dcache_range()
In-Reply-To: <VI1PR04MB3216490369A82C7A79302C4C86260@VI1PR04MB3216.eurprd04.prod.outlook.com>
References: <VI1PR0401MB2430DA6BD2F857C30EC86A50917F0@VI1PR0401MB2430.eurprd04.prod.outlook.com>
 <HE1PR0401MB263638F320470CA216990BCC86720@HE1PR0401MB2636.eurprd04.prod.outlook.com>
 <5414359.8GMja3pNrI@wuerfel>
 <VI1PR0401MB24303C4A5C0042005E17F1A391770@VI1PR0401MB2430.eurprd04.prod.outlook.com>
 <CAK8P3a1Gd4bd7GjEp_a9WXc_mTPk0XmP7DH8aPWhbn2K3MMuDQ@mail.gmail.com>
 <1485570872.9266.22.camel@buserror.net>
 <d5ca6bcd-1d1a-2a61-1f5c-9086a67f629a@arm.com>
 <HE1PR0401MB2636FF4D977DDA6888616A26864B0@HE1PR0401MB2636.eurprd04.prod.outlook.com>
 <3cc42823-0fc9-ed3e-1738-bf6e314dd569@arm.com>
 <HE1PR0401MB2636B14B4F1637A5A7D5432386400@HE1PR0401MB2636.eurprd04.prod.outlook.com>
 <20170206223721.GN27312@n2100.armlinux.org.uk>
 <HE1PR0401MB26362EA8D498B77755DE63A286430@HE1PR0401MB2636.eurprd04.prod.outlook.com>
 <e15f6ce7-be92-9200-c6b4-2b2dd83f078f@arm.com>
 <VI1PR04MB32169AF848EE1B75A83B542A86590@VI1PR04MB3216.eurprd04.prod.outlook.com>
 <VI1PR04MB3216490369A82C7A79302C4C86260@VI1PR04MB3216.eurprd04.prod.outlook.com>
Message-ID: <1489694912.2944.30.camel@buserror.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 2017-03-16 at 00:43 +0000, Roy Pledge wrote:
> Just wanted to follow up on this - turns out the no-map; attribute is
> what I was missing. I now have the suggested mechanism working for ARM.
> However when I went to test on PowePC the region wasn't being enabled
> properly. It turns out the Kconfig in arch/powerpc doesn't define
> HAVE_GENERIC_DMA_COHERENT so this mechanism isn't available. However I
> added it and everything worked on my PPC board as it did on ARM.
> 
> Does anyone know why HAVE_GENERIC_DMA_COHERENT isn't defined for
> PowerPC? I did a quick search but didn't see previous discussion on this
> topic.

Probably because nothing on PPC needed it.

In any case, the problems with doing this on PPC run deeper than that, as I
pointed out in:
https://www.spinics.net/lists/arm-kernel/msg560020.html

-Scott
