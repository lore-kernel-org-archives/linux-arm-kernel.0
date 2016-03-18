From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 18 Mar 2016 10:56:55 +0000
Subject: [PATCH] usb: chipidea: Configure DMA properties and ops from DT
In-Reply-To: <20160318015414.GA30851@shlinux2.ap.freescale.net>
References: <1456119133-16114-1-git-send-email-bjorn.andersson@linaro.org>
 <CADRPPNRTXiiVzbqmpX7h_af7Q+qw+-ZB3zDb0855a1U=CmWh-A@mail.gmail.com>
 <20160314105108.GB2131@shlinux2.ap.freescale.net>
 <3240370.XdEELlSA8f@wuerfel>
 <20160318015414.GA30851@shlinux2.ap.freescale.net>
Message-ID: <20160318105655.GE19428@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Mar 18, 2016 at 09:54:14AM +0800, Peter Chen wrote:
> Although I don't know what kinds of bugs it may have, it may be
> met before, otherwise, why most of platform drivers need to call
> dma_set_coherent_mask or dma_coerce_mask_and_coherent explicitly

See Documentation/DMA-API.txt, specifically the section starting

  Part Ic - DMA addressing limitations
  ------------------------------------

and also Documentation/DMA-API-HOWTO.txt, the section on

  DMA addressing limitations

which provides further information.

Drivers using DMA should be using dma_set_mask_and_coherent() _or_
one of dma_set_mask() and dma_set_coherent_mask() depending on which
types of DMA they wish to perform.  Drivers should not use
dma_coerce_mask_and_coherent() except in exceptional circumstances:
that function is more a marker that they or some bus/platform code
is doing something wrong.

-- 
RMK's Patch system: http://www.arm.linux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
