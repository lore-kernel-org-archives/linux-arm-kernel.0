From: w@1wt.eu (Willy Tarreau)
Date: Fri, 19 Apr 2013 15:12:37 +0200
Subject: MVEBU and MVNETA driver
In-Reply-To: <5171419C.2090003@itooo.com>
References: <5171419C.2090003@itooo.com>
Message-ID: <20130419131237.GC22440@1wt.eu>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Greg,

On Fri, Apr 19, 2013 at 03:07:40PM +0200, Greg wrote:
> Hello All,
> 
> This is my first post there, let me introduce myself: I am an embedded 
> systems designer working in a French ISP. My goal is to design devices 
> with a minimalistic software package installed that system/software 
> engineers can use as a base for their work. Said in a few words : I'm 
> not the kernel expert but I have some knowledge of it.
> 
> That being said, I'm currently working with a Marvell ArmadaXP SoC and 
> I'm performing the transition from Marvell "Linux Support Package" to 
> MVEBU in the 3.8.8 Vanilla.
> Having the system up and running was actually quite easy, Thomas 
> Petazzoni and his team did a very good job!
> 
> I'm facing a problem with ethernet transmission (reception -seems- to be 
> fine), at best is it slow (~90Mbps), at worst the kernel OOPSes at 
> various locations dealing with memory (tcp_v4_destroy_sock, free_block 
> and skb_put seen so far) and ends up crashing right after.
> I'm simply using iperf to generate traffic and the system has been 
> stable for a while with Marvell's LSP so I can say with confidence the 
> hardware is pretty stable.
> 
> My question is fairly simple : before complaining about the network 
> driver (which might not even be involved in this), what is the starting 
> point to gather more information about this problem and what data should 
> I provide you to help you advising me ?

You need to get the following commit from mainline to fix this issue :

   ee40a116ebf139f900c3d2e6febb8388738e96d0

Cheers,
Willy

PS: is it indiscrete to ask what board this is ?
