From: sudeep.holla@arm.com (Sudeep Holla)
Date: Mon, 2 Jul 2018 10:57:47 +0100
Subject: [PATCH] ACPI/PPTT: use ACPI ID whenever
 ACPI_PPTT_ACPI_PROCESSOR_ID_VALID is set
In-Reply-To: <CAJZ5v0gnspK3soa5j8iqU9QDM78MMBbz8YC9s7TOJ5Qwh7=mZg@mail.gmail.com>
References: <1530289077-2444-1-git-send-email-sudeep.holla@arm.com>
 <CAJZ5v0gnspK3soa5j8iqU9QDM78MMBbz8YC9s7TOJ5Qwh7=mZg@mail.gmail.com>
Message-ID: <3895a0d8-9cca-2512-a06e-0ee2ac7db773@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 02/07/18 10:06, Rafael J. Wysocki wrote:
> On Fri, Jun 29, 2018 at 6:17 PM, Sudeep Holla <sudeep.holla@arm.com> wrote:
>> Currently we use the ACPI processor ID only for the leaf/processor nodes
>> as the specification states it must match the value of ACPI processor ID
>> field in the processor?s entry in the MADT.
>>
>> However, if a PPTT structure represents processors group, it match a
>> processor container UID in the namespace and ACPI_PPTT_ACPI_PROCESSOR_ID_VALID
>> flag describe whether the ACPI processor ID is valid.
>>
>> Lets use UID whenever ACPI_PPTT_ACPI_PROCESSOR_ID_VALID is set to be
>> consistent instead of using table offset as it's currently done for non
>> leaf nodes.
>>
>> Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
>> Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
>> ---
>>  drivers/acpi/pptt.c | 10 ++++++++--
>>  1 file changed, 8 insertions(+), 2 deletions(-)
>>
>> Hi,
>>
>> There's ongoing discussion on assigning ID based in OS using simple
>> counters. It can never be consistent with firmware's view. So if the
>> firmware provides valid UID for non-processors node, we must use it.
> 
> OK
> 
> Do you regard this as a fix for the recently merged PPTT material?  If
> so, I should apply it as a fix for 4.18.
> 

Yes, it should be considered as fix IMO.

-- 
Regards,
Sudeep
