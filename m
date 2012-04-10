From: santosh.shilimkar@ti.com (Santosh Shilimkar)
Date: Tue, 10 Apr 2012 14:27:36 +0530
Subject: [PATCH 1/3] ARM: OMAP2+: 32k-counter: Use hwmod lookup to check
 presence of 32k timer
In-Reply-To: <20120410084413.GD25053@n2100.arm.linux.org.uk>
References: <79CD15C6BA57404B839C016229A409A8318461E8@DBDE01.ent.ti.com>
 <CAMQu2gxuFsovKTPK8wFOO8vMeiyMFnTqNDRZYgAcCsVWytpOTA@mail.gmail.com>
 <79CD15C6BA57404B839C016229A409A83184846A@DBDE01.ent.ti.com>
 <20120405095221.GC25053@n2100.arm.linux.org.uk>
 <79CD15C6BA57404B839C016229A409A831848621@DBDE01.ent.ti.com>
 <87hawxkgoi.fsf@ti.com>
 <79CD15C6BA57404B839C016229A409A831849432@DBDE01.ent.ti.com>
 <20120406180452.GB15734@atomide.com>
 <79CD15C6BA57404B839C016229A409A83184ABEF@DBDE01.ent.ti.com>
 <4F83440E.70502@ti.com> <20120410084413.GD25053@n2100.arm.linux.org.uk>
Message-ID: <4F83F600.4000002@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 10 April 2012 02:14 PM, Russell King - ARM Linux wrote:
> On Mon, Apr 09, 2012 at 03:18:22PM -0500, Jon Hunter wrote:
>> True, but we would always want to use the 32k timer if CONFIG_PM is  
>> specified. So what I am saying is that if a device has a 32ksync timer  
>> and CONFIG_PM is defined, we always want to use the 32ksync timer and a  
>> gptimer should never be used.
> 
> Why?  What if you want to have PM enabled, and you also want to use the
> kernels high resolution timers, or you want more accurate timing than
> the 30.5us tick interval of the 32k timer?

You might have missed the earlier comments on the thread. High
resolution GP timer(sysclk) will stop in deeper power states and
hence it can't be used with PM enabled usecases.

Regards
Santosh
