From: sricharan@codeaurora.org (sricharan at codeaurora.org)
Date: Wed, 21 Mar 2018 14:40:43 +0530
Subject: [PATCH v3 04/13] ARM: dts: ipq4019: Update ipq4019-dk01.1 board
 data
In-Reply-To: <20180320143131.4eenixtbhciq5fwc@localhost>
References: <1521518336-5467-1-git-send-email-sricharan@codeaurora.org>
 <1521518336-5467-5-git-send-email-sricharan@codeaurora.org>
 <20180320143131.4eenixtbhciq5fwc@localhost>
Message-ID: <78806c70c85e3cecaadfc94b173cb139@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2018-03-20 20:01, Richard Cochran wrote:
> On Tue, Mar 20, 2018 at 09:28:47AM +0530, Sricharan R wrote:
>> Reviewed-by: Abhishek Sahu <absahu@codeaurora.org>
>> Adds missing memory, reserved-memory nodes.
>> 
>> Signed-off-by: Sricharan R <sricharan@codeaurora.org>
>> ---
>>  arch/arm/boot/dts/qcom-ipq4019-ap.dk01.1.dtsi | 28 
>> +++++++++++++++++++++++++++
> 
> Q: Does mainline Linux even boot on the DK?
> 
> A: No, it doesn't.

  Yes, i saw that it was booting out of mainline.
  Both DK01 and DK04 boards boots out of mainline.

cat /proc/version
Linux version 4.16.0-rc6 (srichara at srichara-linux) (gcc version 6.3.1 
20170109 (Linaro GCC 6.3-2017.02)) #1677 SMP PREEMPT Wed Mar 21 12:58:14 
IST 2018

  If it does not boot for you, then can you check if your bootloader is 
passing this bootarg ?

     bootargs=console=ttyMSM0,115200n8

   This is the only one required from bootloader to boot.
   That said, there should have been a default 'chosen' node in DTS
   for the serial console atleast which is not there today. I will add 
this
   in my v4 along with other changes.

Regards,
  Sricharan

> 
> Please add the missing basic board support before hacking random stuff
> into the DTS.
> 
