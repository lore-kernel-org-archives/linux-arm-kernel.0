From: hemantp@ti.com (Pedanekar, Hemant)
Date: Fri, 9 Jul 2010 21:11:11 +0530
Subject: Memory type used for ioremap
In-Reply-To: <20100709124850.GH22845@n2100.arm.linux.org.uk>
References: <2A3DCF3DA181AD40BDE86A3150B27B6B030E181724@dbde02.ent.ti.com>
	<20100709124850.GH22845@n2100.arm.linux.org.uk>
Message-ID: <2A3DCF3DA181AD40BDE86A3150B27B6B030E181D0B@dbde02.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Thanks for the clarification, I totally missed TRE setting.

(Regarding MMR, I wanted to say Memory Mapped peripheral registers.)

[...]
> On ARMv7 (which Cortex A8 is) with TEX remapping, we arrange for this bit
> combination to be 'device' and the shared-ness of the mapping depends on the S
> bit.

So if TEX[0]=1 with CB=0 is "Device" then what does TEX[0]=0 with CB=0 make the
region?

I am asking this because the first (default) setting didn't work for me
when writing to the mapped region, while setting TEX[0]=0 worked.

I referred the comment in proc-v7.S, but couldn't make out the meaning of
'TEX[0],C,B= 000' (there is just a mention about 'UNCACHED' but with TR-00).

Thanks
-
Hemant
