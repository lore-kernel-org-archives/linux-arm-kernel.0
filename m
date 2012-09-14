From: afzal@ti.com (Mohammed, Afzal)
Date: Fri, 14 Sep 2012 10:20:02 +0000
Subject: [PATCH v6 10/10] ARM: OMAP2+: tusb6010: generic timing calculation
In-Reply-To: <C8443D0743D26F4388EA172BF4E2A7A93E9E253B@DBDE01.ent.ti.com>
References: <cover.1345524670.git.afzal@ti.com>
 <bc000ac53bb1b3ae1a951bbcf372caf6336d2a19.1345524670.git.afzal@ti.com>
 <20120824194630.GU11011@atomide.com>
 <C8443D0743D26F4388EA172BF4E2A7A93E9BA589@DBDE01.ent.ti.com>
 <C8443D0743D26F4388EA172BF4E2A7A93E9DC11D@DBDE01.ent.ti.com>
 <C8443D0743D26F4388EA172BF4E2A7A93E9DEC85@DBDE01.ent.ti.com>
 <20120906204354.GJ1303@atomide.com>
 <20120911184606.GN23092@atomide.com>,
 <C8443D0743D26F4388EA172BF4E2A7A93E9E253B@DBDE01.ent.ti.com>
Message-ID: <C8443D0743D26F4388EA172BF4E2A7A93E9E3624@DBDE01.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Mohammed, Afzal: Wednesday, September 12, 2012 3:20 PM

> But some of the tusb async values is less by one. I need
> to get it right.

Reason has been identified. It was due to rounding error,
no changes are required in the expressions. Moving
completely to picoseconds resolves the issue.

Can you please try with the attached patch ?

Once it is confirmed that issue is resolved, I will cleanup
gpmc-nand.c too (which would also take care of picoseconds)

Note: As this mail is sent via exchange, I am attaching the
patch so that it reaches you in proper way.

Regards
Afzal
-------------- next part --------------
A non-text attachment was scrubbed...
Name: 0001-gpmc-rounding-error-fix.patch
Type: text/x-patch
Size: 14228 bytes
Desc: 0001-gpmc-rounding-error-fix.patch
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120914/5b0b4601/attachment.bin>
