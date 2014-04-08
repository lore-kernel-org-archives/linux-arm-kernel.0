From: matthew_minter@xyratex.com (Matthew Minter)
Date: Tue, 8 Apr 2014 11:57:59 +0100
Subject: Armada XP (mvebu) PCIe memory (BAR/window) re-allocation
In-Reply-To: <20140407164536.GA9952@obsidianresearch.com>
References: <CAFJTrDt7OrtE4B52419F2KGbmXeLR9NEcgF6yMTMUBe5vdKwfg@mail.gmail.com>
 <20140326180634.4ac266b2@skate>
 <20140326171828.GA31887@obsidianresearch.com>
 <CAFJTrDvb7gcLkv8-HqbJSLEj7V2Zg=5+pXFR2r3AZxG7waT6WA@mail.gmail.com>
 <20140401164110.GA26093@obsidianresearch.com>
 <CAFJTrDu1=Hoa6NS3DaFphMUXgJYunybbdCoGiBVe1qKNQ4s3MA@mail.gmail.com>
 <20140403182322.GA9509@obsidianresearch.com>
 <20140403202455.599d1c6b@skate>
 <CAFJTrDuQv87t4N1pbw_mCZ=pZ82pX6cab+PmuhO1Fvvax==xdg@mail.gmail.com>
 <20140407164536.GA9952@obsidianresearch.com>
Message-ID: <CAFJTrDuN+WPg57scaxTMkdCf--Xc96DEwXQup4pSyQV9kpD+Sw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Guys,

I have already posted this on the other thread, however I can confirm
the first suggestion fixes this. It seems I am having the same issue
regarding the power of two memory windows. Is it still helpful for me
to do any more checks or should we consider this closed?

Many thanks,
Matt

On 7 April 2014 17:45, Jason Gunthorpe <jgunthorpe@obsidianresearch.com> wrote:
> On Mon, Apr 07, 2014 at 02:03:55PM +0100, Matthew Minter wrote:
>
>> However I am somewhat stumped on where to look next. I am going to
>
> Things to try:
>  - Look at the PCI Interrupt Cause Register, see this message
>    from Thomas and the related thread:
>  http://www.spinics.net/lists/arm-kernel/msg318400.html
>    Do this before and after the faulting instruction. If it doesn't
>    change then the fault is generated internally to the SOC
>  - diff the lspci -vv output against the non-hotplug case that works
>  - Dump and verify all the mbus registers, not just through debugfs.
>  - Check if the PLX has some special sequence required
>    to hotplug
>
> Cheers,
> Jason

-- 


------------------------------
For additional information including the registered office and the treatment of Xyratex confidential information please visit www.xyratex.com

------------------------------
