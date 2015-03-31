From: guohanjun@huawei.com (Hanjun Guo)
Date: Tue, 31 Mar 2015 09:42:40 +0800
Subject: [Linaro-acpi] [PATCH 1/2] ARM64 / ACPI: Ignore the return error
 value of acpi_map_gic_cpu_interface()
In-Reply-To: <5519C5C8.2020903@linaro.org>
References: <1427458476-20140-1-git-send-email-hanjun.guo@linaro.org>
 <5519C5C8.2020903@linaro.org>
Message-ID: <5519FB90.4010400@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2015/3/31 5:53, Al Stone wrote:
> On 03/27/2015 06:14 AM, Hanjun Guo wrote:
>> MADT table scannig will stopped once it gets the errors
>> returned by the handler, which is acpi_map_gic_cpu_interface()
>> in for ARM64, so Ignore the return error value to search for
>> all enabled CPUs for SMP init.
> I think the comment should say something like:
>
> MADT scanning will stop when it gets an error from the handler,
> acpi_map_gic_cpu_interface(), on arm64.  However, we need to
> find all of the enabled CPUs so that SMP initialization can work
> properly.  So, if an error occurs in this case, ignore it for
> now so that we can find all of the enabled CPUs.
>
> Is that what you meant, Hanjun?

That's exactly what I mean, you describe it much clearer :)

Thanks
Hanjun
