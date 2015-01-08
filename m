From: thierry.reding@gmail.com (Thierry Reding)
Date: Thu, 8 Jan 2015 11:55:31 +0100
Subject: [PATCH 1/2] arm64: Kconfig: add basic support for the Tegra SoC
 family and the Tegra132 SoC
In-Reply-To: <54AE5DD0.6020409@nvidia.com>
References: <20150107081638.14381.42444.stgit@dusk.lan>
 <20150107081729.14381.47835.stgit@dusk.lan>
 <20150107142005.GA1621@ulmo> <54AE5DD0.6020409@nvidia.com>
Message-ID: <20150108105529.GH1987@ulmo.nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 08, 2015 at 03:37:04AM -0700, Paul Walmsley wrote:
> Hi Thierry,
> 
> On 01/07/2015 07:20 AM, Thierry Reding wrote:
> >* PGP Signed by an unknown key
> >
> >On Wed, Jan 07, 2015 at 01:17:33AM -0700, Paul Walmsley wrote:
> >>Add basic Kbuild support for the Tegra SoC family, and specifically,
> >>the Tegra132 SoC.  Tegra132 pairs the NVIDIA Denver CPU complex with
> >>the SoC integration of Tegra124 - hence the use of ARCH_TEGRA and the
> >>Tegra124 pinctrl option.
> >>
> >>For the time being, Tegra ARM64 support is added with a dependency on
> >>CONFIG_BROKEN.  This is temporary and can be removed when the
> >>following two patches for compilation failures have been merged:
> >>
> >>"soc: tegra: pmc: restrict compilation of suspend-related support to ARM"
> >>https://git.kernel.org/cgit/linux/kernel/git/pjw/tegra-dev.git/commit/?id=053decbf3900d4e8fee799f9a29cf8d905b2fcb1
> >I think you said you were going to respin this on top of v3.19-rc1, but
> >the above doesn't seem to be rebased yet. Given that the only comments
> >were bikeshed from my part, do you have any objections to me taking the
> >patch and apply the bikeshed myself?
> 
> Sorry about that.  I am indeed on the hook for that.   I got distracted with
> some other patches and haven't yet reposted that one :-(
> I will do that later today.  If you would prefer to do it yourself, that's
> fine too.

I ended up applying your patch as is. Retrospectively my comments had
been a little too much on the pedantic side.

> >>"clocksource: tegra: wrap arch/arm-specific sections in CONFIG_ARM"
> >>https://git.kernel.org/cgit/linux/kernel/git/pjw/tegra-dev.git/commit/?id=220aa7fcc74a1a089916be6cb34b0e326f31841f
> >I don't think I've seen any comments other than mine on this patch.
> >Given that this patch depends on the above to get rid of the BROKEN
> >dependency, it might still be preferable to take both via the Tegra
> >tree. Otherwise we probably have to wait until v3.21 before we can
> >apply this.
> 
> I'm fine with them going in through you if you have a strong preference for
> that approach.   Generally my preference is for patches to go in through the
> direct maintainer's tree to minimize the risk and hassle of merge conflicts.
> But if you'll take care of that side of it, it doesn't matter too much to me
> :-)   We just need to pick up acks from the direct maintainers, I guess?

Yes, we really just need an ack from either Daniel or Thomas on the
clocksource patch. I don't think that driver has a lot of potential for
merge conflicts.

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150108/211b5a39/attachment.sig>
