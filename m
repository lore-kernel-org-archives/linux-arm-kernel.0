From: bgat@billgatliff.com (Bill Gatliff)
Date: Fri, 11 Sep 2009 10:20:23 -0500
Subject: smsc911x.c driver and SMP (was Re: Kernel related (?) user space
	crash at ARM11 MPCore)
In-Reply-To: <1252674034.29620.30.camel@pc1117.cambridge.arm.com>
References: <4A7AEEB6.5060903@googlemail.com>	
	<1249981883.27150.14.camel@pc1117.cambridge.arm.com>	
	<4A818CBC.8040000@googlemail.com>	
	<1250006770.30628.1.camel@pc1117.cambridge.arm.com>	
	<4A819C54.3080606@googlemail.com>	
	<1250009043.30628.9.camel@pc1117.cambridge.arm.com>	
	<87ab25vazg.fsf@brigitte.kvy.fi>	
	<1250080338.20332.32.camel@pc1117.cambridge.arm.com>	
	<87k518yc8a.fsf@brigitte.kvy.fi>	
	<1252660898.3354.16.camel@pc1117.cambridge.arm.com>	
	<4AAA48CA.9040405@billgatliff.com>
	<1252674034.29620.30.camel@pc1117.cambridge.arm.com>
Message-ID: <4AAA6AB7.60808@billgatliff.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Catalin Marinas wrote:
> On Fri, 2009-09-11 at 07:55 -0500, Bill Gatliff wrote:
>   
>>
>> Why take the lock in smsc911x_tx_writefifo?  It looks like you take the 
>> same lock again in smsc911x_reg_write.
>>     
>
> Ah, ok, I haven't tried the 16-bit mode, only the 32-bit one and was
> working fine, no deadlocks. But I can't say whether that's the right
> fix, it's better for SMSC to look into it.
>
>   

I certainly won't object to SMSC taking a look at it.  :)  But your 
changes pass the common-sense test AFAICT, apart from my question above.




b.g.

-- 
Bill Gatliff
bgat at billgatliff.com
