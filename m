From: hanjun.guo@linaro.org (Hanjun Guo)
Date: Thu, 13 Aug 2015 17:30:36 +0800
Subject: [Linaro-acpi] [PATCH 1/5] ACPI: add in a bad_madt_entry() function
 to eventually replace the macro
In-Reply-To: <CAOZdJXVZomskfpvEjmDUiptW3SndJWvfKyzd9SwJp3dh7h3pig@mail.gmail.com>
References: <1438894770-31163-1-git-send-email-al.stone@linaro.org>	<1438894770-31163-2-git-send-email-al.stone@linaro.org>
 <CAOZdJXVZomskfpvEjmDUiptW3SndJWvfKyzd9SwJp3dh7h3pig@mail.gmail.com>
Message-ID: <55CC63BC.4080902@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/13/2015 06:35 AM, Timur Tabi wrote:
> On Thu, Aug 6, 2015 at 3:59 PM, Al Stone <al.stone@linaro.org> wrote:
>> +       while (ms->num_types != 0) {
>> +               if (ms->major_version == major &&
>> +                   ms->minor_version == minor &&
>> +                   ms->madt_version == madt->header.revision)
>> +                       break;
>> +               ms++;
>> +       }
>> +       if (!ms) {
>
> Shouldn't this be
>
>    if (!ms->num_types) {
>
> instead?

I think so, but seems nothing to do with the FADT version,
Al may explain more about it :)

Thanks
Hanjun
