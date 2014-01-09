From: julian.calaby@gmail.com (Julian Calaby)
Date: Thu, 9 Jan 2014 11:15:35 +1100
Subject: [linux-sunxi] [ANNOUNCE] sunxi-babelfish (FEX-to-DT translator)
In-Reply-To: <1389216256.7769.39.camel@hastur.hellion.org.uk>
References: <20140107220310.GD3103@lukather>
 <1389200137.27473.6.camel@kazak.uk.xensource.com>
 <20140108182906.GH2941@lukather>
 <1389216256.7769.39.camel@hastur.hellion.org.uk>
Message-ID: <CAGRGNgVrK0BAbi+kjSTP7RnE5GsmtqQi7MKM9Y0Oi=4FRD2kgA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Ian,

On Thu, Jan 9, 2014 at 8:24 AM, Ian Campbell <ijc@hellion.org.uk> wrote:
> On Wed, 2014-01-08 at 19:29 +0100, Maxime Ripard wrote:
>> On Wed, Jan 08, 2014 at 04:55:37PM +0000, Ian Campbell wrote:
>> > On Tue, 2014-01-07 at 23:03 +0100, Maxime Ripard wrote:
>> > > Another nice thing about it is that a FEX-to-DT compiler comes at no
>> > > cost afterwards. Since dtc is able to generate a DTS from
>> > > /proc/device-tree, you can easily generate a DTS for your previously
>> > > non-supported board using
>> > >
>> > >   dtc -I fs -O dts -o my-board.dts /proc/device-tree/
>> >
>> > I wonder if it might also be useful to compile this as a normal user
>> > space application which takes the fex and produces the dtb (or dts)?
>>
>> At the moment, no, libfdt only operates on DTB, so we would have to
>> chain this somehow with dtc to at least do the DTB to DTS conversion I
>> guess.
>>
>> It's not something that I'm pretty fond of either. Or, I don't really
>> see the benefit of it.
>>
>> Let's say that you have such tool, I'm guessing one would want it to
>> mass-convert fex files to DT. But then, you'd still have to boot that
>> DT to be sure that everything is working, so you're pretty much losing
>> the mass-convertion thing, since you would have boot this with a
>> baremetal babelfish anyway.
>
> I wasn't really thinking of mass conversion. just an easy way for people
> to produce a starting point for their platform to send upstream.
>
>> > I suppose producing something upstreamable would be different/harder
>> > though, since it would need to not inline/merge the dtsi file but just
>> > leave the include stmt. That's probably a different tool.
>>
>> Yeah, dtc outputs a "flat" DTS, without any include, so you still need
>> to edit it by hand to remove the common part, remove the duplicated
>> pinctrl nodes, fix the phandle, etc.
>>
>> But most of that can be scripted I guess.
>
> I think this could be done as a separate tool which read a FEX and
> outputted the dts directly (i.e. with printf). The output would have the
> #include for the right dtsi in place and the appropriate overrides
> derived from the FEX. That's not really anything like your
> sunxi-babelfish though.

I was thinking about exactly this in the context of my (stalled)
online fex / board submission helper tool.

I.e. $RANDOM_USER submits their script.bin / script.fex file then it
produces (amongst other things) a dts based on it's contents using
sensible conversions based on what other knowledgeable people have
done in the past.

I was also thinking about adding a mass-converting interface to this
tool so we could regenerate the u-boot memory info and kernel dts
files from the contents of sunxi-boards.

Thanks,

-- 
Julian Calaby

Email: julian.calaby at gmail.com
Profile: http://www.google.com/profiles/julian.calaby/
.Plan: http://sites.google.com/site/juliancalaby/
