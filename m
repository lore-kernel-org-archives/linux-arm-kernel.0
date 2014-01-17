From: tomasz.nowicki@linaro.org (Tomasz Nowicki)
Date: Fri, 17 Jan 2014 15:35:43 +0100
Subject: [PATCH 12/20] ARM64 / ACPI: Use Parked Address in GIC structure
 for spin table SMP initialisation
In-Reply-To: <201401171515.21250.arnd@arndb.de>
References: <1389961514-13562-1-git-send-email-hanjun.guo@linaro.org>
 <1389961514-13562-13-git-send-email-hanjun.guo@linaro.org>
 <201401171515.21250.arnd@arndb.de>
Message-ID: <52D93FBF.2010609@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/17/14 15:15, Arnd Bergmann wrote:
> On Friday 17 January 2014, Hanjun Guo wrote:
>> +/* Parked Address in ACPI GIC structure */
>> +static u64 parked_address[NR_CPUS];
>
> Please use the per_cpu infrastructure rather than NR_CPUS long arrays.
Actually, per_cpu areas are initialized a bit later. If we really want 
to use here per_cpu, then we need to implement early_per_cpu 
Frankenstein like x86 does.

Tomasz
