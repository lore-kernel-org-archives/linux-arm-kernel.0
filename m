From: tixy@linaro.org (Jon Medhurst (Tixy))
Date: Wed, 16 Oct 2013 18:03:45 +0100
Subject: .align may cause data to be interpreted as instructions
In-Reply-To: <1381939571.3419.44.camel@linaro1.home>
References: <525DC3D1.5030300@linaro.org> <525E74D8.3070008@codethink.co.uk>
 <1381939571.3419.44.camel@linaro1.home>
Message-ID: <1381943025.3419.59.camel@linaro1.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 2013-10-16 at 17:06 +0100, Jon Medhurst (Tixy) wrote:
> On Wed, 2013-10-16 at 12:13 +0100, Ben Dooks wrote:
> > On 15/10/13 23:38, Taras Kondratiuk wrote:
> > > Hi
> > >
> > > I was debugging kprobes-test for BE8 and noticed that some data fields
> > > are stored in LE instead of BE. It happens because these data fields
> > > get interpreted as instructions.
> > >
> > > Is it a known issue?
> > 
> > I reported the crashes to Tixy along with a different
> > method of sovling the problem (changed to using pointers to
> > the strings) a while ago.
> 
> I found that fix in the list archives:
> http://lists.infradead.org/pipermail/linux-arm-kernel/2013-July/186528.html
> 
> >  However it seems that nothing has
> > happened to fix this.
> >
> > Since kprobes seems to work with the fixed tests I forgot
> > to follow up and prod Jon about looking into this problem.
> 
> Sorry, I sorta forgot/ignored the issue, strange compiler problem with a
> vague explanation on a big-endian kernel (who uses that ;-)
> 
> > Jon, if you are not interested in fixing this, then please
> > let me know and we can get a patch sorted to fix it.
> 
> Looking at your old patch again, it looks good to me. 

Actually it's broken for thumb, the pointer to the title needs storing
at a 4 byte alignment, which presumably will make the problem we're
trying to workaround re-occur. I'll try and find some time to take a
look for a different way of doing things...

-- 
Tixy
