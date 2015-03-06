From: guohanjun@huawei.com (Hanjun Guo)
Date: Fri, 6 Mar 2015 14:48:16 +0800
Subject: [PATCH v9 02/21] ACPI / processor: Introduce phys_cpuid_t for
 CPU hardware ID
In-Reply-To: <CAJZ5v0hu=TB4S00krNk1RpsXeHJVud2ehhcM0dZDhHAk6DamKg@mail.gmail.com>
References: <1424853601-6675-1-git-send-email-hanjun.guo@linaro.org>	<1424853601-6675-3-git-send-email-hanjun.guo@linaro.org>	<1484357.vjmmcyQq4z@vostro.rjw.lan>	<54F8095C.4030308@huawei.com>
 <CAJZ5v0hu=TB4S00krNk1RpsXeHJVud2ehhcM0dZDhHAk6DamKg@mail.gmail.com>
Message-ID: <54F94DB0.1000305@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2015/3/5 21:23, Rafael J. Wysocki wrote:
> On Thu, Mar 5, 2015 at 8:44 AM, Hanjun Guo <guohanjun@huawei.com> wrote:
>> On 2015/3/5 6:29, Rafael J. Wysocki wrote:
>>> On Wednesday, February 25, 2015 04:39:42 PM Hanjun Guo wrote:
> [cut]
>
>>>> @@ -190,7 +190,7 @@ int acpi_map_cpuid(int phys_id, u32 acpi_id)
>>>>              if (nr_cpu_ids <= 1 && acpi_id == 0)
>>>>                      return acpi_id;
>>>>              else
>>>> -                    return phys_id;
>>>> +                    return -1;
>>> Can we use a proper error code here?
>> I'm afraid not. In ACPI processor drivers, -1 will be deemed to
>> invalid cpu logical number, if we return error code here, we need
>> to modify multi places of "if (cpu_logical_num == -1)" to
> Oh, silly stuff.
>
>> "if (! (cpu_logical_num < 0))" too, so for me, I prefer to keep it as
>> -1, but I'm open for suggestions.
> OK
>
> I think we need something like invalid_logical_cpuid() and use it
> in all of those checks instead of the direct comparisons, but we
> can make those changes later.

OK, I recorded this as one of my TODO list, thanks for the suggestions.

Thanks
Hanjun
