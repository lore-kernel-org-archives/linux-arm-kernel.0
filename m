From: marc.zyngier@arm.com (Marc Zyngier)
Date: Thu, 04 Apr 2013 13:40:18 +0100
Subject: [PATCH 2/7] ARM: KVM: fix HYP mapping limitations around zero
In-Reply-To: <20130403231409.GB29227@gmail.com>
References: <1364909115-3810-1-git-send-email-marc.zyngier@arm.com>
 <1364909115-3810-3-git-send-email-marc.zyngier@arm.com>
 <20130403231409.GB29227@gmail.com>
Message-ID: <515D74B2.5030509@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/04/13 00:14, Christoffer Dall wrote:
> On Tue, Apr 02, 2013 at 02:25:10PM +0100, Marc Zyngier wrote:
>> The current code for creating HYP mapping doesn't like to wrap
>> around zero, which prevents from mapping anything into the last
>> page of the virtual address space.
>>
>> It doesn't take much effort to remove this limitation, making
>> the code more consistent with the rest of the kernel in the process.
> 
> This is quite funny, the code used to behave like this, but
> reviewers said that this was old fashioned mm-style code that was
> unwanted and wrapping around zero should be avoided for all costs :)

My original attempt at this series was using the very last page of the
memory, and it took me a while to notice that the code couldn't map
anything in the last page.

Just for this reason, the code needed to be fixed.

> In any case, I welcome the familiarity.

Amen.

	M.
-- 
Jazz is not dead. It just smells funny...
