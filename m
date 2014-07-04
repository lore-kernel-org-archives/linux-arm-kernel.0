From: ezequiel.garcia@free-electrons.com (Ezequiel Garcia)
Date: Fri, 4 Jul 2014 16:06:47 -0300
Subject: [PATCH 2/3] ARM: mvebu: Add support for the network controller
 in Armada 375 SoC
In-Reply-To: <53B6F796.3090004@cogentembedded.com>
References: <1404498697-21978-1-git-send-email-ezequiel.garcia@free-electrons.com>
 <1404498697-21978-3-git-send-email-ezequiel.garcia@free-electrons.com>
 <53B6F796.3090004@cogentembedded.com>
Message-ID: <20140704190647.GA29955@arch.cereza>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04 Jul 10:51 PM, Sergei Shtylyov wrote:
> >+			/* Network controller */
> >+			pp2 at f0000 {
> >+				compatible = "marvell,armada-375-pp2";
> >+				reg = <0xf0000 0xa000>, /* Packet Processor regs */
> >+				      <0xc0000 0x3060>, /* LMS regs */
> >+				      <0xc4000 0x100>,  /* eth0 regs */
> >+				      <0xc5000 0x100>;  /* eth1 regs */
> 
>    Hm, why are the above two ranges not listed under the "ethernet" subnodes?
> 

Because as far as I know, if we want to put reg = <...> properties in a sub-node,
then the parent node has to be a bus, but that's not the case.

I can't remember where have I read that, I'll take a look at the reference.
-- 
Ezequiel Garc?a, Free Electrons
Embedded Linux, Kernel and Android Engineering
http://free-electrons.com
