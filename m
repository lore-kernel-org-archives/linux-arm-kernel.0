From: pavel@ucw.cz (Pavel Machek)
Date: Fri, 3 Apr 2015 22:29:53 +0200
Subject: [PATCHv3] media: i2c/adp1653: devicetree support for adp1653
In-Reply-To: <20150403112355.GJ20756@valkosipuli.retiisi.org.uk>
References: <20150402143846.GA11687@amd>
 <20150402161453.GH20756@valkosipuli.retiisi.org.uk>
 <20150402203043.GB29963@amd>
 <20150402234823.GI20756@valkosipuli.retiisi.org.uk>
 <20150403082344.GA14721@amd>
 <20150403112355.GJ20756@valkosipuli.retiisi.org.uk>
Message-ID: <20150403202953.GA5116@amd>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri 2015-04-03 14:23:56, Sakari Ailus wrote:
> Hi Pavel,
> 
> On Fri, Apr 03, 2015 at 10:23:44AM +0200, Pavel Machek wrote:
> > Hi!
> > 
> > > Hi Pawel,
> > 
> > I'm still Pavel. v, not w.
> 
> I know too many Pawels. Sorry about that. :-)
> 

> > I guess it uses adp1653_id_table. I'd hade to add redundand
> > information, because if it would just mask the errors if the code
> > changed...
> 
> Indeed, that's true. This is comparing "adp1653" vs. comparing
> "adi,adp1653". I think I still prefer the latter since it's got also the
> vendor prefix included.
> 
> Suppose we change this later and someone misspelled the vendor prefix ---
> their board would break.

Suppose we do what you suggest. That does not fix the problem, since
code will still match the "adp1653" in case someone misspells it.

If you want to change how i2c device matching works, well, you can do
it, but my patch is not right place to do that.

								Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
