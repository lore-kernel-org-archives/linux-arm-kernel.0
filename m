From: sudeep.holla@arm.com (Sudeep Holla)
Date: Tue, 5 Jun 2018 16:27:55 +0100
Subject: [PATCH v2 3/3] arm64: disable ACPI PPTT support temporarily
In-Reply-To: <CAJZ5v0hn+sya29bZJzksDEDt2QPZDY36Hwn=ckw3ikTGp7T1Zw@mail.gmail.com>
References: <1528209304-3280-1-git-send-email-sudeep.holla@arm.com>
 <1528209304-3280-3-git-send-email-sudeep.holla@arm.com>
 <CAJZ5v0hn+sya29bZJzksDEDt2QPZDY36Hwn=ckw3ikTGp7T1Zw@mail.gmail.com>
Message-ID: <a93212e3-7965-9ae2-34b0-407f04590567@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 05/06/18 16:02, Rafael J. Wysocki wrote:
> On Tue, Jun 5, 2018 at 4:35 PM, Sudeep Holla <sudeep.holla@arm.com> wrote:
>> Currently, ARM64 doesn't support updating the CPU topology masks on
>> CPU hotplug operations. ACPI PPTT support rely on that missing feature
>> which is technically not incorrect. Instead of reverting all the PPTT
>> support, let's keep it simple and disable ACPI PPTT support on ARM64
>> for time-being until the topology updates are added for CPU hotplug
>> operations.
> 
> When is that going to happen?
> > Nobody else uses PPTT now.
> 

No we need it on ARM64. I have even the fixes for the original issue
but it's bit invasive and too late as we are already in the merge
window. It needs to be tested on NUMA platforms, I have asked for that
explicitly.

-- 
Regards,
Sudeep
