From: james.hogan@imgtec.com (James Hogan)
Date: Thu, 29 Aug 2013 12:13:40 +0100
Subject: clk: add support for clock reparent on set_rate
In-Reply-To: <20130828143652.GA27272@elgon.mountain>
References: <20130828143652.GA27272@elgon.mountain>
Message-ID: <521F2CE4.6090107@imgtec.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 28/08/13 15:36, Dan Carpenter wrote:
> Hello James Hogan,
> 
> This is a semi-automatic email about new static checker warnings.
> 
> The patch 71472c0c06cf: "clk: add support for clock reparent on 
> set_rate" from Jul 29, 2013, leads to the following Smatch complaint:
> 
> drivers/clk/clk.c:1117 clk_reparent()
> 	 warn: variable dereferenced before check 'new_parent' (see line 1113)
> 
> drivers/clk/clk.c
>   1112		if (new_parent->new_child == clk)
>                     ^^^^^^^^^^^^^^^^^^^^^
> Patch addes dereference.
> 
>   1113			new_parent->new_child = NULL;
>   1114	
>   1115		hlist_del(&clk->child_node);
>   1116	
>   1117		if (new_parent)
>                     ^^^^^^^^^^
> Existing check.
> 
>   1118			hlist_add_head(&clk->child_node, &new_parent->children);
>   1119		else

Thanks for reporting this Dan - much appreciated. I've submitted a fix.

Cheers
James
