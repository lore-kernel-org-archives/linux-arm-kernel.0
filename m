From: hdegoede@redhat.com (Hans de Goede)
Date: Fri,  5 Aug 2016 09:24:30 +0200
Subject: [PATCH 0/1] input: touchscreen: Remove duplicate ft6236 driver
Message-ID: <1470381871-4086-1-git-send-email-hdegoede@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

<resend with Noralf's email address fixed>

Hi All,

December 19th 2015 I noticed that a new ft6236 driver had been added to
the kernel, and that it was in essence just a re-implementation of the
M09 protocol from the edt-ft5x06 driver, IOW it contains 100% duplicate
code. I asked the submitter and authors of the new ft6236 driver to test
there devices with the edt-ft5x06 driver instead, but I got no reply.

January 26th 2016 I asked the submitter and authors of the new ft6236
driver to test with the edt-ft5x06 driver again, but again got no reply.

Note: this is likely due to my having made an error in Noralf's email
address with those 2 mails (sorry), so it would be good to give Noralf
some time to reply now before applying this.

Given the lack of response from the submitter / authors of the ft6236
driver I believe it is best to just remove it. I've double checked and
the edt-ft5x06 driver is 100% compatible both wrt wire protocol usage,
as wrt to the reset gpio usage (and the gpio name in dt).

Regards,

Hans
