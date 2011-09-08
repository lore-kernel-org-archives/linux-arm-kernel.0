From: jassisinghbrar@gmail.com (Jassi Brar)
Date: Thu, 8 Sep 2011 08:47:02 +0530
Subject: [PATCH] dmaengine: add CSR SiRFprimaII DMAC driver
In-Reply-To: <CAGsJ_4yeovNP=6CKTafbxrBTrYQ42B9yvAOM8gM_bYqD6mTnUw@mail.gmail.com>
References: <1315374075-15479-1-git-send-email-Baohua.Song@csr.com>
	<438BB0150E931F4B9CE701519A4463010871804A46@bgsmsx502.gar.corp.intel.com>
	<CAGsJ_4x4S+8d3xS+QTrjDpoxcHo3p7qArd7yFr=+h1vxSRvEpA@mail.gmail.com>
	<438BB0150E931F4B9CE701519A4463010871804A48@bgsmsx502.gar.corp.intel.com>
	<CAGsJ_4yeovNP=6CKTafbxrBTrYQ42B9yvAOM8gM_bYqD6mTnUw@mail.gmail.com>
Message-ID: <CABb+yY1=P=D3GFFxMOUM0a2yWCiAHNqwVU0a--t+pJnUhqKHKA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 8, 2011 at 7:42 AM, Barry Song <21cnbao@gmail.com> wrote:

>>> it is much different with primacell based DMA like pl080, pl330.
>>> prima2 has a self-defined DMAC IP. basically it is a 2D mode dma with
>>> two scales X and Y and direct way to start and stop DMA.
>>> every channel has fixed function to serve only one perpheral. so you
>>> find we have a filter id.
>> okay, what do you mean by 2D mode? Is it similar to what TI folks, Linus
>> W and Jassi Brar posted RFC's on?
>
> In SiRFprimaII 2-D DMA, the system memory space is interpreted
> as a 2-D layout instead of a linear 1-D layout. More specifically, the
> system memory can be considered as
> multiple data lines. The length of the data line is determined by the
> user-selected DMA_WIDTH register.
> The user can specify a data window that the user wants to access using
> four parameters:
> ? Start address
> ? X length
> ? Y length
> ? Width
>
> The idea of a 2-D DMA is shown in figure 2d-dma.png attached.
>
> If you specifies the Y length as 0 or the X length equals to the DMA
> width, then this 2-D DMA reduces to
> 1-D. If the user configures the X length greater than the DMA width,
> then the extra data is wrapped around
> to the next data line, this may corrupt the DMA transfer for
> multiple-line 2-D DMA. If this is a 1-D DMA, then
> there is no issue. The attached diagram 2d-dma2.png shows the
> wrap-around of the extra data in case the X length
> greater than DMA width.

Sorry, the role of DMA_WIDTH is not clear to me yet.
In which case the user _must_ set {xlen > width} ?

thanks
-jassi
