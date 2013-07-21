From: julien.grall@linaro.org (Julien Grall)
Date: Sun, 21 Jul 2013 21:59:22 +0100
Subject: [PATCH v2] xen/arm: enable PV control for ARM
In-Reply-To: <alpine.DEB.2.02.1307211535210.4893@kaball.uk.xensource.com>
References: <1374239399-2498-1-git-send-email-julien.grall@linaro.org>
 <alpine.DEB.2.02.1307211535210.4893@kaball.uk.xensource.com>
Message-ID: <CAPnVf8yG4VecBkk8py_cyOiFkFMqiLYydicKcM2PgYYm+gKd8w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 21 July 2013 15:54, Stefano Stabellini
<stefano.stabellini@eu.citrix.com> wrote:
> On Fri, 19 Jul 2013, Julien Grall wrote:
>> Enable power management from the toolstack for ARM guest.
>>
>> Signed-off-by: Julien Grall <julien.grall@linaro.org>
>>
>> ---
>>     Changes in v2:
>>         - Don't compile xen/cpu_hotplug.o with ARM64
>> ---
>>  drivers/xen/Makefile |    5 ++---
>>  1 file changed, 2 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/xen/Makefile b/drivers/xen/Makefile
>> index 2bf461a..b550a94 100644
>> --- a/drivers/xen/Makefile
>> +++ b/drivers/xen/Makefile
>> @@ -1,9 +1,8 @@
>> -ifneq ($(CONFIG_ARM),y)
>> -obj-y        += manage.o
>> +ifneq ($(filter y, ($CONFIG_ARM) $(CONFIG_ARM64)),y
>
> This is wrong: ifneq is checking for the opposite condition of what we want, and
> beside you have the $ in the wrong place for CONFIG_ARM.
>
> Please test you patches before sending them.

My apologies, I tried without any issue on ARM (certainly, because of
the $ in wrong place).

I will send a new patch.

--
Julien Grall
