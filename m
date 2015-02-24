From: wsa@the-dreams.de (Wolfram Sang)
Date: Tue, 24 Feb 2015 15:16:44 +0100
Subject: [RFC 02/11] i2c: add quirk checks to core
In-Reply-To: <CABuKBe++yut6ZfhPrsWXGA4fZRvum6WOuRxHucM0gBJCGuou5A@mail.gmail.com>
References: <1420824103-24169-1-git-send-email-wsa@the-dreams.de>
 <1420824103-24169-3-git-send-email-wsa@the-dreams.de>
 <CABuKBe++yut6ZfhPrsWXGA4fZRvum6WOuRxHucM0gBJCGuou5A@mail.gmail.com>
Message-ID: <20150224141644.GA18301@katana>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


> > +               if (msgs[i].flags & I2C_M_RD) {
> > +                       if (i2c_quirk_exceeded(len, max_read))
> > +                               return i2c_quirk_error(adap, &msgs[i], "msg too long");
> > +               } else {
> > +                       if (i2c_quirk_exceeded(len, max_write))
> > +                               return i2c_quirk_error(adap, &msgs[i], "msg too long");
> > +               }
> 
> What about being more verbose in the error message, specifying if it
> was a read or a write message that failed?

Yes, done now. Thanks!

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150224/e879f4a9/attachment.sig>
