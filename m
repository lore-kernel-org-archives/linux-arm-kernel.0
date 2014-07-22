From: will.deacon@arm.com (Will Deacon)
Date: Tue, 22 Jul 2014 09:13:54 +0100
Subject: [PATCH v7 8/9] ARM: vdso initialization, mapping, and
 synchronization
In-Reply-To: <CALCETrXGi3a3G=dH2R6-mu2BwGdEyn3AXrGVRstye6zPO1mFxA@mail.gmail.com>
References: <CALCETrWeTeeuz4vW6wrhtDrdg54O-hhFbspfKEEunRZ0zf7ZBg@mail.gmail.com>
 <20140702144050.GD24879@arm.com>
 <CALCETrUVa-Yt7qZpzkpiAGVf+sYeasNq_YS1MuH6CFfWCcW6BA@mail.gmail.com>
 <53B430F3.9070804@mentor.com> <20140702162726.GG24879@arm.com>
 <CALCETrVSqH66jqG2_O2dir-3md4SHH800qs++4KhWYsGm9T-BQ@mail.gmail.com>
 <20140702172443.GI24879@arm.com>
 <CALCETrU-461E2ybeYcN7KFSPkwWtHikwCDo4t9T5Z5dCBGmNJA@mail.gmail.com>
 <20140702185422.GP24879@arm.com>
 <CALCETrXGi3a3G=dH2R6-mu2BwGdEyn3AXrGVRstye6zPO1mFxA@mail.gmail.com>
Message-ID: <20140722081354.GE24282@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 22, 2014 at 01:14:35AM +0100, Andy Lutomirski wrote:
> On Wed, Jul 2, 2014 at 11:54 AM, Will Deacon <will.deacon@arm.com> wrote:
> > Ok, so that explains why things are working at the moment and it sounds like
> > we have some wiggle room too. I'll look at moving the datapage anyway, since
> > having these artificial limits is error-prone and fragile, but I don't think
> > it's something we need to panic about immediately.
> >
> > Also, if you get to the bottom of your binutils issues with the section
> > allocation, that might work for us since we don't really have any legacy
> > binutils supporting arm64.
> 
> Just in case anyone still cares about this thread, moving the vvar
> area back before the vdso text is queued up for 3.17.  I gave up on
> reliably keeping binutils happy with my ugly hack.

The same change is also queued for arm64.

Thanks Andy,

Will
