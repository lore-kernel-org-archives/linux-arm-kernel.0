From: nico@fluxnic.net (Nicolas Pitre)
Date: Thu, 03 Feb 2011 18:31:11 -0500 (EST)
Subject: [PATCH RFC] ARM: Make VMALLOC_END a variable
In-Reply-To: <AANLkTinadBvmnjN=kUt82e=hmM0xumFs8WP_ca8V-e8Y@mail.gmail.com>
References: <AANLkTinadBvmnjN=kUt82e=hmM0xumFs8WP_ca8V-e8Y@mail.gmail.com>
Message-ID: <alpine.LFD.2.00.1102031827020.12104@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 26 Jan 2011, Eric Miao wrote:

> VMALLOC_END is machine specific and is preventing multiple SoCs from
> being built together. This patch makes it into a global variable and
> is initially defined in 'struct machine_desc' (.vmalloc_end).  Each board
> file must define this. As a result, machine specific vmalloc.h are
> no longer needed and thus are removed.
> 
> This is really a big hunk of change, so I make it as attachment,
> and the diff stat below.

To solve this particular issue, I'd split this into 2 patches: the first 
adding the entry to machine records, and the second one deleting the 
unneeded vmalloc.h files.


Nicolas
