From: fkan@apm.com (Feng Kan)
Date: Thu, 9 Jan 2014 14:48:52 -0800
Subject: [PATCH V2 5/6] power: reset: change xgene reboot driver to use
 both acpi and dts resource for reboot.
In-Reply-To: <201401082243.01694.arnd@arndb.de>
References: <1389135041-16062-1-git-send-email-fkan@apm.com>
 <1389135041-16062-6-git-send-email-fkan@apm.com>
 <201401082243.01694.arnd@arndb.de>
Message-ID: <CAL85gmB4erJ8C=YYysXuLaY9Tkr79Z=7pAgrv0JuSU+bkxwaxg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 8, 2014 at 1:43 PM, Arnd Bergmann <arnd@arndb.de> wrote:
> On Tuesday 07 January 2014, Feng Kan wrote:
>> Enable the X-Gene reboot driver to use either the ACPI or the DTS
>> resource using the platform driver method.
>>
>> Signed-off-by: Feng Kan <fkan@apm.com>
>> ---
>>  drivers/power/reset/xgene-reboot.c |   33 ++++++++++++++++++++++++++++-----
>>  1 files changed, 28 insertions(+), 5 deletions(-)
>>
>
> Shouldn't an ACPI based system always be able to reboot through the
> UEFI reset_system call? I really don't think we want to support
> ACPI on non-UEFI systems.
>
>         Arnd
Thanks Arnd, I will retract the ACPI support for now. We are still
trying to figure
out how best to support ACPI. The larger problem seems to be the fact that
UEFI and ACPI were originally made for x86 and is ill suited for the
arm64. I will
see if I can find a better path for this patch.
