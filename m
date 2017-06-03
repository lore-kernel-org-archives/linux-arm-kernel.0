From: pavel@ucw.cz (Pavel Machek)
Date: Sat, 3 Jun 2017 21:51:39 +0200
Subject: [PATCH v7 16/34] [media] add Omnivision OV5640 sensor driver
In-Reply-To: <755909bf-d1de-e0f3-1569-0d4b16e26817@gmail.com>
References: <1495672189-29164-1-git-send-email-steve_longerbeam@mentor.com>
 <1495672189-29164-17-git-send-email-steve_longerbeam@mentor.com>
 <20170531195821.GA16962@amd>
 <20170601082659.GJ1019@valkosipuli.retiisi.org.uk>
 <755909bf-d1de-e0f3-1569-0d4b16e26817@gmail.com>
Message-ID: <20170603195139.GA3062@amd>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi!

> >>>+	/* Auto/manual exposure */
> >>>+	ctrls->auto_exp = v4l2_ctrl_new_std_menu(hdl, ops,
> >>>+						 V4L2_CID_EXPOSURE_AUTO,
> >>>+						 V4L2_EXPOSURE_MANUAL, 0,
> >>>+						 V4L2_EXPOSURE_AUTO);
> >>>+	ctrls->exposure = v4l2_ctrl_new_std(hdl, ops,
> >>>+					    V4L2_CID_EXPOSURE_ABSOLUTE,
> >>>+					    0, 65535, 1, 0);
> >>
> >>Is exposure_absolute supposed to be in microseconds...?
> >
> >Yes.
> 
> According to the docs V4L2_CID_EXPOSURE_ABSOLUTE is in 100 usec units.
> 
>  OTOH V4L2_CID_EXPOSURE has no defined unit, so it's a better fit IMO.
> >Way more drivers appear to be using EXPOSURE than EXPOSURE_ABSOLUTE, too.
> 
> Done, switched to V4L2_CID_EXPOSURE. It's true, this control is not
> taking 100 usec units, so unit-less is better.

Thanks. If you know the units, it would be of course better to use
right units...

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170603/64113cea/attachment.sig>
