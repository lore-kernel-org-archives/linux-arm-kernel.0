From: 21cnbao@gmail.com (Barry Song)
Date: Sat, 10 Sep 2011 07:40:20 +0800
Subject: [PATCH] dmaengine: add CSR SiRFprimaII DMAC driver
In-Reply-To: <1315585282.30522.1.camel@vkoul-mobl4>
References: <1315374075-15479-1-git-send-email-Baohua.Song@csr.com>
	<438BB0150E931F4B9CE701519A4463010871804A46@bgsmsx502.gar.corp.intel.com>
	<CAGsJ_4x4S+8d3xS+QTrjDpoxcHo3p7qArd7yFr=+h1vxSRvEpA@mail.gmail.com>
	<438BB0150E931F4B9CE701519A4463010871804A48@bgsmsx502.gar.corp.intel.com>
	<CAGsJ_4yeovNP=6CKTafbxrBTrYQ42B9yvAOM8gM_bYqD6mTnUw@mail.gmail.com>
	<CABb+yY1=P=D3GFFxMOUM0a2yWCiAHNqwVU0a--t+pJnUhqKHKA@mail.gmail.com>
	<CABb+yY3F+DMn2SxeO0chjpiMBkgLvSK5EVYMdhQsfQoZNZ4_7Q@mail.gmail.com>
	<1315518378.6638.2.camel@vkoul-mobl4>
	<CAGsJ_4xv9+=+=2b=i47P5V5sOQH-GyTMaESwbeHxu439Vx1gLA@mail.gmail.com>
	<1315585282.30522.1.camel@vkoul-mobl4>
Message-ID: <CAGsJ_4xs_vPqhK9mSo8o8E1HKmegNv9mJOQiTYPmLB4P1-ZoRg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2011/9/10 Vinod Koul <vkoul@infradead.org>:
> On Fri, 2011-09-09 at 16:18 +0800, Barry Song wrote:
>> 2011/9/9 Vinod Koul <vkoul@infradead.org>:
>> > Looks like Jassi got a user for his proposed API. I am not sure whats
>> > going on with TI folks, they never showed up here @LPC.
>>
>> yes, i can definitely be an user of Jassi's new generic api. it seems
>> the api is just there for dma in 2d.
>>
>> Jassi prefer to use a transfer type instead of a control command.
>> though we will not really change the interleaved setting for every
>> transfer(it is more possible for one device, we will not change the
>> xlen/ylen/dma_width setting in the whole life period), i do believe
>> the transfer type is enough flexible for my possible applications to
>> change xlen, ylen and dma_width in different transfers.
>>
>> as we know, interleaved DMA can also be used for audio driver. for
>> some audio controllers, if there are n channels, it can't tranfer the
>> whole audio frame to sound card by one dma channel, and it needs to
>> tranfer every channel by separate dma. typically, we can define this
>> kind of xfer to skip other n-1 channel.
>>
>> Jassi, you might think my reply as an ACK to "[PATCH] DMAEngine:
>> Define generic transfer request api".
> Great, can you two redo patch along with this driver as user of new
> API :)

ok. i'll send v2 using this new API.

>
> --
> ~Vinod Koul
> Intel Corp.
>
>
-barry
