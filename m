From: bgat@billgatliff.com (Bill Gatliff)
Date: Thu, 28 Jan 2010 11:15:49 -0600
Subject: disable_irq() causes hang on AT91RM9200 targets?
In-Reply-To: <4B61C2C7.2000405@billgatliff.com>
References: <4B61C2C7.2000405@billgatliff.com>
Message-ID: <4B61C645.4030104@billgatliff.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Bill Gatliff wrote:
> Guys:
>
>
> Has anyone noticed that with 2.6.33-rc5 (at least) on AT91RM9200,
> disable_irq() seems to cause a lockup when the interrupt number is a
> GPIO line?  I'm calling disable_irq() from an interrupt handler on the
> same GPIO line.
>
> I just saw this happen, and it seems to be repeatable.  Just wondering
> if this is a known issue before I start digging into it...
>   

Heh, disable_irq_nosync().  D'oh!  :)


b.g.

-- 
Bill Gatliff
bgat at billgatliff.com
