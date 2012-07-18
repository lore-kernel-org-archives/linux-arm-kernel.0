From: grant.likely@secretlab.ca (Grant Likely)
Date: Wed, 18 Jul 2012 10:27:03 -0600
Subject: Boot breaks in -next from LEGACY to LINEAR conversion
In-Reply-To: <20120718161023.GE4495@opensource.wolfsonmicro.com>
References: <20120717185749.GJ4477@opensource.wolfsonmicro.com>
 <20120718161023.GE4495@opensource.wolfsonmicro.com>
Message-ID: <CACxGe6tSWGOFs=FgUc8UADmnMM-kGCdwXj9hM2cAep_LKp4M-Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 18, 2012 at 10:10 AM, Mark Brown
<broonie@opensource.wolfsonmicro.com> wrote:
> On Tue, Jul 17, 2012 at 07:57:49PM +0100, Mark Brown wrote:
>> -next fails to boot for me today on my s3c64xx based systems.  Walking
>> back to the last time I tried and bisecting likely branches I find that
>> commit 910139 (irqdomain: Replace LEGACY mapping with LINEAR) is the one
>> that introduces the build break.  Unfortunately the boot fails before I
>> get a console which makes diagnosis somewhat more tricky than would be
>> ideal.  Any ideas?
>
> Further data: the irq_domain_associate_many() calls that we're now doing
> are also causing WARN_ON()s to go off during boot after commit 98aa46
> (irqdomain: Support for static IRQ mapping and association) causing
> breakage for my interrupt using MFDs.
>
> I don't really have time to investigate now but backing out that commit
> seems to make things much happier, I suspect there's some collision with
> IRQs allocated statically by the platform but I don't immediately see
> what's new here.

I had seen that on my end too, but I thought I had fixed it...  I
guess not (or this is a similar type of failure).  I'll investigate.

g.



-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
