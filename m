From: timur@codeaurora.org (Timur Tabi)
Date: Mon, 11 Jan 2016 15:38:54 -0600
Subject: [PATCH v4 3/3] serial: amba-pl011: add ACPI support to AMBA probe
In-Reply-To: <20160106110350.GB3599@xora-haswell.xora.org.uk>
References: <1450880383-29560-1-git-send-email-aleksey.makarov@linaro.org>
 <1450880383-29560-4-git-send-email-aleksey.makarov@linaro.org>
 <CAOZdJXUpjWi7Dy=GFi7_58FqD_UZxxrw_QKJ4sdHLKVOLCyNAA@mail.gmail.com>
 <CAGCh1+ksWFLkE8Y_a5SW98tpgGBWdVH5TYJAoS17EExuPd65oQ@mail.gmail.com>
 <568BEDEC.5010101@codeaurora.org>
 <20160106110350.GB3599@xora-haswell.xora.org.uk>
Message-ID: <569420EE.5060006@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Graeme Gregory wrote:
>> >
>> >So with this patch, what is the difference between sbsa_uart_probe and
>> >pl011_probe?  Shouldn't the patch also remove sbsa_uart_probe?
>> >
> One is for amba_device and one is for platform_device and one maintainer
> indicated displeasure at platfrom device being in an AMBA driver.

Ok, I'm still a little confused, but it sounds to me like your patch 
should have also removed sbsa_uart_probe().

With your patches applied, under what circumstance would 
sbsa_uart_probe() still be called?  The amba-pl011.c driver already 
probes on ARMH0011, so shouldn't that be removed, to avoid a double probe?
