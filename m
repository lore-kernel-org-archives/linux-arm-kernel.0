From: pavel@ucw.cz (Pavel Machek)
Date: Wed, 31 May 2017 22:11:07 +0200
Subject: [PATCH v7 00/34] i.MX Media Driver
In-Reply-To: <08dcd6f6-e0ef-a6a0-cfc3-4fcd55624169@gmail.com>
References: <1495672189-29164-1-git-send-email-steve_longerbeam@mentor.com>
 <dd82968a-4c0b-12a4-f43b-7e63a255812d@xs4all.nl>
 <20170529153637.GH29527@valkosipuli.retiisi.org.uk>
 <08dcd6f6-e0ef-a6a0-cfc3-4fcd55624169@gmail.com>
Message-ID: <20170531201107.GB16962@amd>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi!

> >If there's a need for this (there should not be, as the controls are exposed
> >to the user space through the sub-device nodes as the other drivers do), the
> >framework APIs need to be extended.
> 
> Right, this gets back to the media framework usability arguments. At least
> myself, Philipp, and Russell feel that automatic inheritance of a configured
> pipeline's controls to a video device adds to the usability.

For the record, usability can be pretty much fixed in v4l-utils... I
have patches that try ioctls on a list of fd's. Now we need a way to
find out which /dev/video* files belong to single camera. I believe
kernel already has required APIs, we just need to apply v4l-utils
patch to use them...

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170531/70aa8570/attachment.sig>
