From: thierry.reding@avionic-design.de (Thierry Reding)
Date: Sun, 23 Sep 2012 19:22:32 +0200
Subject: PXA PWM possible regression after 3.5: backlight remains off
 after resume
In-Reply-To: <505F28B8.1030701@yahoo.com>
References: <505F28B8.1030701@yahoo.com>
Message-ID: <20120923172232.GA1293@avionic-0098.mockup.avionic-design.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Sep 23, 2012 at 04:20:24PM +0100, Paul Parsons wrote:
> There is a possible PXA PWM regression between 3.5 and 3.6-rc6: if I
> suspend and then resume an iPAQ hx4700, the backlight remains off.
> 
> In 3.5 the backlight would turn on after the resume.
> 
> I presumed this is a PWM issue because the PXA PWM driver was reworked
> and moved trees between 3.5 and 3.6-rc6. And there was mention of
> broken PWM drivers about a month ago, for example:
> http://lists.infradead.org/pipermail/linux-arm-kernel/2012-August/115717.html
> 
> Does my backlight breakage sound familiar to anybody? Is there
> anything obvious I can try before debugging it further?

Looking at the code from before the move to the PWM subsystem I have a
hard time understanding how this could have worked for supend/resume in
the first place. The driver has never supported the supend and resume
callbacks. Maybe it is also a problem related to some other change.
Clocking would be a likely candidate. But again I wonder how this ever
worked properly without the suspend and resume callbacks.

Can you pinpoint more exactly when this failed to break. PXA PWM was
already included in 3.6-rc1 so if it is related then it should have
happened at that time already.

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 836 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120923/21e1ae3c/attachment.sig>
