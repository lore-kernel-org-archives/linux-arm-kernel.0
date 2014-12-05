From: Yalin.Wang@sonymobile.com (Wang, Yalin)
Date: Fri, 5 Dec 2014 16:08:42 +0800
Subject: [RFC V2] mm:add zero_page _mapcount when mapped into user space
In-Reply-To: <CALYGNiPWw6=tryWn_kCs+6H1uSjApBDnqORxuNEd=DuGCo71qA@mail.gmail.com>
References: <35FD53F367049845BC99AC72306C23D103E688B313E0@CNBJMBX05.corpusers.net>
 <20141202113014.GA22683@node.dhcp.inet.fi>
 <35FD53F367049845BC99AC72306C23D103E688B313E6@CNBJMBX05.corpusers.net>
 <20141204122813.GA523@node.dhcp.inet.fi>
 <CALYGNiPWw6=tryWn_kCs+6H1uSjApBDnqORxuNEd=DuGCo71qA@mail.gmail.com>
Message-ID: <35FD53F367049845BC99AC72306C23D103E688B313EC@CNBJMBX05.corpusers.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> -----Original Message-----
> From: Konstantin Khlebnikov [mailto:koct9i at gmail.com]
> Sent: Friday, December 05, 2014 2:39 PM
> To: Kirill A. Shutemov
> Cc: Wang, Yalin; linux-kernel at vger.kernel.org; linux-mm at kvack.org; linux-
> arm-kernel at lists.infradead.org
> Subject: Re: [RFC V2] mm:add zero_page _mapcount when mapped into user
> space
> 
> On Thu, Dec 4, 2014 at 3:28 PM, Kirill A. Shutemov <kirill@shutemov.name>
> wrote:
> > On Thu, Dec 04, 2014 at 02:10:53PM +0800, Wang, Yalin wrote:
> >> > -----Original Message-----
> >> > From: Kirill A. Shutemov [mailto:kirill at shutemov.name]
> >> > Sent: Tuesday, December 02, 2014 7:30 PM
> >> > To: Wang, Yalin
> >> > Cc: 'linux-kernel at vger.kernel.org'; 'linux-mm at kvack.org';
> >> > 'linux-arm- kernel at lists.infradead.org'
> >> > Subject: Re: [RFC V2] mm:add zero_page _mapcount when mapped into
> >> > user space
> >> >
> >> > On Tue, Dec 02, 2014 at 05:27:36PM +0800, Wang, Yalin wrote:
> >> > > This patch add/dec zero_page's _mapcount to make sure the
> >> > > mapcount is correct for zero_page, so that when read from
> >> > > /proc/kpagecount, zero_page's mapcount is also correct, userspace
> >> > > process like procrank can calculate PSS correctly.
> 
> Instead of tweaking mapcount you could mark zero-pages in /proc/kpageflags
> and handle them accordingly in userspace. Or mark zero pages with special
> magic _mapcount and detect it in /proc/kpagecount.
> 
I think add KPF_ZERO_PAGE in kpageflags is better.
I will make another patch for review .

Thanks
