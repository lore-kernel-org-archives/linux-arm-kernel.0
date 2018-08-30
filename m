From: Jisheng.Zhang@synaptics.com (Jisheng Zhang)
Date: Thu, 30 Aug 2018 11:27:58 +0800
Subject: [PATCH 4/5] net: mvneta: enable NETIF_F_RXCSUM by default
In-Reply-To: <20180829130836.GD1955@lunn.ch>
References: <20180829162456.2bd69796@xhacker.debian>
 <20180829162932.6015e89d@xhacker.debian>
 <20180829130836.GD1955@lunn.ch>
Message-ID: <20180830112745.61502abf@xhacker.debian>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Andrew,

On Wed, 29 Aug 2018 15:08:36 +0200 Andrew Lunn wrote:

> On Wed, Aug 29, 2018 at 04:29:32PM +0800, Jisheng Zhang wrote:
> > The code and HW supports NETIF_F_RXCSUM, so let's enable it by default.  
> 
> Hi Jisheng
> 
> I've never studied what all these different flags mean. Does
> NETIF_F_RXCSUM mean Ethernet FCS? Or does it also include IPv4, IPv6,
> UDP, TCP... checksums?

Per my understanding, it means RX checksumming. And it only supports IPv4
RX checksum, the code will

> 
> I've seen network interfaces get checksum'ing wrong when used with an
> Ethernet switch with DSA. The extra header DSA uses means the hardware
> cannot parse the packet correctly, and so cannot find these headers.

The network interface is mvneta? Do you mean after this patch, we would
see errors as the following?

"bad rx status 0xabcdefgh (crc error)"

So for DSA, we should disable RXCSUM? I'm not sure how to handle this case.
I believe other drivers(with RXCSUM enabled by deafult) also have this problem
with DSA.

Thanks

> 
> If this is just for FCS, then it is not a problem.
> 
>    Thanks
> 	Andrew
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
