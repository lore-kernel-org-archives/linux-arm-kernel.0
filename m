From: jassisinghbrar@gmail.com (Jassi Brar)
Date: Thu, 8 Sep 2011 13:19:00 +0530
Subject: [PATCH] dmaengine: add CSR SiRFprimaII DMAC driver
In-Reply-To: <CAGsJ_4xDh6c5=Uhw9zO34XeY5UNC=fLuRubryks6NOv3T5_kCQ@mail.gmail.com>
References: <1315374075-15479-1-git-send-email-Baohua.Song@csr.com>
	<438BB0150E931F4B9CE701519A4463010871804A46@bgsmsx502.gar.corp.intel.com>
	<CAGsJ_4x4S+8d3xS+QTrjDpoxcHo3p7qArd7yFr=+h1vxSRvEpA@mail.gmail.com>
	<438BB0150E931F4B9CE701519A4463010871804A48@bgsmsx502.gar.corp.intel.com>
	<CAGsJ_4yeovNP=6CKTafbxrBTrYQ42B9yvAOM8gM_bYqD6mTnUw@mail.gmail.com>
	<CABb+yY1=P=D3GFFxMOUM0a2yWCiAHNqwVU0a--t+pJnUhqKHKA@mail.gmail.com>
	<CABb+yY3F+DMn2SxeO0chjpiMBkgLvSK5EVYMdhQsfQoZNZ4_7Q@mail.gmail.com>
	<CAGsJ_4xDh6c5=Uhw9zO34XeY5UNC=fLuRubryks6NOv3T5_kCQ@mail.gmail.com>
Message-ID: <CABb+yY26KytnyPiQ7BaMsqjKAF9px9XBXixZiJZL1EYZKBQVow@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 8, 2011 at 12:06 PM, Barry Song <21cnbao@gmail.com> wrote:
> 2011/9/8 Jassi Brar <jassisinghbrar@gmail.com>:
>> According to figures, {xlen > width} is to be set _only_ when a transfer
>> is divided into _exactly_ two chunks separated by gap _exactly_
>> equal to length of the second chunk (an extremely rare case).
>
> Sorry i didn't list related full information in datasheet in my early reply.
> we don't have the case of xlen > dma_width.
Then the dmac driver becomes even simpler.
Accept strictly 'rectangular' requests and reject every other.


>> Anyways, every case can be easily expressed using the generic api
>> I proposed. See 'struct xfer_template' in https://lkml.org/lkml/2011/8/12/128
>
> i think it is the interleaved DMA case and there is a
> inter-chunk-gap(ICG) between every chunk while dma_width > xlen,
> then your new generic API can definitely cover this case.
>
Yup, it does. Thanks for confirming.
