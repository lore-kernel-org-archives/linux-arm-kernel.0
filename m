From: armando.visconti@st.com (Armando Visconti)
Date: Thu, 2 Sep 2010 10:09:02 +0200
Subject: [PATCH 27/74] ST SPEAr : NAND interface driver for spear platforms
In-Reply-To: <AANLkTik9Di4k183t+wuY-1eprsO3xBOESaOY5dnxt6ii@mail.gmail.com>
References: <cover.1283161023.git.viresh.kumar@st.com>	<07ce8daf18d3a9f13864752074af3490a324d84c.1283161023.git.viresh.kumar@st.com>	<7cd7060b403b448d74649cec5c28c795bcbbdbc3.1283161023.git.viresh.kumar@st.com>
	<AANLkTik9Di4k183t+wuY-1eprsO3xBOESaOY5dnxt6ii@mail.gmail.com>
Message-ID: <4C7F5B9E.8090406@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Ciao Linus,

Linus Walleij wrote:
> 2010/8/30 Viresh KUMAR <viresh.kumar@st.com>:
>
>   
>> From: Vipin Kumar <vipin.kumar@st.com>
>>
>> SPEAr platforms use Flexible Static Memory Controller(FSMC) provided by ST for
>> interfacing with NAND devices.
>> This patch adds the support for glue logic for NAND flash on SPEAr boards
>>     
>
> OK...
>
>   
>> (...)
>>  create mode 100644 arch/arm/plat-spear/include/plat/fsmc.h
>>  create mode 100644 arch/arm/plat-spear/include/plat/nand.h
>>  create mode 100644 drivers/mtd/nand/spear_nand.c
>>     
>
> spear_nand.c?
>
> Why not fsmc-nand.c or similar if this is the name of the block.
> We have this in U300, Nomadik NHK8815 and other platforms too,
> it doesn't have much to do with SPEAr actually...
>
> Also, what are the include files doing in plat-spear since we have
> the same hardware in other platforms? Move them to include/linux/mtd/
> so we can use them please.
>
> I *highly* suspect that this driver duplicates some code found in
> drivers/mtd/nand/nomadik_nand.c because it's the same silicon.
>   
Why nomadik_nand.c?
Shouldn't the fsmc_nand.c rule apply also in this case?


> Alessandro can judge on this, but I have a feeling that driver
> should be replaced by this, more mature driver.
>   
Maybe.
But I suspect that may be few differences in the ECC accelerator inside, 
in fact.

In our FSMC previous case it was a Hamming accelerator, and I think this 
apply
also for nomadik (maybe). In our sp1300 case it is a BCH with 104 bytes 
of ECC.

This is one of the options when generating the h/w block, so FSMCs may 
differ.
If we want to re-use same driver I guess we might change something and 
accept
few parameters from the platform.

Vipin can for sure comment more on this.....


Rgds,
Arm

-- 
-- "Every step appears to be the unavoidable consequence of the
-- preceding one." (A. Einstein) 
-- 
Armando Visconti                  Mobile: (+39) 346 8879146
Senior SW Engineer                Fax:    (+39) 02 93519290
CPG                               Work:   (+39) 02 93519683
Computer System Division          e-mail: armando.visconti at st.com
ST Microelectronics               TINA:   051  4683
                                    
 
