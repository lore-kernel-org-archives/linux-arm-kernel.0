From: nico@fluxnic.net (Nicolas Pitre)
Date: Mon, 14 Nov 2011 12:41:15 -0500 (EST)
Subject: [PATCH 2/2] ARM: topdown mmap support
In-Reply-To: <1320709421-14469-2-git-send-email-robherring2@gmail.com>
References: <1320709421-14469-1-git-send-email-robherring2@gmail.com>
 <1320709421-14469-2-git-send-email-robherring2@gmail.com>
Message-ID: <alpine.LFD.2.02.1111141237080.3307@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 7 Nov 2011, Rob Herring wrote:

> From: Rob Herring <rob.herring@calxeda.com>
> 
> Similar to other architectures, this adds topdown mmap support in user
> process address space allocation policy. This allows mmap sizes greater
> than 2GB. This support is largely copied from MIPS and the generic
> implementations.
> 
> The address space randomization is moved into arch_pick_mmap_layout.

This is a problem by effectively weakening the randomization greatly.  
Now you get a random starting point but all mmaps are otherwise fixed 
relative to each other, whereas you had random distances between each 
mmaps before.


Nicolas
