From: robherring2@gmail.com (Rob Herring)
Date: Fri, 20 Jan 2012 15:23:01 -0600
Subject: [PATCH v2 11/13] ARM: only include mach/irqs.h for !SPARSE_IRQ
In-Reply-To: <alpine.LFD.2.02.1201201608400.19587@xanadu.home>
References: <1327091591-27125-1-git-send-email-robherring2@gmail.com>
 <1327091591-27125-12-git-send-email-robherring2@gmail.com>
 <alpine.LFD.2.02.1201201608400.19587@xanadu.home>
Message-ID: <4F19DB35.9060707@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/20/2012 03:11 PM, Nicolas Pitre wrote:
> On Fri, 20 Jan 2012, Rob Herring wrote:
> 
>> From: Rob Herring <rob.herring@calxeda.com>
>>
>> Make mach/irqs.h optional for SPARSE_IRQ. With this change irqs.h can be
>> removed by converting platforms over to sparse irq.
>>
>> This intentionally breaks platforms that enable SPARSE_IRQ.
> 
> I don't get what you mean here.  The above seems contradictory.
> 

You're right. The intro explains things more clearly. This breaks
platforms (at boot time) that don't select SPARSE_IRQ, but let users
enable it in their config. I don't understand why sparse irq is a user
visible config option. We could move HAVE_SPARSE_IRQ down to each
platform that selects SPARSE_IRQ and prevent enabling, but I think
allowing it to break is good encouragement for others to fix those
platforms. I'm open to other ideas.

Rob
