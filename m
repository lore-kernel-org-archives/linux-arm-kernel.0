From: leif.lindholm@linaro.org (Leif Lindholm)
Date: Tue, 25 Aug 2015 16:37:54 +0100
Subject: [PATCH v1 3/3] arm64: dts: add Hi6220 mailbox node
In-Reply-To: <CAKv+Gu-b=QvMF++V9UjULRxrGvoz-0ytFLeuLm8Y5sQH4p53Sw@mail.gmail.com>
References: <20150824095144.GA7139@leverpostej>
 <1440411596.3517.12.camel@linaro.org>
 <20150824114903.GT10728@bivouac.eciton.net>
 <1440490427.10987.29.camel@linaro.org>
 <20150825094630.GU10728@bivouac.eciton.net>
 <1440497710.10987.42.camel@linaro.org>
 <20150825104256.GB13471@leverpostej>
 <1440510194.10987.52.camel@linaro.org>
 <20150825142416.GW10728@bivouac.eciton.net>
 <CAKv+Gu-b=QvMF++V9UjULRxrGvoz-0ytFLeuLm8Y5sQH4p53Sw@mail.gmail.com>
Message-ID: <20150825153754.GY10728@bivouac.eciton.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Aug 25, 2015 at 04:51:22PM +0200, Ard Biesheuvel wrote:
> >>    Arm kernel should either fetch memory information from
> >>    efi or DT.
> >
> > Absolutely.
> >
> >>    Currently arm kernel fetch both efi memory information and
> >>    reserved buffer from DTB at the same time.
> >
> > No, it does not.
> 
> It should not, but it does. Due to an oversight, the stub removes
> /memreserve/ entries but ignores the reserved-memory node completely.

Urgh.

> This was reported here in fact
> 
> http://thread.gmane.org/gmane.linux.kernel.efi/5736/focus=5742
> 
> but there has not been a followup to this series.

Are all of those patches still relevant, or did some of them go in
already?

Haojian: can you give that patch a spin and see if it does what you
need, combined with adding the reserved areas to the UEFI memory map?

/
    Leif
