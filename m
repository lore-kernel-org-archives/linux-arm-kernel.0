From: will.deacon@arm.com (Will Deacon)
Date: Fri, 4 Jul 2014 09:24:42 +0100
Subject: arch/arm64/efi-stub.o rebuilding every time?
In-Reply-To: <1404455777.3649.154.camel@mfleming-mobl1.ger.corp.intel.com>
References: <20140703141342.GB14305@arm.com>
 <CAKv+Gu_pRmMU+_ApBMYiBjQAPygrsTSs-iy4zrAUN9L28uAqag@mail.gmail.com>
 <1404455777.3649.154.camel@mfleming-mobl1.ger.corp.intel.com>
Message-ID: <20140704082442.GE23379@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 04, 2014 at 07:36:17AM +0100, Matt Fleming wrote:
> On Thu, 2014-07-03 at 16:16 +0200, Ard Biesheuvel wrote:
> > On 3 July 2014 16:13, Will Deacon <will.deacon@arm.com> wrote:
> > > Hi guys,
> > >
> > > If I build an arm64 kernel, then simply hit make again without changing
> > > anything, I find that efi-stub.o is rebuilt every time (with an annoying
> > > warning too, but I think you already know about that):
> > >
> > 
> > Yep, I had noticed that as well. The reason is that it depends on
> > generated header files, which it shouldn't. There's already a patch
> > queued in Matt Fleming's tree for this:
> > https://git.kernel.org/cgit/linux/kernel/git/mfleming/efi.git/commit/?h=next&id=86b2eb8cdffda7eef07b1d6e5464491df1e86ee9
> 
> It sounds like that commit should actually be put into my 'urgent'
> branch and sent to tip asap instead of being queued up for the next
> merge window.
> 
> Objections?

Sounds good to me. You can also add my ack, if you like:

  Acked-by: Will Deacon <will.deacon@arm.com>

Will
