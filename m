From: paul.gortmaker@windriver.com (Paul Gortmaker)
Date: Thu, 25 Aug 2011 11:37:11 -0400
Subject: [GIT PULL] orion5x and footbridge compile fixes for 3.1
In-Reply-To: <4E565AC4.7060504@gmail.com>
References: <4E565AC4.7060504@gmail.com>
Message-ID: <4E566C27.3020409@windriver.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11-08-25 10:23 AM, Rob Herring wrote:
> Arnd,
> 
> Please pull for 3.1-rc. Footbridge and orion5x builds are currently
> broken in 3.1 mainly due to my changes in this commit:
> 
> commit cc22b4c18540e5e8bf55c7d124044f9317527d3c
> Author: Rob Herring <rob.herring@calxeda.com>
> Date:   Tue Jun 28 21:22:40 2011 -0500
> 
>     ARM: set vga memory base at run-time
> 
> 
> The following changes since commit fcb8ce5cfe30ca9ca5c9a79cdfe26d1993e65e0c:
> 
>   Linux 3.1-rc3 (2011-08-22 11:42:53 -0700)
> 
> are available in the git repository at:
>   git://git.jdl.com/software/linux-3.0.git fixes
> 
> Bryan Wu (2):
>       ARM: mach-orion5x: add missing header file <linux/vga.h>
>       ARM: mach-footbridge: add missing header file <video/vga.h>

I had similar commits to the two above in the module.h tree
(in linux-next) since I thought the missing vga.h was fallout
from the implicit presence of module.h everywhere.

I'll drop all three from linux-next now that they are scheduled
for pulling into 3.1-rcN.

Thanks,
Paul.

> 
> Paul Gortmaker (1):
>       arm: fix compile failure in orion5x/dns323-setup.c
> 
>  arch/arm/mach-footbridge/dc21285.c   |    1 +
>  arch/arm/mach-orion5x/dns323-setup.c |    2 +-
>  arch/arm/mach-orion5x/pci.c          |    1 +
>  3 files changed, 3 insertions(+), 1 deletions(-)
> 
> Rob
