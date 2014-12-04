From: wsa@the-dreams.de (Wolfram Sang)
Date: Thu, 4 Dec 2014 19:40:46 +0100
Subject: [PATCH v2] i2c: rk3x: fix bug that cause measured high_ns
 doesn't meet I2C spec
In-Reply-To: <CAD=FV=X5inPWZakhgDX0dX=1CWXygEi3_AH9FVFWXYT3LZA5bg@mail.gmail.com>
References: <1415261514-4051-1-git-send-email-addy.ke@rock-chips.com>
 <1417574237-4328-1-git-send-email-addy.ke@rock-chips.com>
 <20141203111518.GB1039@katana>
 <CAD=FV=X5inPWZakhgDX0dX=1CWXygEi3_AH9FVFWXYT3LZA5bg@mail.gmail.com>
Message-ID: <20141204184046.GL7944@katana>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


> If you don't read all the below, my belief is that we should simply
> rename the strings in Addy's patch.  We should change "rise-ns" to
> "i2c-scl-rising-time" and "fall-ns" to "i2c-scl-falling-time".
> Wolfram: can you confirm this is OK?  I'm voting to leave the "-ns"
> off the end of both to avoid asymmetry.

New binding should have the "-ns" suffix, right? So, I'd vote to add the
suffix to the new bindings and deprecate the ones used in the designware
driver: "i2c-scl-rising-time-ns" and "i2c-scl-falling-time-ns"

It might be a little more work now, but it will help us in the future,
because it is the correct way to do it.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20141204/f3578831/attachment.sig>
