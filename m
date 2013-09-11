From: rjw@sisk.pl (Rafael J. Wysocki)
Date: Wed, 11 Sep 2013 15:28:26 +0200
Subject: "cpufreq: fix serialization issues with freq change notifiers"
 breaks cpufreq too
In-Reply-To: <Pine.LNX.4.64.1309111015190.26942@axis700.grange>
References: <Pine.LNX.4.64.1309091656200.6602@axis700.grange>
 <CAKohpokaHU0V86DPB7nEQ8ndwu_mJ_x_Uz47XPHZeyAW3hcP_w@mail.gmail.com>
 <Pine.LNX.4.64.1309111015190.26942@axis700.grange>
Message-ID: <11617025.s66NV700Er@vostro.rjw.lan>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday, September 11, 2013 10:15:53 AM Guennadi Liakhovetski wrote:
> On Wed, 11 Sep 2013, Viresh Kumar wrote:
> 
> > On 10 September 2013 22:37, Guennadi Liakhovetski <g.liakhovetski@gmx.de> wrote:
> > > On Tue, 10 Sep 2013, Viresh Kumar wrote:
> > >> Quite straight forward actually..
> > >
> > > Apparently, not quite.
> > 
> > I overlooked the situation where we return early from ->target() routines.. :(
> > 
> > Please try attached patches, I will repost them later (once I am able to
> > convince Rafael that these are really important :) )
> 
> I'd rather wait until Rafael is convinced, then we'll see.

I'm going to revert the commit that was the source of these issues, but that
doesn't mean that everything is now rosy.  We need to fix the concurrency
problems that Viresh was trying to fix in that commit, so it would be nice if
you could verify whether or not he is on the right track.

Thanks,
Rafael
