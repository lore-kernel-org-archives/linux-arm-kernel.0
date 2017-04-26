From: pavel@ucw.cz (Pavel Machek)
Date: Wed, 26 Apr 2017 12:53:56 +0200
Subject: support autofocus / autogain in libv4l2
In-Reply-To: <1493139207.19105.16.camel@ndufresne.ca>
References: <1487074823-28274-2-git-send-email-sakari.ailus@linux.intel.com>
 <20170414232332.63850d7b@vento.lan>
 <20170416091209.GB7456@valkosipuli.retiisi.org.uk>
 <20170419105118.72b8e284@vento.lan> <20170424093059.GA20427@amd>
 <20170424103802.00d3b554@vento.lan> <20170424212914.GA20780@amd>
 <20170424224724.5bb52382@vento.lan> <20170425080538.GA30380@amd>
 <1493139207.19105.16.camel@ndufresne.ca>
Message-ID: <20170426105356.GB857@amd>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue 2017-04-25 12:53:27, Nicolas Dufresne wrote:
> Le mardi 25 avril 2017 ? 10:05 +0200, Pavel Machek a ?crit?:
> > Well, fd's are hard, because application can do fork() and now
> > interesting stuff happens. Threads are tricky, because now you have
> > locking etc.
> > 
> > libv4l2 is designed to be LD_PRELOADED. That is not really feasible
> > with "complex" library.
> 
> That is incorrect. The library propose an API where you simply replace
> certain low level calls, like ioctl -> v4l2_ioctl, open -> v4l2_open().
> You have to do that explicitly in your existing code. It does not
> abstract the API itself unlike libdrm.

You are right, no LD_PRELOAD. But same API as kernel, which is really
limiting -- see my other mail.

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170426/022f73cb/attachment.sig>
