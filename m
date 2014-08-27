From: pavel@denx.de (Pavel Machek)
Date: Wed, 27 Aug 2014 13:56:31 +0200
Subject: [PATCHv10 0/5] ARM: remove the sub-node and deprecate
 supports-highspeed property for dwmmc.
In-Reply-To: <53FD4C7B.2030008@samsung.com>
References: <1407397082-32495-1-git-send-email-jh80.chung@samsung.com>
 <20140825112151.GA21336@amd> <53FB1DD5.3050207@samsung.com>
 <20140825113719.GA31960@amd> <53FB278B.7010509@samsung.com>
 <53FB2807.7070503@samsung.com> <20140826101923.GA13619@amd>
 <53FD4C7B.2030008@samsung.com>
Message-ID: <20140827115631.GA2536@amd>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed 2014-08-27 12:11:55, Jaehoon Chung wrote:
> Hi,
> 
> On 08/26/2014 07:19 PM, Pavel Machek wrote:
> > Hi!
> > 
> >>>> Would you elaborate?
> >>>>
> >>>> If I have a device like a phone, I may want to put one "slot" inside
> >>>> phone for basic system, and offer second slot for user expansion
> >>>> (initially empty).
> >>>
> >>> if multiple slot is supported, then a mmcqd should be processing for multiple slots.
> >>> It's too inefficient, and affect the whole performance reduction.
> >> Sorry, Discard this comment. it means dwmci, not mmcqd.
> > 
> > Well, that's a Linux problem, and for many applications, not even
> > problem at all.
> > 
> > Device tree should describe hardware, and hardware can do multiple
> > slots per controller, so device tree should describe multiple slots
> > per controller.
> > 
> > Now, the configuration may be uncommon, but you are moving from good
> > hardware description to bad hardware description.
> 
> Well, i don't think it's bad hardware description. And this policy is suggested by other mmc developers and maintainers.
> At first time, I had also suggested same opinion with yours.
> Refer to below..

Well, I disagree with them. They want to modify device tree because of
linux limitations.

Plus. I guess that sooner or later someone will wire just the slot 1
(not 0) and not match this description.
									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
