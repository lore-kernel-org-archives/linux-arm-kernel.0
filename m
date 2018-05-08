From: pavel@ucw.cz (Pavel Machek)
Date: Tue, 8 May 2018 23:51:02 +0200
Subject: Incoming sms problem on Motorola Droid 4
Message-ID: <20180508215102.GA5253@amd>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi!

I have problems with incoming SMS. ofono tries to use +CNMI=1,2,2,1,0

> AT+CNMI=?
< +CNMI: (0,1,2),(0,1,2,3),(0,2),(0,1,2),(0,1)
< OK
ofonod[3070]: drivers/atmodem/sms.c:build_cnmi_string()
ofonod[3070]: drivers/atmodem/sms.c:construct_ack_pdu()
> AT+CNMI=1,2,2,1,0
< OK
ofonod[3070]: src/network.c:__ofono_netreg_add_status_watch() 0x5bbbf0

... unfortunately, with that configuration no messages are comming to
ofono and the other phone sees them as "delievery failed".

I had some luck with unicsy_demo using AT+CNMI=1,2 with text mode (not
PDU) messages. That works well enough for me.

Unfortunately, if I force ofono to pass "AT+CNMI=1,2", it does not
work well, either.

Any ideas how to debug this / what to try?

Thanks,

								Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 181 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180508/3f90d2c4/attachment.sig>
