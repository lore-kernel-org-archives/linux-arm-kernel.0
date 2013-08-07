From: dgilbert@interlog.com (Douglas Gilbert)
Date: Wed, 07 Aug 2013 12:49:55 -0400
Subject: [PATCH 3.10-stable] at91sam9x5 rtc causes damage
Message-ID: <52027AB3.1040806@interlog.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This one probably needs more sign-offs but some folks seem to be
away. It is pretty simple and fixed in the current lk 3.11.0-rc
series. So it just impacts the lk 3.10 series including lk 3.10.5 .

ChangeLog:
   - without this patch members of the at91sam9x5 family (e.g.
     at91sam9g25) that use the RTC will receive an unhandled
     interrupt whenever they try to write to the RTC. In the
     case of 9x5 SoCs that is the SYS interrupt shared with
     several other things such as the debug port. Thereafter
     the debug port becomes useless (for input), the RTC doesn't
     work ...

Signed-off-by: Douglas Gilbert <dgilbert@interlog.com>
-------------- next part --------------
A non-text attachment was scrubbed...
Name: sam9x5_rtc310a.patch
Type: text/x-patch
Size: 408 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130807/ecd0d8e6/attachment.bin>
