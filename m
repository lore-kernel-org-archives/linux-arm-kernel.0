From: wsa@the-dreams.de (Wolfram Sang)
Date: Tue, 3 Apr 2018 20:12:16 +0200
Subject: [PATCH v6 0/3] add support for Socionext SynQuacer I2C controller
In-Reply-To: <CAKv+Gu9cqQqq_etTSvdBp4Jjk5O_0FePe74phDqt5EO6Cm-_vQ@mail.gmail.com>
References: <20180325110747.8852-1-ard.biesheuvel@linaro.org>
 <20180403150139.l7oec4doafmsidfp@ninjato>
 <CAKv+Gu9cqQqq_etTSvdBp4Jjk5O_0FePe74phDqt5EO6Cm-_vQ@mail.gmail.com>
Message-ID: <20180403181216.f22vtkqrnxjgreuo@ninjato>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


> Yeah, good point. So when exactly should this be called? Only on error
> conditions that could be caused by a misbehaving slave?

Chapter 3.1.16 of the I2C specification, only when a slave keeps SDA
low. Usually you detect that before you start transmitting.

Really, please remove it for now and add it later, properly tested!

BTW what kind of tests did you do with this driver so far?

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180403/cdaf1a4b/attachment.sig>
