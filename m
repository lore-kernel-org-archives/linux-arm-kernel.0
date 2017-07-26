From: robert.jarzmik@free.fr (Robert Jarzmik)
Date: Wed, 26 Jul 2017 23:02:46 +0200
Subject: [BUG] v4.12 breaks pxa25x
In-Reply-To: <20170726220334.2961ae22@roar.ozlabs.ibm.com> (Nicholas Piggin's
 message of "Wed, 26 Jul 2017 22:03:34 +1000")
References: <87inirsgzk.fsf@belgarion.home>
 <20170717081518.GI31807@n2100.armlinux.org.uk>
 <87eftfrs0e.fsf@belgarion.home> <87o9s7qw64.fsf@belgarion.home>
 <20170726114139.GN31807@n2100.armlinux.org.uk>
 <20170726220334.2961ae22@roar.ozlabs.ibm.com>
Message-ID: <87k22urjwp.fsf@belgarion.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Nicholas Piggin <npiggin@gmail.com> writes:

> On Wed, 26 Jul 2017 12:41:39 +0100
> Russell King - ARM Linux <linux@armlinux.org.uk> wrote:
>> Obviously, the mixing of .data.unlikely with the normal .data sections
>> is undesirable - that looks like it's come from commit b67067f1176d
>> ("kbuild: allow archs to select link dead code/data elimination") dated
>> 2016, which according to git describe --contains was merged in v4.9-rc1.
>> So it's unlikely to be directly caused by this, although this commit is
>> implicated.
>> 
>> I wonder if Nick realised this side effect (that .data.unlikely is no
>> longer grouped together) - maybe we need to rename .data.unlikely?
>> (Adding Nick and Michal).
>
> I did to some degree -- hence TEXT was not done that way -- but obviously
> did not look closely enough.
>
> The right short term fix I think is to make those wildcards depend only on
> CONFIG_LD_DEAD_CODE_DATA_ELIMINATION.
>
> One way to avoid clashes with compiler generated section names is to use
> ".." as separators in our section names.
>
> Anyway I'll code up a fix for the linker script that we can get into 4.12,
> thanks for pointing it out.
Ok, cool. I'd like to be copied to your patch so that I can test it please.

For what is worth, your patch, Russell, fixes the issue as well, I just tested
it.

Cheers.

-- 
Robert
