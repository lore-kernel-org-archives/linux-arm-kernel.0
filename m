From: tixy@linaro.org (Jon Medhurst (Tixy))
Date: Wed, 16 Oct 2013 17:06:11 +0100
Subject: .align may cause data to be interpreted as instructions
In-Reply-To: <525E74D8.3070008@codethink.co.uk>
References: <525DC3D1.5030300@linaro.org> <525E74D8.3070008@codethink.co.uk>
Message-ID: <1381939571.3419.44.camel@linaro1.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 2013-10-16 at 12:13 +0100, Ben Dooks wrote:
> On 15/10/13 23:38, Taras Kondratiuk wrote:
> > Hi
> >
> > I was debugging kprobes-test for BE8 and noticed that some data fields
> > are stored in LE instead of BE. It happens because these data fields
> > get interpreted as instructions.
> >
> > Is it a known issue?
> 
> I reported the crashes to Tixy along with a different
> method of sovling the problem (changed to using pointers to
> the strings) a while ago.

I found that fix in the list archives:
http://lists.infradead.org/pipermail/linux-arm-kernel/2013-July/186528.html

>  However it seems that nothing has
> happened to fix this.
>
> Since kprobes seems to work with the fixed tests I forgot
> to follow up and prod Jon about looking into this problem.

Sorry, I sorta forgot/ignored the issue, strange compiler problem with a
vague explanation on a big-endian kernel (who uses that ;-)

> Jon, if you are not interested in fixing this, then please
> let me know and we can get a patch sorted to fix it.

Looking at your old patch again, it looks good to me. So if someone
could post this to the lists again, with the commit message updated to
have a clearer explanation as to the symptoms, e.g. some of Taras'
analysis, that would be good. It should go to the list again to give
people another chance to comment...

Thanks

-- 
Tixy
