From: bgat@billgatliff.com (Bill Gatliff)
Date: Fri, 11 Sep 2009 07:55:38 -0500
Subject: smsc911x.c driver and SMP (was Re: Kernel related (?) user space
	crash at ARM11 MPCore)
In-Reply-To: <1252660898.3354.16.camel@pc1117.cambridge.arm.com>
References: <4A7AEEB6.5060903@googlemail.com>	<1249981883.27150.14.camel@pc1117.cambridge.arm.com>	<4A818CBC.8040000@googlemail.com>	<1250006770.30628.1.camel@pc1117.cambridge.arm.com>	<4A819C54.3080606@googlemail.com>	<1250009043.30628.9.camel@pc1117.cambridge.arm.com>	<87ab25vazg.fsf@brigitte.kvy.fi>	<1250080338.20332.32.camel@pc1117.cambridge.arm.com>	<87k518yc8a.fsf@brigitte.kvy.fi>
	<1252660898.3354.16.camel@pc1117.cambridge.arm.com>
Message-ID: <4AAA48CA.9040405@billgatliff.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Catalin Marinas wrote:
> (sorry for the repost Antti, the message was sent to the old list and
> didn't like the "was:" stuff in the subject and the reply headers)
>
> On Thu, 2009-08-13 at 00:05 +0300, Antti P Miettinen wrote:
>   
>> BTW - the smsc911x does not work for me in the
>> recent kernels. I had to change back to smc911x. Otherwise my boot
>> from NFS root hangs pretty early. I think it used to be the other way
>> around in some kernel version.
>>     
>
> I added the commit below to my tree and the new driver now seems to work
> fine with ARM11MPCore systems:
>
> http://www.linux-arm.org/git?p=linux-2.6.git;a=commitdiff;h=246a6cc1f1fa52e96a08f327337c5616eb634825
>
> I'm waiting for the SMSC guys to look into this issue. It may just be
> that some of the read-after-write or read-after-read timing constraints
> are violated when more than one CPU tries to access the Ethernet chip.
>
>   

Why take the lock in smsc911x_tx_writefifo?  It looks like you take the 
same lock again in smsc911x_reg_write.


b.g.

-- 
Bill Gatliff
bgat at billgatliff.com
