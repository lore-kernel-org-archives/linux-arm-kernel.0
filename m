From: vdumpa@nvidia.com (Krishna Reddy)
Date: Tue, 6 Mar 2012 23:06:13 -0800
Subject: [PATCHv7 9/9] ARM: dma-mapping: add support for IOMMU mapper
In-Reply-To: <20120307.083706.2087121294965856946.hdoyu@nvidia.com>
References: <000001ccfaea$00c16f70$02444e50$%szyprowski@samsung.com><401E54CE964CD94BAE1EB4A729C7087E37970113FE@HQMAIL04.nvidia.com><20120307.080952.2152478004740487196.hdoyu@nvidia.com>
 <20120307.083706.2087121294965856946.hdoyu@nvidia.com>
Message-ID: <401E54CE964CD94BAE1EB4A729C7087E37973BEA74@HQMAIL04.nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> > > It should be as follows.
> > > unsigned int count = 1 << get_order(size) - order;
> 
> To be precise, as below?
> 
>  unsigned int count = 1 << (get_order(size) - order);

Minus has more precedence than left shift.
"1 << get_order(size) - order;" is equivalent to 1 << (get_order(size) - order);

-KR
--nvpublic
