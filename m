From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Tue, 5 Dec 2017 11:36:18 +0100
Subject: [PATCH v2 00/27] Improve DE2 support
In-Reply-To: <20171201060550.10392-1-jernej.skrabec@siol.net>
References: <20171201060550.10392-1-jernej.skrabec@siol.net>
Message-ID: <20171205103618.ps64m57xemsbo44r@flea.lan>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Fri, Dec 01, 2017 at 07:05:23AM +0100, Jernej Skrabec wrote:
> Current DE2 driver is very basic and uses a lot of magic constants since
> there is no documentation and knowledge about it was limited at the time.
> 
> With studying BSP source code, deeper knowledge was gained which allows
> to improve mainline driver considerably.
> 
> At the beginning of this series, some code refactoring is done as well
> as adding some checks (patches 1-15).
> 
> Further patches add multi-plane support with HW scaling and all possible
> RGB formats (patches 16-21).
> 
> At last, support for YUV formats is added (patches 22-26).
> 
> At the end, I included patch which puts lowest plane before second lowest.
> This should help testing VI planes when mixer has configuration 1 VI plane
> and 1 or more UI planes (most SoCs except V3s).
> 
> This code was developed on H3, but it should work on every SoC if correct
> configuration structure is provided.
> 
> H3 code can be found here:
> https://github.com/jernejsk/linux-1/commits/de2_impr_for_next

Thanks a lot for that huge rework.

I've applied the patches 1 to 26, and will push them to drm-misc once
the compilations are done.

In the future, if you happen to do such a huge rework again (which
hopefully won't be needed :)), please use the -M option of
format-patch. It will reduce a lot the verbosity of files renaming and
will help the review.

Thanks!
Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20171205/45d8e03c/attachment.sig>
