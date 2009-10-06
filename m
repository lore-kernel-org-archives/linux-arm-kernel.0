From: schen@mvista.com (Steve Chen)
Date: Tue, 06 Oct 2009 07:56:14 -0500
Subject: ARM1176 register writes are in reverse?
In-Reply-To: <b9e8fcbd0910060510y3dd9ea36x6c97db47f0dfc886@mail.gmail.com>
References: <b9e8fcbd0910060510y3dd9ea36x6c97db47f0dfc886@mail.gmail.com>
Message-ID: <1254833774.3153.52.camel@linux-1lbu>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 2009-10-06 at 17:40 +0530, Nicholas Van Orton wrote:
> Hi,
> 
> I noticed that register writes to ARM1176 need to be in the reverse
> order. That is, lets say I need to write 0xABCD to a register. But in
> the actual write using __raw_writel() the value needs to be changed to
> 0xCDAB. Why is this so? The Davinci or OMAP on the other hand for
> example, which is an ARM 926 does not need any such manipulation. Why
> is the ARM1176 an exception?
> 

Are you working with TI Puma5?  I suspect that reverse order is probably
due to specific hardware endianness implementation rather than generic
difference between ARM1176 and ARM926.

Regards,

Steve
