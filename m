From: jc@eclis.ch (Jean-Christian de Rivaz)
Date: Tue, 29 Sep 2015 19:50:08 +0200
Subject: Unhandled fault or spinlock lockup suspected ?
In-Reply-To: <20150929162246.GK21513@n2100.arm.linux.org.uk>
References: <560AB619.2040502@eclis.ch>
 <20150929162246.GK21513@n2100.arm.linux.org.uk>
Message-ID: <560ACF50.8030205@eclis.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Le 29. 09. 15 18:22, Russell King - ARM Linux a ?crit :
> On Tue, Sep 29, 2015 at 06:02:33PM +0200, Jean-Christian de Rivaz wrote:
>> I tried the last git linux master on a embedded system that worked with a
>> 3.19.0 kernel before. I solved most of the problems caused by the kernel
>> upgrade, but every 15 to 20 minutes I get this type of kernel report:
> Yes, it's because of the user access changes.  The uaccess_with_memcpy()
> code got broken, and despite trying to fix it, it seems that it's still
> broken.  I'll try again to fix it in the next few days.
>
> In any case, unless you have a Marvell platform, you should have this
> disabled - it provides a performance boost for Marvell platforms, but
> degrades performance everywhere else.  Please ensure that you disable
> CONFIG_UACCESS_WITH_MEMCPY.
>

Hi Russell, many thanks for your fast help. Work well when 
CONFIG_UACCESS_WITH_MEMCPY is disabled.

Jean-Christian
