From: sboyd@codeaurora.org (Stephen Boyd)
Date: Thu, 02 Jan 2014 12:20:21 -0800
Subject: [PATCH v2 3/7] tty: serial: Limit msm_serial_hs driver to
 platforms that use it
In-Reply-To: <201401021910.22651.arnd@arndb.de>
References: <1388438133-431-1-git-send-email-sboyd@codeaurora.org>
 <1388438133-431-4-git-send-email-sboyd@codeaurora.org>
 <201401021910.22651.arnd@arndb.de>
Message-ID: <52C5CA05.5080803@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/02/14 10:10, Arnd Bergmann wrote:
> On Monday 30 December 2013, Stephen Boyd wrote:
>> The msm_serial_hs driver uses mach specific dma APIs. This is not
>> compatible with the multi-platform ARM effort. Let's only compile
>> this driver on MSM devices that are prepared to support it;
>> allowing the DT based MSM devices to enter the multi-platform ARM
>> build.
>>
>> Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>> Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
> Do you have a plan to deal with this in the future? Aren't you going
> to need it in the future on modern SoCs?
>

Yes, we plan to add the code for dma based serial devices into the
msm_serial.c driver. In the process we'll use the linux DMA apis instead
of using mach specific ones.

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
hosted by The Linux Foundation
