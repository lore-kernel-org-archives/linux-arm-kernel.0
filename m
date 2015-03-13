From: galak@codeaurora.org (Kumar Gala)
Date: Fri, 13 Mar 2015 11:43:28 -0500
Subject: [PATCH v4 2/4] arm64: dts: Add Qualcomm MSM8916 SoC and
 evaluation board dts
In-Reply-To: <20150313162516.GA9603@leverpostej>
References: <1426182985-10425-1-git-send-email-galak@codeaurora.org>
 <20150313105207.GB3592@leverpostej>
 <04AD8E46-277D-4652-88AF-D16538C2AA87@codeaurora.org>
 <20150313162516.GA9603@leverpostej>
Message-ID: <91E83B79-5004-48C5-948B-7A9FD7F13BFE@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


On Mar 13, 2015, at 11:25 AM, Mark Rutland <mark.rutland@arm.com> wrote:

> On Fri, Mar 13, 2015 at 03:50:42PM +0000, Kumar Gala wrote:
>> 
>> On Mar 13, 2015, at 5:52 AM, Mark Rutland <mark.rutland@arm.com> wrote:
>> 
>>>> +/ {
>>>> +	chosen {
>>>> +		stdout-path = &blsp1_uart2;
>>>> +	};
>>> 
>>> It would be good if we had the configuration too (see
>>> Documentation/devicetree/bindings/chosen.txt), as that avoids any
>>> reliance on kernel defaults.
>>> 
>>> You can refer to an alias, so this could be:
>>> 
>>> aliases {
>>> 	serial0 = &blsp1_uart2;
>>> };
>>> 
>>> chosen {
>>> 	stdout-path = "serial0:115200n8";
>>> };
>>> 
>>> ...assuming that 115200n8 is correct for your UART, of course.
>>> 
>>> 
>>> [?]
>> 
>> Where is the code that actually handles this parsing?  I?m not see it
>> in early_init_dt_scan_chosen_serial and I don?t believe
>> fdt_path_offset does anything special with ?:'
> 
> Take a look at commit 7914a7c5651a5161 ("of: support passing console options with
> stdout-path").
> 
> Early on of_alias_scan will find the options and in of_console_check
> we'll call add_preferred_console as appropriate. That'll be called in
> uart_add_one_port.

Ok, but earlycon dt code doesn?t utilize this, as its setup is before we unflatten the dt.

So it breaks earlycon parsing right now, I?ll look at fixing that.

- k

-- 
Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
