From: geoff@infradead.org (Geoff Levand)
Date: Thu, 07 Aug 2014 10:09:39 -0700
Subject: Kexec on arm64
In-Reply-To: <20140807095919.GC9984@leverpostej>
References: <CAFdej014ohCFYvoUAXWiYGb4_4UmSY2G1MH-NEE_cF1cC-6Mow@mail.gmail.com>
 <20140728153812.GA2576@leverpostej> <1406592548.28348.49.camel@smoke>
 <CAFdej00is0kC-1q5uMNJL5APL1WezdNBg0jASgwYamsg5NO_Tg@mail.gmail.com>
 <20140729133557.GQ2576@leverpostej> <1406668741.28348.75.camel@smoke>
 <CAFdej02sTBsjHz+FCqjKkY9pF5sPF6n6QUtEadHi0hK3MxRxGA@mail.gmail.com>
 <CAFdej01ZHkTVZuN_0RrGbFmoG4_NTnwm6KDAPM_sf=zHBHSRwg@mail.gmail.com>
 <20140804113528.GC3197@leverpostej> <1407372003.8971.85.camel@smoke>
 <20140807095919.GC9984@leverpostej>
Message-ID: <1407431379.8971.91.camel@smoke>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 2014-08-07 at 10:59 +0100, Mark Rutland wrote:
> On Thu, Aug 07, 2014 at 01:40:03AM +0100, Geoff Levand wrote:
> > 
> > I haven't looked into it yet, but booting.txt says that the dtb must be
> > 'within the first 512 megabytes from the start of the kernel image'.  If
> > this restriction still holds we can't just put the dtb at
> > text_offset + image_size.
> 
> Isn't that only a problem if text_offset + image_size is huge (510MB+)?

Yes, a limit I don't think we need to be too concerned about at present.

> The wording in booting.txt doesn't sound quite right. As I understand
> it, the 512MB restriction is because of the way we map the dtb in the
> swapper page tables.
> 
> So a better wording would be "the kernel and DTB must be placed in the
> same naturally-aligned 512MB region of memory".
> 
> It should be possible to get rid of the restrictions on the placement of
> the image and DTB, but this requires reworking the VA layout (using a
> kernel text mapping separate from the linear map as with x86_64, and
> similarly having a separate DTB mapping), and unfortunately I haven't
> had the time to do that.

Or maybe just relocate the dtb at startup to within range.

-Geoff
