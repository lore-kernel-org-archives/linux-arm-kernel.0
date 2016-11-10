From: pavel@ucw.cz (Pavel Machek)
Date: Thu, 10 Nov 2016 17:36:06 +0100
Subject: PM regression with LED changes in next-20161109
In-Reply-To: <7cc1ba55-1bd0-ae3f-5c9b-f16efb8dcc80@samsung.com>
References: <20161109192301.GS26979@atomide.com>
 <28234714-3994-6747-9cf8-1ff0b3257f7a@gmail.com>
 <CGME20161110084919epcas3p2e8fbdd2905cabe15c5301b7a8e22416c@epcas3p2.samsung.com>
 <f627c778-4378-e5da-09dd-3e0fb2ea4aba@redhat.com>
 <5bd5333e-0dbb-6333-0a48-ca4d3a990f9c@samsung.com>
 <d2941e6f-d277-a68d-2837-00b628dd3be7@redhat.com>
 <7cc1ba55-1bd0-ae3f-5c9b-f16efb8dcc80@samsung.com>
Message-ID: <20161110163606.GD28832@amd>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi!


> >>>The current docs say not about (sw) blinking, but that should be treated
> >>>just
> >>>like a trigger IMHO.
> >>
> >>You'r right, we should describe the semantics on reading, but it would
> >>have to be as follows:
> >>
> >>Reading from this file returns LED brightness at given moment, i.e.
> >>even though LED class device brightness setting is greater than 0, the
> >>momentary brightness can be 0 if the readout occurred during low phase
> >>of blink cycle.
> >
> >Why would it need to read like this, because this is the current behavior ?
> 
> We have led_update_brightness() which was introduced long time ago and
> is used in brightness_show(). Note that if LED controller changed
> actual LED brightness e.g. due to battery voltage dropping below
> certain threshold, we wouldn't be able to find it out otherwise
> (except if we added separate sysfs file for that).

And we should have a separate sysfs file for that. Note that on some
hardware leds, you are able to let hardware control them, but if you
do, you can't really tell the current state. Examples are n900 and
thinkpad-acpi. So it is better we don't pretend we can get that value
for userspace.
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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20161110/1b646938/attachment.sig>
