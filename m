From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 29 Feb 2016 21:45:09 +0100
Subject: [PATCH] ARM: dts: DRA7: change address-cells and size-cells
In-Reply-To: <20160229181606.GM13417@atomide.com>
References: <1456308664-28308-1-git-send-email-lokeshvutla@ti.com>
 <56D40505.8020702@ti.com> <20160229181606.GM13417@atomide.com>
Message-ID: <17470332.nnZZr9fh67@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 29 February 2016 10:16:07 Tony Lindgren wrote:
> Yes I understand that if we need to set it at the top level. But what
> happens if you only set it for the memory node?
> 
> With just something like:
> 
> memory {
>        #address-cells = <2>;
>        #size-cells = <2>;
>        ...
> };

Nothing happens there: the memory node has no children, and no
ranges property, so the two properties are never referenced.

	Arnd
