From: David.Laight@ACULAB.COM (David Laight)
Date: Wed, 8 Mar 2017 11:00:10 +0000
Subject: [PATCHv3 net-next 21/22] net: mvpp2: set dma mask and coherent
 dma mask on PPv2.2
In-Reply-To: <20170307191201.645d23b4@free-electrons.com>
References: <1488902000-2658-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1488902000-2658-22-git-send-email-thomas.petazzoni@free-electrons.com>
 <063D6719AE5E284EB5DD2968C1650D6DCFE79D2E@AcuExch.aculab.com>
 <20170307191201.645d23b4@free-electrons.com>
Message-ID: <063D6719AE5E284EB5DD2968C1650D6DCFE7A585@AcuExch.aculab.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Thomas Petazzoni
> Sent: 07 March 2017 18:12
> Hello,
> 
> On Tue, 7 Mar 2017 17:24:21 +0000, David Laight wrote:
> 
> > Are the coherent mappings just used for ring structures?
> > If it might be reasonable to allocate them as a single entity,
> > thus guaranteeing they all reside in a single 4G region.
> 
> Do we have the guarantee that a DMA coherent allocation will not span a
> 4G boundary?

I'm pretty sure they are guaranteed not to cross any boundary they don't have to.
So a 16k buffer won't cross a 16k boundary.

	David
