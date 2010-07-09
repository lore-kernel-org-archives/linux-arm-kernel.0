From: catalin.marinas@arm.com (Catalin Marinas)
Date: Fri, 09 Jul 2010 13:11:04 +0100
Subject: Memory type used for ioremap
In-Reply-To: <2A3DCF3DA181AD40BDE86A3150B27B6B030E181724@dbde02.ent.ti.com>
References: <2A3DCF3DA181AD40BDE86A3150B27B6B030E181724@dbde02.ent.ti.com>
Message-ID: <1278677464.11895.41.camel@e102109-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 2010-07-09 at 03:16 +0100, Pedanekar, Hemant wrote:
> I have few doubts regarding the memory type configured when we call
> ioremap for mapping a region (e.g., on-chip peripheral MMRs):
>  
> Please note that this is regarding Cortx A8.
>  
> After examining 2nd level page descriptor, I see that the memory type
> configured for ioremapped region (as per TEX[2:0]=1 and CB=0) is
> "Outer and Inner Non-cacheable - Normal". Is this correct
> observation? I thought the ioremap would set memory type as one of the
> "Device". 
>  
> What is the recommended method if I want to map some region as
> "Strongly-ordered" or "Device"?

If you are trying to ioremap normal RAM, we no longer allow this and
force the memory type to be Normal Non-cacheable. This is an ARM
architecture requirement (otherwise you create mismatched memory
attributes aliases).


-- 
Catalin
