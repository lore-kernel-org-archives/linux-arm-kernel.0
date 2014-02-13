From: swarren@wwwdotorg.org (Stephen Warren)
Date: Thu, 13 Feb 2014 09:37:05 -0700
Subject: [PATCH v2 4/6] ARM: firmware: add prepare_idle() operation
In-Reply-To: <52FCA5FC.80504@samsung.com>
References: <1391747706-1847-1-git-send-email-acourbot@nvidia.com>
 <1391747706-1847-5-git-send-email-acourbot@nvidia.com>
 <52FCA5FC.80504@samsung.com>
Message-ID: <52FCF4B1.5030208@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 02/13/2014 04:01 AM, Tomasz Figa wrote:
> Hi Alexandre,
> 
> On 07.02.2014 05:35, Alexandre Courbot wrote:
>> Some firmwares do not put the CPU into idle mode themselves, but still
>> need to be informed that the CPU is about to enter idle mode before this
>> happens. Add a prepare_idle() operation to the firmware_ops structure to
>> handle such cases.
>>
>> Signed-off-by: Alexandre Courbot <acourbot@nvidia.com>
>> ---
>>   arch/arm/include/asm/firmware.h | 4 ++++
>>   1 file changed, 4 insertions(+)
> 
> I wonder if .do_idle() couldn't simply return an appropriate error code
> to let the upper layer know that it should proceed with normal CPU idle
> activation, while still letting the firmware know that the CPU is going
> to idle.

That seems to disagree with the naming of the operation, and the
semantics I assume it has, though. It seems clearer to add an explicit
separate op for this.
