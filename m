From: tony@atomide.com (Tony Lindgren)
Date: Mon, 29 Feb 2016 10:16:07 -0800
Subject: [PATCH] ARM: dts: DRA7: change address-cells and size-cells
In-Reply-To: <56D40505.8020702@ti.com>
References: <1456308664-28308-1-git-send-email-lokeshvutla@ti.com>
 <20160226191127.GE13417@atomide.com> <56D40505.8020702@ti.com>
Message-ID: <20160229181606.GM13417@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Lokesh Vutla <a0131933@ti.com> [160229 00:48]:
> On Saturday 27 February 2016 12:41 AM, Tony Lindgren wrote:
> > * Lokesh Vutla <lokeshvutla@ti.com> [160224 02:14]:
> > 
> > Is size-cells 2 needed for all these devices too? Can't
> > you just set it for the memory nodes?
> 
> For updating memory nodes with 64bit, I have to change the address and
> size cells as 2 for the root node. So, reg property in all the children
> to the root node should also be updated with 2 address cells and 2 size
> cells or else the below warning shows up:

Yes I understand that if we need to set it at the top level. But what
happens if you only set it for the memory node?

With just something like:

memory {
       #address-cells = <2>;
       #size-cells = <2>;
       ...
};

Regards,

Tony
