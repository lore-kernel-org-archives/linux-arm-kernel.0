From: balbi@ti.com (Felipe Balbi)
Date: Thu, 12 Nov 2015 12:09:24 -0600
Subject: [PATCH] gpio: omap: fix debounce time calculation
In-Reply-To: <5644D4F5.8070006@ti.com>
References: <1447350640-20347-1-git-send-email-balbi@ti.com>
 <5644D4F5.8070006@ti.com>
Message-ID: <87egfvqecr.fsf@saruman.tx.rr.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Hi,

Grygorii Strashko <grygorii.strashko@ti.com> writes:
> On 11/12/2015 07:50 PM, Felipe Balbi wrote:
>> According to TRM, debounce is measured in periods of
>> the functional clock of the GPIO IP. This means that
>
>
> What TRM? link pls.
>
> http://www.ti.com/lit/ug/spruhl7d/spruhl7d.pdf
>
> 28.4.1.24 GPIO_DEBOUNCINGTIME Register (offset = 154h) [reset = 0h]
>
> The GPIO_DEBOUNCINGTIME register controls debouncing time (the value is
> global for all ports). The debouncing cell is running with the
> debouncing clock (32 kHz), this register represents the number of the
> clock cycle(s) (31 s long) to be used.
>
> Debouncing Value in 31 microsecond steps.
> Debouncing Value = (DEBOUNCETIME + 1) * 31 microseconds.

DRA7xx:

"
8-bit values specifying the debouncing time. It is n-
periods of the muxed clock, which can come from either
a true 32k oscillator/pad of from the system clock. It
depends on which boot mode is selected. For more
information see Chapter 32, Initialization.
"

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 818 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20151112/d86a43f3/attachment.sig>
