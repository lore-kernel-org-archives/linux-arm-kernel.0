From: olof@lixom.net (Olof Johansson)
Date: Tue, 5 Jul 2016 21:46:00 -0700
Subject: [GIT PULL] ARM: hisi: DT changes for v4.8
In-Reply-To: <5772B7F0.6040600@hisilicon.com>
References: <5772B7F0.6040600@hisilicon.com>
Message-ID: <20160706044600.GH23212@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 28, 2016 at 06:46:24PM +0100, Wei Xu wrote:
> Hi Arnd, Hi Olof, Hi Kevin,
> 
> Please help to pull the following changes.
> Thanks!
> 
> Best Regards,
> Wei
> 
> ---
> 
> The following changes since commit 1a695a905c18548062509178b98bc91e67510864:
> 
>   Linux 4.7-rc1 (2016-05-29 09:29:24 -0700)
> 
> are available in the git repository at:
> 
>   git://github.com/hisilicon/linux-hisi.git tags/hisi-armv7-soc-dt-for-4.8
> 
> for you to fetch changes up to 04f66aa916c141113266646942d449b5781550e3:
> 
>   ARM: dts: add dts files for Hi3519 and tidy up the makefile entries (2016-06-28 17:27:53 +0100)
> 
> ----------------------------------------------------------------
> ARM: DT: Hisilicon ARMv7 SoC Hi3519 DT updates for 4.8
> 
> - Add device tree bindings for hi3519 sysctrl
> - Add dts files for hi3519
> - Tidy up DTB makefile entries to keep the list sorted

This isn't tidying up the makefile, the list isn't sorted:

 dtb-$(CONFIG_ARCH_HIGHBANK) += \                                                                                                                   
        highbank.dtb \                                                                                                                              
        ecx-2000.dtb                                                                                                                                
+dtb-$(CONFIG_ARCH_HISI) += \                                                                                                                       
+       hi3519-demb.dtb                                                                                                                             
+dtb-$(CONFIG_ARCH_HIX5HD2) += \                                                                                                                    
+       hisi-x5hd2-dkb.dtb                                                                                                                          
 dtb-$(CONFIG_ARCH_HIP01) += \                                                                                                                      
        hip01-ca9x2.dtb          

Last time I checked, both S and X came after P.

Not merging this.


-Olof
