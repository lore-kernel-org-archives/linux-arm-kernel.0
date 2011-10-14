From: olof@lixom.net (Olof Johansson)
Date: Fri, 14 Oct 2011 10:58:35 -0700
Subject: [PATCH] arm/tegra: select AUTO_ZRELADDR by default
In-Reply-To: <alpine.LFD.2.02.1110141348270.17040@xanadu.home>
References: <1317172068-14872-1-git-send-email-pdeschrijver@nvidia.com>
	<20111014071500.GP21648@n2100.arm.linux.org.uk>
	<74CDBE0F657A3D45AFBB94109FB122FF173BE1A260@HQMAIL01.nvidia.com>
	<201110141729.41515.arnd@arndb.de>
	<74CDBE0F657A3D45AFBB94109FB122FF173BE1A283@HQMAIL01.nvidia.com>
	<alpine.LFD.2.02.1110141348270.17040@xanadu.home>
Message-ID: <CAOesGMhm_dD=9dyMWQRfH5AXH4AE42+4ckNwhnMUGaBJEHsumg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Fri, Oct 14, 2011 at 10:53 AM, Nicolas Pitre <nico@fluxnic.net> wrote:

> As I explained yesterday, I'm working on more cleanups that involve
> reworking the dependencies around ZBOOTROM, AUTO_ZRELADDR and friends,
> and removing zreladdr for all platforms. ?So please do not come up with
> Tegra specific hacks to fix this up. ?So for the time being I'd simply
> suggest using the minimal fix i.e.:
>
> ? ? ? ?select AUTO_ZRELADDR if !ZBOOT_ROM
>
> And eventually this will disappear entirely in favor of a single global
> config option which is not platform dependent.

Odd, I'm not seeing any mention of the above on the list (especially
not posted yesterday), but that sounds good to me.

We've dropped the patch for now, if t30 needs it we can update the
defconfig when the time comes, and wait for your cleanup for the rest.


-Olof
