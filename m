From: Sudeep.KarkadaNagesha@arm.com (Sudeep KarkadaNagesha)
Date: Fri, 16 Aug 2013 13:44:56 +0100
Subject: [RFC PATCH 3/4] powerpc: refactor of_get_cpu_node to support
 other architectures
In-Reply-To: <1376656351.25016.2.camel@pasglop>
References: <1374492747-13879-1-git-send-email-Sudeep.KarkadaNagesha@arm.com>
 <1376586580-5409-1-git-send-email-Sudeep.KarkadaNagesha@arm.com>
 <1376586580-5409-4-git-send-email-Sudeep.KarkadaNagesha@arm.com>
 <1376628563.4255.137.camel@pasglop> <520DE753.8090601@arm.com>
 <1376656351.25016.2.camel@pasglop>
Message-ID: <520E1EC8.1010001@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 16/08/13 13:32, Benjamin Herrenschmidt wrote:
> On Fri, 2013-08-16 at 09:48 +0100, Sudeep KarkadaNagesha wrote:
> 
>>> Naming is a bit gross. You might want to make it clearer that
>>> we are talking about CPU IDs in the device-tree here.
>>>
>> Any particular preference to the name or just a note is sufficient.
>> Also unlike PPC, in ARM we don't set hard processor id value based
>> values read from device tree. DT must contain the values matching to the
>> hardware ID registers.
> 
> This is exactly the same on ppc. We don't "set" HW values. The
> device-tree content matches the HW internals. Some processors have a
> "PIR" register as well which contains the HW value, in this case the
> device-tree must contain the same value as the PIR on that processor.
> 
Ok, I misread the function 'set_hard_smp_processor_id' function.
BTW, you didn't mention if you are OK by just have this clearly
documented in the function and/or you have any preference/better name.

I will send the next version based on that. I have even compile tested
:) now on PPC.

Regards,
Sudeep
