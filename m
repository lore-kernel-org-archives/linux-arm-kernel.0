From: holler@ahsoftware.de (Alexander Holler)
Date: Fri, 22 Jun 2012 13:28:14 +0200
Subject: arm erratas (config options)
In-Reply-To: <20120622103512.GB19026@n2100.arm.linux.org.uk>
References: <4FE44378.9050803@ahsoftware.de>
 <20120622103512.GB19026@n2100.arm.linux.org.uk>
Message-ID: <4FE456CE.9060507@ahsoftware.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

I made a full quote (as copy for others) because I find the answers very 
enlighting ;)

Am 22.06.2012 12:35, schrieb Russell King - ARM Linux:
> On Fri, Jun 22, 2012 at 12:05:44PM +0200, Alexander Holler wrote:
>> E.g. /proc/cpuinfo talks about variant and revision while all the help
>> texts for the erratas are talking about rNpM (which I would translate to
>> "revision" and "patch level", without knowing the real meanings).
>
> rNpM is a hardware thing.  On the test chips which ARM Ltd supply on
> their platforms, it's marked on the case.  With SoC vendors, the only
> way to know this definitively is to ask them.
>
>> This makes it necessary to translate "variant" to 'r' and "revision" to
>> 'p', which isn't really obvious (because most people would translate
>> "revision" to 'r' and would wonder how to find the value for 'p' in
>> /proc/cpuinfo or somewhere else).
>
> The variant and revision are terms used in the ARM ARM (or was used at
> some point) which don't always reflect the rNpM marking on the package.
> Sometimes, a hardware change is made which updates the rNpM but doesn't
> update the ID registers.  So they can't be relied upon.
>
>> Another source of confusion about which arm erratas should be enabled
>> for a specific processor is that not all the help texts for the erratas
>> are clear about which variants and revisions are effected. E.g. the help
>> texts for erratas 460075 or 458693 are talking about r2p0, but they
>> doesn't mention if older variants (e.g. r1p3) get hit by these erratas
>> too. The help texts for other erratas (e.g. 743622 and 754322) are
>> talking about r2p*, which I would interpret that this errata applies
>> only to variant 2, but I would never be sure (reading only the help
>> text).
>
> You can enable them all, and the kernel will (attempt) to apply those
> which are applicable to your CPU based on the ID register and the values
> we know for the ID register corresponding to a particular rNpM part.
>
> The reason they are configuration options is so that you can disable
> them and remove that code from the kernel if you wish (and you know
> they don't apply) or if you have an explicit need to disable them (you
> want to run a test case, or you know that the kernel itself can't apply
> the work-around because you're running in non-secure mode.)

Hmm, because some of the workarounds sound scary (when thinking about 
performance), I would prefer just to not see them for not getting 
tempted to disable the workarounds, even if I should know it better. ;)

Thanks for the answer which explains everything.

Regards,

Alexander
