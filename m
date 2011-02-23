From: sshtylyov@mvista.com (Sergei Shtylyov)
Date: Wed, 23 Feb 2011 23:49:49 +0300
Subject: [PATCH v3 1/2] PRUSS UIO driver support
In-Reply-To: <alpine.LFD.2.00.1102232057260.2701@localhost6.localdomain6>
References: <1298469161-7644-1-git-send-email-pratheesh@ti.com>	<1298469161-7644-2-git-send-email-pratheesh@ti.com>
	<alpine.LFD.2.00.1102232057260.2701@localhost6.localdomain6>
Message-ID: <4D6572ED.9020805@mvista.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello.

On 23-02-2011 23:25, Thomas Gleixner wrote:

>> +	prussio_virt_addr =
>> +	    ioremap(regs_prussio->start,
>> +		    regs_prussio->end - regs_prussio->start + 1);

> Either make those variable names shorter or do:

>         len = regs_prussio->end - regs_prussio->start + 1;

    Or even:

	len = resource_size(regs_prussio);

>         prussio_virt_addr = ioremap(regs_prussio->start, len);

WBR, Sergei
