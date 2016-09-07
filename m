From: balbi@kernel.org (Felipe Balbi)
Date: Wed, 07 Sep 2016 13:29:54 +0300
Subject: [RFT PATCH v4 0/3] usb: dwc2: Fix core reset and force mode delays
In-Reply-To: <110609329.215940.91637ce0-69a6-4591-a597-b694e410dfca.open-xchange@email.1und1.de>
References: <cover.1472763969.git.johnyoun@synopsys.com>
 <110609329.215940.91637ce0-69a6-4591-a597-b694e410dfca.open-xchange@email.1und1.de>
Message-ID: <87d1kgknod.fsf@linux.intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Hi,

Stefan Wahren <stefan.wahren@i2se.com> writes:
> Hi John,
>
>> John Youn <johnyoun@synopsys.com> hat am 1. September 2016 um 23:07
>> geschrieben:
>> 
>> 
>> This series accounts for the delay from the IDDIG debounce filter when
>> switching modes. This delay is a function of the PHY clock speed and
>> can range from 5-50 ms. This delay must be taken into account on core
>> reset and force modes. A full explanation is provided in the patch
>> commit log and code comments.
>> 
>> This revision of the series increases the IDDIG delay to 100 ms. Some
>> rockchip platforms seem to timeout even with 50 ms so I have doubled
>> this.
>> 
>> Appreciate any testing on RK3188 and RPi platforms.
>
> i tested the whole series successful with a Raspberry Pi B in dr_mode "host" and
> "otg"
>
> Tested-by: Stefan Wahren <stefan.wahren@i2se.com>

John, when you're happy with the series, please resend without RFT so I
can apply :-)

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 800 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160907/a3bc229d/attachment.sig>
