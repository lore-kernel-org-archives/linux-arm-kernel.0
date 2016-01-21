From: pali.rohar@gmail.com (Pali =?utf-8?q?Roh=C3=A1r?=)
Date: Thu, 21 Jan 2016 20:34:07 +0100
Subject: 4.5-rc0: n900 battery charging reverts to 100mA,
 indicator turns back on
In-Reply-To: <20160121184234.GA17679@amd>
References: <20160121184234.GA17679@amd>
Message-ID: <201601212034.07727@pali>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 21 January 2016 19:42:34 Pavel Machek wrote:
> Hi!
> 
> In 4.4, n900 battery charging works. If indicator is turned off, it
> stays off, and if I select 1.8A charge, it sticks. (There may be
> problems after system suspend and resume. But normal operation seems
> to be pretty reliable).

Hm... right, bq2415x driver does not have support for suspend/resume. 
Before suspend registers should be stored and after resume restored, 
plus check charger auto detection.

> In 4.5-rc0 (7fdec82af6a9e190e53d07a1463d2a9ac49a8750) battery
> charging works for few hours. But then indicator (yellow light on
> 3color LED) turns back on, and if I ask for 1.8A charge, it goes
> back to .1A, discharging battery.
> 
> Any ideas?

Look into bq24150a sysfs node what changes. Also if there is something 
in dmesg.

> Best regards,
> 									Pavel


-- 
Pali Roh?r
pali.rohar at gmail.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 198 bytes
Desc: This is a digitally signed message part.
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160121/a69c7324/attachment.sig>
