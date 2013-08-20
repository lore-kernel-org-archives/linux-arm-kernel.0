From: Sudeep.KarkadaNagesha@arm.com (Sudeep KarkadaNagesha)
Date: Tue, 20 Aug 2013 13:22:30 +0100
Subject: [PATCH v4 03/19] powerpc: refactor of_get_cpu_node to support
 other architectures
In-Reply-To: <3703987.W8AZjrDbn0@vostro.rjw.lan>
References: <1374492747-13879-1-git-send-email-Sudeep.KarkadaNagesha@arm.com>
 <1376991021-12160-1-git-send-email-Sudeep.KarkadaNagesha@arm.com>
 <1376991021-12160-4-git-send-email-Sudeep.KarkadaNagesha@arm.com>
 <3703987.W8AZjrDbn0@vostro.rjw.lan>
Message-ID: <52135F86.9020401@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 20/08/13 13:27, Rafael J. Wysocki wrote:
> On Tuesday, August 20, 2013 10:30:05 AM Sudeep KarkadaNagesha wrote:
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
>>
>> Cc: Rob Herring <rob.herring@calxeda.com>
>> Cc: Grant Likely <grant.likely@linaro.org>
>> Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
>> Signed-off-by: Sudeep KarkadaNagesha <sudeep.karkadanagesha@arm.com>
> 
> This needs an ACK from Ben to go anywhere.
> 
Hi Rafael,

Correct, he has reviewed but I am waiting for his ACK before I could
sent you pull request. Hopefully I should be able to send pull request
tomorrow with his ACK.

Hi Ben,

If this is patch is fine, can I have your ACK ?

Regards,
Sudeep
