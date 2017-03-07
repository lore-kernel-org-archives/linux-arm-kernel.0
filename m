From: David.Laight@ACULAB.COM (David Laight)
Date: Tue, 7 Mar 2017 17:24:21 +0000
Subject: [PATCHv3 net-next 21/22] net: mvpp2: set dma mask and coherent
 dma mask on PPv2.2
In-Reply-To: <1488902000-2658-22-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1488902000-2658-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1488902000-2658-22-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <063D6719AE5E284EB5DD2968C1650D6DCFE79D2E@AcuExch.aculab.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Thomas Petazzoni
> Sent: 07 March 2017 15:53
> On PPv2.2, the streaming mappings can be anywhere in the first 40 bits
> of the physical address space. However, for the coherent mappings, we
> still need them to be in the first 32 bits of the address space,
> because all BM pools share a single register to store the high 32 bits
> of the BM pool address, which means all BM pools must be allocated in
> the same 4GB memory area.

Are the coherent mappings just used for ring structures?
If it might be reasonable to allocate them as a single entity,
thus guaranteeing they all reside in a single 4G region.

	David
