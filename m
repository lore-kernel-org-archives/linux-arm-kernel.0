From: dhylands@gmail.com (Dave Hylands)
Date: Thu, 24 Sep 2009 22:04:24 -0700
Subject: About ARM TCM patch
In-Reply-To: <4ABC1D1D.6050506@gmail.com>
References: <4ABC1D1D.6050506@gmail.com>
Message-ID: <c32efac40909242204x53761880w37af72f9e93b7b0c@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Peter,

On Thu, Sep 24, 2009 at 6:30 PM, Peter Chen <hzpeterchen@gmail.com> wrote:
> Dear ML,
>
> I read the TCM patch from http://lwn.net/Articles/353032/
>
> It said:
> Code executing inside the ITCM does not "see" any MMU mappings
> and e.g. register accesses must be made to physical addresses.
>
> I am doubt it is correctly for all systems, at my SoC platform(arm1136JF,
> v6), the situation is difference.
>
> 1. After MMU open, the code running at ITCM can't see physical address for
> register.
>
> 2. After MMU open, the code can't run at physical addressed ITCM.

That's my understanding as well. Once the MMU is enabled, ALL access
go through the MMU, whether they originate from the ITCM or not.

-- 
Dave Hylands
Shuswap, BC, Canada
http://www.DaveHylands.com/
