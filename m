From: will.deacon@arm.com (Will Deacon)
Date: Thu, 15 Sep 2016 08:30:30 +0100
Subject: [GIT PULL] arm64: X-Gene platforms DTS changes queued for 4.9 -
 part1
In-Reply-To: <CADaLNDmMEWEd4o-tf4Kcqy7PP-abBg=Q1-Qdvv5CoDdoLEvi=Q@mail.gmail.com>
References: <CADaLNDkZdAipxx6cfLJ6yrzTrcLPS_Ciw8+T5EUFVcRRw+fjPw@mail.gmail.com>
 <6041122.z65jfDXEcc@wuerfel>
 <CADaLNDmMEWEd4o-tf4Kcqy7PP-abBg=Q1-Qdvv5CoDdoLEvi=Q@mail.gmail.com>
Message-ID: <20160915072709.GA3380@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Sep 14, 2016 at 06:57:59PM -0700, Duc Dang wrote:
> On Wed, Sep 14, 2016 at 7:59 AM, Arnd Bergmann <arnd@arndb.de> wrote:
> > On Friday, September 2, 2016 11:46:31 AM CEST Duc Dang wrote:
> >> Hi Arnd, Olof,
> >>
> >> This is the first part of DTS changes for X-Gene platforms targeted for 4.9.
> >>
> >> The changes include:
> >> + X-Gene Soc PMU support patch set from Tai Nguyen (v10 reviewed by
> >> Mark, DT binding document acked by Rob [1] and was suggested to merge
> >> via am-soc tree by Will [2])
> >> + Follow up patch to enable DT entry for SoC PMU on X-Gene v2
> >> + Correct PCIe legacy interrupt mode to level-active high
> >> + DTS entry for X-Gene hwmon (v4 acked by Guenter, DT binding document
> >> and driver is in linux-next now [3])
> >>
> >> Regards,
> >> Duc Dang.
> >
> > Sorry for the long delay, I've just now started looking at the dts changes
> > for arm64. The changes to arch/arm64/boot/dts look fine, but I don't
> > want to mix driver changes with dts changes, as we use separate
> > branches for those.
> >
> > Please send this again as two pull requests, one for the dts changes, and
> > one for the rest (pmu driver, binding and MAINTAINERS file). Please
> > also include an explanation in the tag description about why this gets
> > merged through arm-soc. I see that Will suggested doing it that way,
> > but I don't see what the reason is. We normally don't touch that directory.
> Hi Arnd,
> 
> I am not clear about the reason either. Probably we don't have a
> dedicated tree for SoC PMU?

That's right, there isn't a dedicated tree for SoC PMUs. I tend to handle
the architected PMUs (e.g. the ones in the CPUs), but other PMUs have
been ad-hoc in the past. That said, Mark and I do tend to review PMU
drivers, because the internal perf interface is pretty easy to get wrong.

Arnd -- what would you like to see here? I could collect SoC PMU patches
together and send you a pull request, or would you like me to take them via
the arm64 tree? It's worth noting that we have PMU drivers under drivers/bus
and drivers/hwtracing too, and I *think* arm-soc has handled those in the
past.

Will
