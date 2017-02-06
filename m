From: David.Laight@ACULAB.COM (David Laight)
Date: Mon, 6 Feb 2017 12:43:17 +0000
Subject: [PATCHv2 net-next 05/16] net: mvpp2: introduce PPv2.2 HW
 descriptors and adapt accessors
In-Reply-To: <20170204145938.6e6380d9@free-electrons.com>
References: <1482943592-12556-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1482943592-12556-6-git-send-email-thomas.petazzoni@free-electrons.com>
 <20170106142901.GC14217@n2100.armlinux.org.uk>
 <113811b6-79a4-9c66-d302-add9fb0c5b1a@arm.com>
 <20170203142446.2ee517a7@free-electrons.com>
 <231514f4-2e35-8bde-4469-aada833635aa@arm.com>
 <20170203155449.GC27312@n2100.armlinux.org.uk>
 <20170204145938.6e6380d9@free-electrons.com>
Message-ID: <063D6719AE5E284EB5DD2968C1650D6DB027C728@AcuExch.aculab.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Thomas Petazzoni
> Sent: 04 February 2017 14:00
...
> This makes complete sense. We use the cookie to store the phys_addr_t
> rather than the virtual address. I might be missing something, but it
> seems like a very good solution. Thanks for the suggestion, I'll try
> this!

Why not just store an array index for the buffer info?
That would save you having to regenerate kernel virtual
addresses from limited info.

Or realise that the low bits (page offset) of the dma address
and kernel virtual address (and kernel physical for that matter)
will always match. 50 bits might be enough for a kernel virtual address.

	David
