From: gerlando.falauto@keymile.com (Gerlando Falauto)
Date: Tue, 01 Oct 2013 17:27:31 +0200
Subject: [patch 0/8] genirq: Support for irq domains in generic irq chip
 - V2
In-Reply-To: <20130506142348.321859745@linutronix.de>
References: <20130506142348.321859745@linutronix.de>
Message-ID: <524AE9E3.4080701@keymile.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Thomas, Sebastian,

I see these changes made it to 3.11.
AFAICT though, 3.10.9 still has the original bug (the one that got me to 
write the patch for handling separate mask registers) and I am bit 
confused as to how to integrate that back into 3.10 (or any previous 
affected kernels, as they deserve a fix as well!).

The way I understand it, any mainstream patch would be based on this 
work, which is not available on previous kernels. And I guess 
backporting the whole thing would be overkill.
So I believe the only way to fix it on older kernels would be to write 
one (or more) minimal version-specific patch series.
But then I wonder: would that be acceptable material for linux-stable?

Please correct me if I'm totally wrong here. I'm willing to help & test 
but I need directions.

Thanks,
Gerlando

On 05/06/2013 04:30 PM, Thomas Gleixner wrote:
> Changes vs. V1:
>
> 	- Fixed the generic chip pointer thinko (Sebastian Hesselbarth)
>
> 	- Proper support for mask cache
>
> 	- Read mask hardware only for the first map of an generic chip
>            instance
>
> 	- sun4i prefix irq functions proper
>
> Thanks,
>
> 	tglx
>
>
