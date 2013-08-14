From: olof@lixom.net (Olof Johansson)
Date: Wed, 14 Aug 2013 00:23:28 -0700
Subject: [GIT 00/19 v2] Renesas ARM based SoC pinmux updates for v3.12
In-Reply-To: <cover.1374625203.git.horms+renesas@verge.net.au>
References: <cover.1374625203.git.horms+renesas@verge.net.au>
Message-ID: <20130814072328.GA30577@quad.lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 24, 2013 at 09:32:14AM +0900, Simon Horman wrote:
> Hi Olof, Hi Arnd,
> 
> please consider the following pinmux updates for v3.12.
> 
> Difference with v1 of this pull-request:
> * Remove bogus i2c portions of the first patch of the series.
> * Correct addressing mode used in dts of the first patch of the series.
> * Removal of egg from face: wip
> 
> The following changes since commit ad81f0545ef01ea651886dddac4bef6cec930092:
> 
>   Linux 3.11-rc1 (2013-07-14 15:18:27 -0700)
> 
> are available in the git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/horms/renesas.git tags/renesas-pinmux-for-v3.12

Pulled, but I noticed this. Can you please follow up with bindings revisit in
time for 3.12 final (i.e. if we need to take it after merge window that's
probably OK):

        pfc: pfc at e6060000 {                                                     
                compatible = "renesas,pfc-r8a7790";                             
                reg = <0 0xe6060000 0 0x250>;                                   
                #gpio-range-cells = <3>;                                        
        };                                                                      
                                                                                                               
        sdhi0: sdhi at ee100000 {                                                  
                compatible = "renesas,r8a7790-sdhi"; 


I.e. different ordering on the compatible values looks a bit uncoordinated.

I resolved the conflicts by inserting the entries alphabetically; most
DTS files are ordered by address instead of alphabetically, but I stuck
to the current norm per-file.


-Olof
