From: robherring2@gmail.com (Rob Herring)
Date: Mon, 12 Mar 2012 13:33:28 -0500
Subject: [PATCH 3/4] ARM: create a common IOMEM definition
In-Reply-To: <201203112134.45302.arnd@arndb.de>
References: <1331500100-31351-1-git-send-email-robherring2@gmail.com>
 <1331500100-31351-4-git-send-email-robherring2@gmail.com>
 <201203112134.45302.arnd@arndb.de>
Message-ID: <4F5E4178.50801@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/11/2012 04:34 PM, Arnd Bergmann wrote:
> On Sunday 11 March 2012, Rob Herring wrote:
>> From: Rob Herring <rob.herring@calxeda.com>
>>
>> Several platforms create IOMEM defines for casting to 'void __iomem *',
>> and other platforms are incorrectly using __io() macro for the same
>> purpose. This creates a common definition and removes all the platform
>> specific versions. Rather than try to make linux/io.h and asm/io.h
>> assembly safe, the assembly version of IOMEM is moved into
>> asm/assembler.h.
> 
> Looks good to me, in order to fix the problem at hand. I'm not sure
> about spreading the IOMEM() macro further, that is largely a separate
> problem and only a question of style, not of correctness as with __io().

Got a better suggestion? I didn't think adding IOMEM to 5 more platforms
or inventing something different was the right path. Hopefully this is a
shrinking problem as things move to DT.

Rob

> Acked-by: Arnd Bergmann <arnd@arndb.de>
