From: broonie@kernel.org (Mark Brown)
Date: Mon, 21 Mar 2016 17:51:12 +0000
Subject: [PATCH v4 2/8] Documentation: arm: define DT cpu capacity bindings
In-Reply-To: <20160321172452.GE12319@e106622-lin>
References: <1458311054-13524-1-git-send-email-juri.lelli@arm.com>
 <1458311054-13524-3-git-send-email-juri.lelli@arm.com>
 <56EC3F9E.4050209@nvidia.com> <20160321105330.GB12319@e106622-lin>
 <CAKfTPtDP3zMR+zbvvqJCBvJ5r44do8NS03wC7pAejxPd0zHTMA@mail.gmail.com>
 <20160321114956.GD12319@e106622-lin>
 <20160321121210.GQ2566@sirena.org.uk>
 <20160321172452.GE12319@e106622-lin>
Message-ID: <20160321175112.GY2566@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Mar 21, 2016 at 05:24:52PM +0000, Juri Lelli wrote:

> I think this should work, but we have to understand how do we obtain the
> max frequency of each cluster while parsing DT. OPP bindings are
> helpful, but AFAIK there are platforms for which firmware is responsible
> for setting up and advertise available OPPs. I'm not sure if this
> happens later on during the boot process. We might still be able to use
> the clock-frequency property in this case, but that might need changing
> again if the top OPP gets removed/changed.

> OTH, we might simply want to say that capacity values are to be obtained
> once the platform is "stable" (no additional changes to configuration,
> OPPs, etc.). But this is maybe not acceptable?

How about we just punt and let the cpufreq driver tell us - it can parse
DT, use built in tables or whatever?  We could even remember the raw
values and recalculate if it ever decides to change for some reason.
Until cpufreq comes up we'll be stuck at whatever OPP that we're at on
startup which may not match whatever we define the numbers relative to
anyway.

> Also, I fear that for variants of a particular implementation we will
> still have to redo the profiling anyway (like we alreaady did for Juno
> and Juno-r2 for example).

This sometimes happens either through binning or through board design
decisions rather than through new silicon so we might be able to reuse.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160321/16a7a035/attachment.sig>
