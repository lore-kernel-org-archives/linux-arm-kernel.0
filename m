From: willy@infradead.org (Matthew Wilcox)
Date: Tue, 23 Oct 2018 05:59:28 -0700
Subject: [PATCH v2] mm: Introduce new function vm_insert_kmem_page
In-Reply-To: <CAFqt6zZp=UsSGH148=tPWLnSxC51EGdR0Vv4f5tP58MO-6OS_w@mail.gmail.com>
References: <CANiq72kVJn7985EET067Dgj+z0dwb0x2MTUnREMWKCVU6=WnJA@mail.gmail.com>
 <CAFqt6zZ4sPjtb5BaDfwc5tZv+vMj6ao3NJZ_3quX9AH5pCMwJg@mail.gmail.com>
 <CANiq72m9u1PL9X+dPNLxgkhvttj=4ijLyM2sFex=Kws7wswKzw@mail.gmail.com>
 <CAFqt6zYH4Aczu8AYke8AfGuMS70SJXCMn-n8X8C_Tz03gTjn8g@mail.gmail.com>
 <CANiq72kRAZE9SyM4EkpaBZH03Ex0Z=4Pk2iOuc2jBDKTfKjHQg@mail.gmail.com>
 <CAFqt6zZCCPFE3sQ3u_gjiN8wwd99nwWatk9JRsiGxbCwhi91mg@mail.gmail.com>
 <CANiq72k-e_j67==VdrayqggjAd7MAfpaJS-_0=jkmh4OWynukQ@mail.gmail.com>
 <CAFqt6zZ2yHkVcbYtK1dxr9B3K5WVYGboavjP1ibmYei0u4zFbQ@mail.gmail.com>
 <20181023122435.GB20085@bombadil.infradead.org>
 <CAFqt6zZp=UsSGH148=tPWLnSxC51EGdR0Vv4f5tP58MO-6OS_w@mail.gmail.com>
Message-ID: <20181023125928.GC20085@bombadil.infradead.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 23, 2018 at 06:03:42PM +0530, Souptick Joarder wrote:
> On Tue, Oct 23, 2018 at 5:54 PM Matthew Wilcox <willy@infradead.org> wrote:
> > On Tue, Oct 23, 2018 at 05:44:32PM +0530, Souptick Joarder wrote:
> > > Instruction from Matthew  Wilcox who is supervising the entire vm_fault_t
> > > migration work :-)
> >
> > Hang on.  That was for the initial vm_fault_t conversion in which each
> > step was clearly an improvement.  What you're looking at now is far
> > from that.
> 
> Ok. But my understanding was, the approach of vm_insert_range comes
> into discussion as part of converting vm_insert_page into vmf_insert_page
> which is still part of original vm_fault_t conversion discussion.  No ?

No.  The initial part (converting all page fault methods to vm_fault_t)
is done.  What remains undone (looking at akpm's tree) is changing the
typedef of vm_fault_t from int to unsigned int.  That will prevent new
page fault handlers with the wrong type from being added.

I don't necessarily want to get rid of vm_insert_page().  Maybe it will
make sense to do that, and maybe not.  What I do want to see is thought,
and not "Matthew told me to do it", when I didn't.
