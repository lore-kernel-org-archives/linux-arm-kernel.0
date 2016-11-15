From: pavel@ucw.cz (Pavel Machek)
Date: Tue, 15 Nov 2016 11:31:33 +0100
Subject: LEDs that change brightness "itself" -- that's a trigger. Re: PM
 regression with LED changes in next-20161109
In-Reply-To: <15cafbf5-d842-e184-2fd4-65f8272f505a@redhat.com>
References: <f7c9b2be-0003-f342-a4c7-802532faa424@gmail.com>
 <d7ddbbb0-b99c-14a3-f462-3534b5ec67e6@redhat.com>
 <4c31faef-144d-289c-0e32-83e76aff6178@gmail.com>
 <3eb60c78-d891-27e5-6b7b-a54a5b547a1c@redhat.com>
 <c01cac8b-a921-56d1-7e57-8071d4b9faf6@gmail.com>
 <cb0aa3ce-ee48-66b8-510c-bd70917afec9@redhat.com>
 <b5ae20d7-8394-7ad5-1830-13173e9105c4@gmail.com>
 <9b476f85-d45e-deb6-335d-fc56f6d90350@redhat.com>
 <127cdd42-6fd8-c671-60b7-3826b351577f@samsung.com>
 <15cafbf5-d842-e184-2fd4-65f8272f505a@redhat.com>
Message-ID: <20161115103133.GA22860@amd>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi!

> >Hmm, v4 still calls led_notify_brightness_change(led_cdev)
> >from both __led_set_brightness() and __led_set_brightness_blocking().
> 
> Ugh, I see I accidentally send a v4 twice, instead of
> calling the version which dropped those called v5 as
> I should have, sorry.
> 
> The v4 which I would like to see merged, the one with
> those calls dropped, is here:
> 
> https://patchwork.kernel.org/patch/9423093/

Please, lets fix this properly.

The LED you are talking about _has_ a trigger, implemented in
hardware. That trigger can change LED brightness behind kernel's (and
userspace's) back. Don't pretend the trigger does not exist, it does.

And when you do that, you'll have nice place to report changes to
userspace -- trigger can now export that information, and offer poll()
interface.

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20161115/6fb9cbc8/attachment.sig>
