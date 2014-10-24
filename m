From: drake@endlessm.com (Daniel Drake)
Date: Fri, 24 Oct 2014 07:44:21 -0600
Subject: [PATCH 5/5] ARM: dts: Add dts files for Exynos4415 SoC
In-Reply-To: <544A5578.7030009@samsung.com>
References: <1413775749-17539-1-git-send-email-cw00.choi@samsung.com>
 <1413775935-17743-5-git-send-email-cw00.choi@samsung.com>
 <CAD8Lp46Y1WBF2Bq5SKtQDZ4kUb2fDCsbBs1THFWcV=8-OXh_SQ@mail.gmail.com>
 <544A5578.7030009@samsung.com>
Message-ID: <CAD8Lp45thqGRm-SjFnnht1EGuFYWabG_D9vWUQt+NnCcgVG7bg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Oct 24, 2014 at 7:34 AM, Marek Szyprowski
<m.szyprowski@samsung.com> wrote:
> Well, I also thought about such approach, but there are some fundamental
> differences:
> interrupt and clock controllers are completely different. Using a common
> exynos4.dtsi
> and overriding them in every node will result in a code, which is a bit hard
> to follow.
> IMHO with such differences justifies using separate base dtsi file.

For the things that aren't in common, they are already split out into
soc-specific files for the existing Exynos4 variants. Taking your
example of the CMU, it already differs in different exynos4 versions
therefore is not listed in exynos4.dtsi at all.

So this argument only seems valid if the differences are really huge,
or if you are also saying the existing exynos4 dts files are bad?
Personally I have come to like the current layout, although would
definitely appreciate the reference-based syntax mentioned by Tomasz,
and this seems like a good opportunity to at least fix up exynos4.dtsi
for that.

Daniel
