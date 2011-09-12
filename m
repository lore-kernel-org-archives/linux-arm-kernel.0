From: jaswinder.singh@linaro.org (Jassi Brar)
Date: Mon, 12 Sep 2011 12:03:01 +0530
Subject: [PATCH] dmaengine: add CSR SiRFprimaII DMAC driver
In-Reply-To: <1315756966.2246.3.camel@vkoul-mobl4>
References: <1315374075-15479-1-git-send-email-Baohua.Song@csr.com>
	<438BB0150E931F4B9CE701519A4463010871804A46@bgsmsx502.gar.corp.intel.com>
	<CAGsJ_4x4S+8d3xS+QTrjDpoxcHo3p7qArd7yFr=+h1vxSRvEpA@mail.gmail.com>
	<438BB0150E931F4B9CE701519A4463010871804A48@bgsmsx502.gar.corp.intel.com>
	<CAGsJ_4yeovNP=6CKTafbxrBTrYQ42B9yvAOM8gM_bYqD6mTnUw@mail.gmail.com>
	<CABb+yY1=P=D3GFFxMOUM0a2yWCiAHNqwVU0a--t+pJnUhqKHKA@mail.gmail.com>
	<CABb+yY3F+DMn2SxeO0chjpiMBkgLvSK5EVYMdhQsfQoZNZ4_7Q@mail.gmail.com>
	<1315518378.6638.2.camel@vkoul-mobl4>
	<CAGsJ_4xv9+=+=2b=i47P5V5sOQH-GyTMaESwbeHxu439Vx1gLA@mail.gmail.com>
	<1315756966.2246.3.camel@vkoul-mobl4>
Message-ID: <CAJe_ZhdTnRSzfRvnAaCy1M-LpAk0FqjNSXRLnQW2ksOS77A+=w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11 September 2011 21:32, Vinod Koul <vkoul@infradead.org> wrote:
> On Fri, 2011-09-09 at 16:18 +0800, Barry Song wrote:

>> Jassi prefer to use a transfer type instead of a control command.
>> though we will not really change the interleaved setting for every
>> transfer(it is more possible for one device, we will not change the
>> xlen/ylen/dma_width setting in the whole life period), i do believe
>> the transfer type is enough flexible for my possible applications to
>> change xlen, ylen and dma_width in different transfers.

> Is this usually the assumption or yours is a special case, how about
> your's Jassi?

1) Having type per transfer is more flexible than having to set the type
     for a channel using a control command. The overhead is negligible
     because the client reuses the same descriptors with only changed
     source/destination addresses.
2) DMA_SLAVE_CONFIG is meant for slave (Mem<->Dev) channels,
    whereas it is very likely(for multimedia drives) to have such operations
    Mem->Mem as well.
3) Someday if people realize we can fold many, if not all, transfer types into
    one, this api has the potential to be the survivor.

That was where my mind was grazing when I chose to do what I did.
