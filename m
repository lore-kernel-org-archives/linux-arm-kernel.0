From: pavel@ucw.cz (Pavel Machek)
Date: Sat, 28 Jul 2018 21:36:32 +0200
Subject: [PATCH, libv4l]: Make libv4l2 usable on devices with complex
 pipeline
In-Reply-To: <20180723153649.73337c0f@coco.lan>
References: <20180708213258.GA18217@amd> <20180719205344.GA12098@amd>
 <20180723153649.73337c0f@coco.lan>
Message-ID: <20180728193632.GB29593@amd>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi!

> > > Add support for opening multiple devices in v4l2_open(), and for
> > > mapping controls between devices.
> > > 
> > > This is necessary for complex devices, such as Nokia N900.
> > > 
> > > Signed-off-by: Pavel Machek <pavel@ucw.cz>  
> > 
> > Ping?
> > 
> > There's a lot of work to do on libv4l2... timely patch handling would
> > be nice.
> 
> As we're be start working at the new library in order to support
> complex cameras, and I don't want to prevent you keeping doing your
> work, IMHO the best way to keep doing it would be to create two
> libv4l2 forks:
> 
> 	- one to be used by you - meant to support N900 camera;
> 	- another one to be used by Google/Intel people that will
> 	  be working at the Complex camera.

Actually, I guess it would be better to share branches. N900 really
has Complex camera :-). Yes, there are some details that are different
(IPU3 will need to pass data between sensor and processing pipeline),
but it

1) will probably need to "propagate controls"
2) will need autofocus
3) would benefit from same autogain improvements
4) [probably most difficult] figure out how to support more than
8-bits depth.

> So, please send me, in priv, a .ssh key for me to add you an
> account at linuxtv.org. I'll send you instructions about how to
> use the new account.

Done, you should have key in your inbox.

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180728/d2bbd727/attachment.sig>
