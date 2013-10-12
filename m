From: t-kristo@ti.com (Tero Kristo)
Date: Sat, 12 Oct 2013 13:25:47 +0300
Subject: [PATCHv7 00/36] ARM: OMAP: clock data conversion to DT
In-Reply-To: <alpine.DEB.2.02.1310112226130.27397@utopia.booyaka.com>
References: <1380098922-30340-1-git-send-email-t-kristo@ti.com>
 <524EE00F.7010208@ti.com> <20131007021556.GV8949@atomide.com>
 <52525642.8010307@ti.com> <20131007154103.GW8949@atomide.com>
 <20131007190322.GY8949@atomide.com>
 <alpine.DEB.2.02.1310091551540.30199@utopia.booyaka.com>
 <alpine.DEB.2.02.1310091858411.30199@utopia.booyaka.com>
 <525654AE.7060009@ti.com>
 <alpine.DEB.2.02.1310111749180.27397@utopia.booyaka.com>
 <52584785.2020504@ti.com>
 <alpine.DEB.2.02.1310112226130.27397@utopia.booyaka.com>
Message-ID: <525923AB.4030807@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/12/2013 01:37 AM, Paul Walmsley wrote:
> On Fri, 11 Oct 2013, Tero Kristo wrote:
>
>> Oh yea, one additional note you probably have missed. Mike asked us to fall
>> back to vendor specific bindings at around v6 or so of this set. Take a look
>> at v8, we have dropped the use of generic bindings, we are not trying to
>> declare those with this set.
>
> No, I didn't miss it.
>
>> This set introduces vendor specific bindings only, and even these are
>> claimed 'unstable', which should be enough to discourage people from
>> burning those to OTP type memory.
>
> Better to just avoid merging unstable bindings in the first place.
>
> Please keep this in mind: any change that anyone makes to the DT data
> needs to be supportable by the kernel into the indefinite future, once it
> makes it into arch/arm/boot/dts or the DT binding documentation.  Also,
> any changes need to work for other OSes, i.e., the changes should not be
> Linux-specific.

As pointed out earlier, the unstable claim just points to the fact that 
we might have some generic clock bindings in distant future at which 
point we _might_ evolve that way. Personally I have no problems carrying 
these binding to the far future, as they are vendor specific, and pretty 
much also device specific (am3-dpll-* omap4-dpll-* etc.)

Later on, we can add also support for clock firmware or whatever if we 
want to optimize stuff.

If we do not merge the bindings now, what is your proposal then? We have 
a couple of new SoC:s in queue and getting them boot mainline currently 
we only have this option to get them to work. Hardware is not going to 
wait for two years so we can have generic clock bindings in place. I 
would rather have this resolved as soon as possible, and it would have 
been much better if you came forward with your claims at version 1 or 2 
of this set, rather than at v8 and saying all should be forfeit.

-Tero

>
> Those have been stated goals for the Linux DT project since day one.
> Some folks haven't been monitoring those goals very closely and that's
> unfortunate.  We could have avoided some pretty big messes.
>
>
> - Paul
>
