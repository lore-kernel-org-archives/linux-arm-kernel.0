From: georgi.djakov@linaro.org (Georgi Djakov)
Date: Tue, 14 Mar 2017 17:35:57 +0200
Subject: [RFC v0 1/2] interconnect: Add generic interconnect controller API
In-Reply-To: <15929d7a-65e5-f8ba-2fac-0381c5f8e8fc@infradead.org>
References: <20170301182235.19154-1-georgi.djakov@linaro.org>
 <20170301182235.19154-2-georgi.djakov@linaro.org>
 <15929d7a-65e5-f8ba-2fac-0381c5f8e8fc@infradead.org>
Message-ID: <20fa9f6c-22b8-08d0-8fbd-82cbad9acc87@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/03/2017 12:53 AM, Randy Dunlap wrote:
> On 03/01/17 10:22, Georgi Djakov wrote:
>>
>> diff --git a/drivers/interconnect/Kconfig b/drivers/interconnect/Kconfig
>> new file mode 100644
>> index 000000000000..103524b59905
>> --- /dev/null
>> +++ b/drivers/interconnect/Kconfig
>> @@ -0,0 +1,10 @@
>> +menuconfig INTERCONNECT
>> +	bool "On-Chip Interconnect management support"
>
> Why isn't this symbol tristate instead of bool so that the
> interconnect management support can be built as a loadable module?
>

Thanks for the comment! For simplicity, the core API currently is
only supported as a built-in, but we can definitely try making it
modular. I can do it after we get some initial feedback on if and
how this concept fits in the kernel and set the direction we want
to go.

BR,
Georgi

>
>> +	help
>> +	  Support for management of the on-chip interconnects.
>> +
>> +	  This framework is designed to provide a generic interface for
>> +          managing the interconnects in a SoC.
>> +
>> +	  If unsure, say no.
>> +
>
>
