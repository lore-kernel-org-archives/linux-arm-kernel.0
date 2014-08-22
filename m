From: broonie@kernel.org (Mark Brown)
Date: Fri, 22 Aug 2014 13:30:54 -0500
Subject: [PATCH v9 1/2] regulator: Add driver for max77802 PMIC PMIC
 regulators
In-Reply-To: <53F7838F.8060906@collabora.co.uk>
References: <1408350762-15520-1-git-send-email-javier.martinez@collabora.co.uk>
 <1408350762-15520-2-git-send-email-javier.martinez@collabora.co.uk>
 <CA+NduCDL65=Y=PyU3FfXsTz0FfbmYzicGrY4U7ji3_V+nXhtCQ@mail.gmail.com>
 <53F73472.8010609@collabora.co.uk>
 <20140822144531.GV24407@sirena.org.uk>
 <53F7838F.8060906@collabora.co.uk>
Message-ID: <20140822183054.GY24407@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Aug 22, 2014 at 07:53:19PM +0200, Javier Martinez Canillas wrote:
> On 08/22/2014 04:45 PM, Mark Brown wrote:
> > On Fri, Aug 22, 2014 at 02:15:46PM +0200, Javier Martinez Canillas wrote:

> >> Mark, any opinions on how this should be solved will be highly appreciated.

> > If someone could tell me what "this" is that'd help...

> Sorry for not being clear on that regard. By "this" I meant the problem
> reported by Yuvaraj.

That mail was rather lengthy and seemed to be discussing several issues.

> The problem is that one of these regulators is used as the vqmmc-supply
> (VCCQ/VDD_IO) so the mmc host controller driver disables it on
> MMC_POWER_OFF. Now AFAIK (Yuvaraj can correct me what I got wrong) this
> shouldn't be an issue since on card detection, the vqmmc supply should be
> enabled again but on Exynos the built-in card detect line is on the same
> power rail as vqmmc. That means that disabling the regulator prevents card
> insertions to be detected.

If the MMC host controller needs a supply enabling in order to do card
detection and it's supposed to be doing card detection I'd expect it to
be enabling that supply.  Why is it not doing that?
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140822/c1622e3c/attachment-0001.sig>
