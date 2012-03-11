From: arnd@arndb.de (Arnd Bergmann)
Date: Sun, 11 Mar 2012 21:34:44 +0000
Subject: [PATCH 3/4] ARM: create a common IOMEM definition
In-Reply-To: <1331500100-31351-4-git-send-email-robherring2@gmail.com>
References: <1331500100-31351-1-git-send-email-robherring2@gmail.com>
 <1331500100-31351-4-git-send-email-robherring2@gmail.com>
Message-ID: <201203112134.45302.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sunday 11 March 2012, Rob Herring wrote:
> From: Rob Herring <rob.herring@calxeda.com>
> 
> Several platforms create IOMEM defines for casting to 'void __iomem *',
> and other platforms are incorrectly using __io() macro for the same
> purpose. This creates a common definition and removes all the platform
> specific versions. Rather than try to make linux/io.h and asm/io.h
> assembly safe, the assembly version of IOMEM is moved into
> asm/assembler.h.

Looks good to me, in order to fix the problem at hand. I'm not sure
about spreading the IOMEM() macro further, that is largely a separate
problem and only a question of style, not of correctness as with __io().

Acked-by: Arnd Bergmann <arnd@arndb.de>
