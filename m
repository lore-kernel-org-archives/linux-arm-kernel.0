From: gang.chen@asianux.com (Chen Gang)
Date: Mon, 27 May 2013 18:49:55 +0800
Subject: [PATCH] ARM: S5PV210: dependency issue, S5P_SLEEP is depend on
 ARM_CPU_SUSPEND
In-Reply-To: <158201ce5ac2$a7843de0$f68cb9a0$%kim@samsung.com>
References: <5199E4AF.7040607@asianux.com> <51A32FD4.4000001@asianux.com>
 <158201ce5ac2$a7843de0$f68cb9a0$%kim@samsung.com>
Message-ID: <51A33A53.1050502@asianux.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/27/2013 06:12 PM, Kukjin Kim wrote:
>>>  config S5P_SLEEP
>>> > >  	bool
>>> > > +	select ARM_CPU_SUSPEND
> Probably,
> 
> +	select ARM_CPU_SUSPEND if PM ?
> 
> selecting the S5P_SLEEP depends on PM though...

After reference another platform, they are really all "select
ARM_CPU_SUSPEND if PM", we'd really better to follow by to let readers
easy understanding.

I will send patch v2.


Thanks.
-- 
Chen Gang

Asianux Corporation
