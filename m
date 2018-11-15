From: bhsharma@redhat.com (Bhupesh Sharma)
Date: Fri, 16 Nov 2018 03:20:50 +0530
Subject: [PATCH] x86_64,
 vmcoreinfo: Append 'page_offset_base' to vmcoreinfo
In-Reply-To: <20181030085917.GC11408@MiWiFi-R3L-srv>
References: <1540593788-28181-1-git-send-email-bhsharma@redhat.com>
 <20181027100241.GB1884@MiWiFi-R3L-srv>
 <CACi5LpPf9Zr1beowRNGmLZY7DtS3JDt8D=FONjqas9yo7TyCjg@mail.gmail.com>
 <20181030020752.GB11408@MiWiFi-R3L-srv>
 <CACi5LpP0_s9zAF+QfKpU+kG6BKqqkiwQhcW-WFZ0=SnBeX7ZXA@mail.gmail.com>
 <20181030085917.GC11408@MiWiFi-R3L-srv>
Message-ID: <CACi5LpPrYgiy--FRgN4549cxLPMrtx6mY9_QRggKNo7gK3WxYw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Baoquan,

On Tue, Oct 30, 2018 at 2:29 PM Baoquan He <bhe@redhat.com> wrote:
>
> Hi Bhupesh,
>
> On 10/30/18 at 12:33pm, Bhupesh Sharma wrote:
> > > Why it's broken? Have you investigated and figured out why it's broken?
> > > If fix, what patch will it look like? Does the patch prove it's not
> > > worth using the current way?
> > >
> > > Have you thought about this in advance? Or still like before, you said
> > > on arm64 you found different boards have different behaviour, then
> > > makedumpfile maintainer Kazu said he investigated and found it may be
> > > caused by KALSR. This time, for this KCORE_REMAP adding, can you help to
> > > investigate further and give an answer to the issue you found and
> > > raised?
> >
> > Ofcourse, the patchset which added vmcoreinfo into kcore was discussed
> > and it was agreed that this was a better approach to move forward and hence
> > accepted in mainline.
>
> Currently I am wondering why x86_64 need add page_offset_base to
> vmcoreinfo. Is it because any feature or userspace tool is broken if
> page_offset_base is not added into vmcoreinfo?
>
> Why KCORE_REMAP adding broke makedumpfile, do you find out the root
> cause and what it looks like if you fix it in the current way?
>
> Can you list the reasons one by one as below with short sentence?
> 1)
> 2)
> 3)
>
> >
> > Regarding the makedumpfile issue, I have already provided a detailed
> > reply to Kazu (you are Cc'ed on the thread) and also proposed a
> > makedumpfile approach which
> > reads the 'page_offset_base' value from kcore (using the kernel
> > interface provided by this patch),
> > [on which you are Cc'ed as well]:
>
> This is your replying mail link:
> https://www.spinics.net/lists/kexec/msg21616.html
>
> Then what on earth do you want to fix in this patch?
>
> So Kazu's patch which decuding page_offset_base like x86 64 have done works.
> Yes, and your way using vmcoreinfo in kcore also works, but this is not
> the reason which supports you to discard the old way Kazu suggested. Now
> we are talking about why you want to discard the old way, and adding
> page_offset_base to vmcoreinfo.
>
> Please elaborate and reply with simple and clear logic.

I have sent a v2 patch with a much simpler git log message. Hopefully
that should clarify the intent behind the patch.
Also lets see what views the x86 maintainers have on the v2 patch.

Regards,
Bhupesh
