From: omaplinuxkernel@gmail.com (Shubhrajyoti Datta)
Date: Fri, 21 Sep 2012 17:18:45 +0530
Subject: [PATCH] serial: omap: fix the overrun case
In-Reply-To: <20120921113506.GF16003@arwen.pp.htv.fi>
References: <1348222976-7241-1-git-send-email-shubhrajyoti@ti.com>
 <20120921110050.GC16003@arwen.pp.htv.fi> <505C4CA4.6020507@ti.com>
 <20120921113506.GF16003@arwen.pp.htv.fi>
Message-ID: <CAM=Q2cuK8X8PkAF1=E14WNr4=nH1+h9Zt9u+A=ojSuiFmbgo_Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Sep 21, 2012 at 5:05 PM, Felipe Balbi <balbi@ti.com> wrote:
> On Fri, Sep 21, 2012 at 04:46:52PM +0530, Shubhrajyoti wrote:
>> On Friday 21 September 2012 04:30 PM, Felipe Balbi wrote:
>> > On Fri, Sep 21, 2012 at 03:52:56PM +0530, Shubhrajyoti D wrote:
[...]

>> it it is !  BRK_ERROR_BITS I return.
>
> That's what I mean. rlsi handler is basically taking care of those
> bits... So how come we get RLSI IRQ when those bits aren't set ?
>
> Meaning, you shouldn't ever need that check, right ? Ideally, whenever
> that handler is called, it's because BRK_ERROR_BITS are set.
>
> Maybe add a WARN_ONCE() kinda thing just to see if that will ever really
> happen ??

hmm yes. will get back.

>
> --
> balbi
