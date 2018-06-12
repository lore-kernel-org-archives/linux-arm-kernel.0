From: pavel@ucw.cz (Pavel Machek)
Date: Tue, 12 Jun 2018 14:18:03 +0200
Subject: handling voice calls in ALSA soc (on Droid 4)
In-Reply-To: <20180611121548.GB11580@sirena.org.uk>
References: <20180611102529.GA1272@amd> <20180611111011.GA11580@sirena.org.uk>
 <20180611120158.GA21745@amd> <20180611121548.GB11580@sirena.org.uk>
Message-ID: <20180612121803.GA9707@amd>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi!

Sebastian, would you have pointer to original Motorola sources you
used for inspiration?

> > With setup like that, how does userland tell kernel that the baseband
> > <-> microphone/speaker connection should be activated?
> 
> Audio routing should be done as normal, and ideally the driver for the
> modem will be able to figure out if there's an active call or not.  If
> userspace has to enable the input and output manually then you can set
> up SOC_DAPM_PIN_SWITCH()es as normal.

Modem talks AT commands, so the driver is in userspace for now.

I tried SOC_DAPM_PIN_SWITCH(), but it results in alsamixer oopsing, I
guess I'm doing something wrong.

Message from syslogd at devuan at Jun 12 13:51:31 ...
 kernel:[  743.678588] BUG: spinlock bad magic on CPU#1,
 alsamixer/2217

Message from syslogd at devuan at Jun 12 13:51:31 ...
 kernel:[  743.684417]  lock: 0xede423a0, .magic: eee2a6a4, .owner:
 <none>/-1, .owner_cpu: -287136604
 
I'm trying to understand how it is supposed to work, but
https://www.alsa-project.org/main/index.php/DAPM has TODO's at
critical places. If there's better source of information, let me know.

Best regards,
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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180612/2a174be2/attachment.sig>
