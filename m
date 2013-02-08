From: sylvester.nawrocki@gmail.com (Sylwester Nawrocki)
Date: Fri, 08 Feb 2013 23:29:10 +0100
Subject: [PATCH v4 01/10] s5p-csis: Add device tree support
In-Reply-To: <5112E907.4080100@wwwdotorg.org>
References: <1359745771-23684-1-git-send-email-s.nawrocki@samsung.com>
 <1359745771-23684-2-git-send-email-s.nawrocki@samsung.com>
 <5112E907.4080100@wwwdotorg.org>
Message-ID: <51157C36.6030505@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 02/07/2013 12:36 AM, Stephen Warren wrote:
> On 02/01/2013 12:09 PM, Sylwester Nawrocki wrote:
>> s5p-csis is platform device driver for MIPI-CSI frontend to the FIMC
>> device. This patch support for binding the driver to the MIPI-CSIS
>> devices instantiated from device tree and for parsing all SoC and
>> board specific properties.
>
>> diff --git a/Documentation/devicetree/bindings/media/soc/samsung-mipi-csis.txt
>b/Documentation/devicetree/bindings/media/soc/samsung-mipi-csis.txt
>
>> +Optional properties:
>> +
>> +- clock-frequency : The IP's main (system bus) clock frequency in Hz, default
>> +		    value when this property is not specified is 166 MHz;
>
> Shouldn't this be a "clocks" property, so that the driver can call
> clk_get(), clk_prepare_enable(), clk_get_rate(), etc. on it?

Hi Stephen,

Thanks for your review!

I also use "clocks" and "clock-names" property, but didn't specify
it here, because the Exynos SoCs clocks driver is not in the mainline yet.

There are two clocks the driver needs to be aware of. One of them needs
to have a specific parent clock set and the frequency set properly,
so when it is put into a data pipeline with other IPs there is no overflows
of their input/output FIFOs.

devfreq may change those frequencies if enabled, however its another topic.
I wanted to ensure the device has initially correct local clock frequency
set, with which it can operate.

--

Thanks,
Sylwester
