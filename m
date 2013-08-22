From: Sudeep.KarkadaNagesha@arm.com (Sudeep KarkadaNagesha)
Date: Thu, 22 Aug 2013 14:29:41 +0100
Subject: [PATCH v4 03/19] powerpc: refactor of_get_cpu_node to support
 other architectures
In-Reply-To: <1377152143.25016.289.camel@pasglop>
References: <1374492747-13879-1-git-send-email-Sudeep.KarkadaNagesha@arm.com>
 <1376991021-12160-1-git-send-email-Sudeep.KarkadaNagesha@arm.com>
 <1376991021-12160-4-git-send-email-Sudeep.KarkadaNagesha@arm.com>
 <1377152143.25016.289.camel@pasglop>
Message-ID: <52161245.3080404@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 22/08/13 07:15, Benjamin Herrenschmidt wrote:
> On Tue, 2013-08-20 at 10:30 +0100, Sudeep KarkadaNagesha wrote:
>> From: Sudeep KarkadaNagesha <sudeep.karkadanagesha@arm.com>
>>
>> Currently different drivers requiring to access cpu device node are
>> parsing the device tree themselves. Since the ordering in the DT need
>> not match the logical cpu ordering, the parsing logic needs to consider
>> that. However, this has resulted in lots of code duplication and in some
>> cases even incorrect logic.
>>
>> It's better to consolidate them by adding support for getting cpu
>> device node for a given logical cpu index in DT core library. However
>> logical to physical index mapping can be architecture specific.
>>
>> PowerPC has it's own implementation to get the cpu node for a given
>> logical index.
>>
>> This patch refactors the current implementation of of_get_cpu_node.
>> This in preparation to move the implementation to DT core library.
>> It separates out the logical to physical mapping so that a default
>> matching of the physical id to the logical cpu index can be added
>> when moved to common code. Architecture specific code can override it.
> 
> So the patch unfortunately collides with other changes in powerpc -next,
> though it's not a huge deal and not hard to fixup, but expect Linus
> to tick unless we sort it out some other way.
> 
> Appart from that, it's fine, builds on all my test configs and doesn't
> seem to negatively impact things as far as I can tell so far...
> 
> Acked-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> 

Hi Ben,

Thanks a lot for testing and ACK.
I will check with Rafael about these (trivial) conflicts.

Regards,
Sudeep
