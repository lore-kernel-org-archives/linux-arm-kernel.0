From: tomi.valkeinen@ti.com (Tomi Valkeinen)
Date: Fri, 16 May 2014 08:56:56 +0300
Subject: [PATCH 3/4] OMAPDSS: panel-sharp-ls037v7dw01: add device tree
 support
In-Reply-To: <20140515182133.GC23659@atomide.com>
References: <CABxcv=mY0a+yJgmCTPN=BhSQD57Pw022zOd5_KxEgvvF_-=O7Q@mail.gmail.com>
 <20140512142646.GA31772@atomide.com> <5370E0C9.8050201@ti.com>
 <20140512155132.GH31772@atomide.com> <5371F923.80000@ti.com>
 <CABxcv==_LCw1kPYm17g=h8VfSN2V_qsgXjTnsy-JOetawSv4pA@mail.gmail.com>
 <20140513152518.GA16837@atomide.com> <53730AFB.2090800@ti.com>
 <20140514160216.GD18463@atomide.com> <537487AE.3060906@ti.com>
 <20140515182133.GC23659@atomide.com>
Message-ID: <5375A8A8.7080306@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 15/05/14 21:21, Tony Lindgren wrote:

>> But you're right, having "sharp,ls037v7dw01-omap-dss" in the .dts is an
>> alternative for the compatible-string conversion we do now. I guess it's
>> a matter of taste, but I rather hide it inside the kernel, in an
>> internal omapdss file, than pollute the .dts files with those compatible
>> strings.
> 
> Well it avoid you parsing through all the nodes during booting
> and leaves out the function to do remapping. And removes the need
> for maintaining a custom display mapping table. I'd say that's a
> pretty good list of advantages right there :)

Yep... I don't know. Maybe I'm being too careful about doing wrong
things with .dts. I just like it more if any hacks are in kernel code,
which I can remove without anyone noticing.

Anyway, we already have board.dts files using the non-omapified
compatible strings in the mainline, so if I would now add the omapified
compatible strings to .dts files, those old board.dts files would break.

So I guess the choice has already been made.

 Tomi


-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: OpenPGP digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140516/24dd0101/attachment-0001.sig>
