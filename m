From: benjamin.zores@alcatel-lucent.com (Benjamin Zores)
Date: Thu, 17 Jun 2010 08:58:38 +0200
Subject: [PATCH 3/4] arch/arm/mach-kirkwood: add support for 2nd PCIe
	port 	on 88f6282.
In-Reply-To: <AANLkTikRdFDxwQskaCz6ScATh8WHUFN4XwLIyqJ_1U1k@mail.gmail.com>
References: <20100610135936.14097.22635.stgit@localhost.localdomain>	<20100610135946.14097.39894.stgit@localhost.localdomain>
	<AANLkTikRdFDxwQskaCz6ScATh8WHUFN4XwLIyqJ_1U1k@mail.gmail.com>
Message-ID: <4C19C79E.7020903@alcatel-lucent.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/06/2010 17:29, saeed bishara wrote:
>
> you didn't updated the comment the describes the address map.
> also, I suggest you to take this part from the patch I sent, in that
> patch I made sure to make the pcie1 IO physical and virtual address
> consecutive to pcie0, I think without this the IO access to pcie1 will
> not work. please see the __io() macro at
> mach-kirkwood/include/mach/io.h
>    

Will do.

>>      
> you're still using the pcie_port global structure. the patch I sent
> removed it,  can you take this part (changes to kirkwood/pcie.c) from
> my patch?
>    

I removed these parts of your patch because PCIe was no longer working 
on my board with this approach.
I took the same one that was used in mach-mv78xx0.

Ben
