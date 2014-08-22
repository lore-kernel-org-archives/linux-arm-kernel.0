From: dianders@chromium.org (Doug Anderson)
Date: Fri, 22 Aug 2014 15:15:04 -0700
Subject: [PATCH v9 1/2] regulator: Add driver for max77802 PMIC PMIC
 regulators
In-Reply-To: <53F7BDD8.7060500@collabora.co.uk>
References: <1408350762-15520-1-git-send-email-javier.martinez@collabora.co.uk>
 <1408350762-15520-2-git-send-email-javier.martinez@collabora.co.uk>
 <CA+NduCDL65=Y=PyU3FfXsTz0FfbmYzicGrY4U7ji3_V+nXhtCQ@mail.gmail.com>
 <53F73472.8010609@collabora.co.uk>
 <20140822144531.GV24407@sirena.org.uk>
 <53F7838F.8060906@collabora.co.uk>
 <20140822183054.GY24407@sirena.org.uk>
 <53F7BDD8.7060500@collabora.co.uk>
Message-ID: <CAD=FV=WC0h7fYm2QFqu3Zka7CsU4BtG-oyPpJav+ygC+gmCR+A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Fri, Aug 22, 2014 at 3:02 PM, Javier Martinez Canillas
<javier.martinez@collabora.co.uk> wrote:
> Hello Mark,
>
> On 08/22/2014 08:30 PM, Mark Brown wrote:
>>
>>> The problem is that one of these regulators is used as the vqmmc-supply
>>> (VCCQ/VDD_IO) so the mmc host controller driver disables it on
>>> MMC_POWER_OFF. Now AFAIK (Yuvaraj can correct me what I got wrong) this
>>> shouldn't be an issue since on card detection, the vqmmc supply should be
>>> enabled again but on Exynos the built-in card detect line is on the same
>>> power rail as vqmmc. That means that disabling the regulator prevents card
>>> insertions to be detected.
>>
>> If the MMC host controller needs a supply enabling in order to do card
>> detection and it's supposed to be doing card detection I'd expect it to
>> be enabling that supply.  Why is it not doing that?
>>
>
> Good question. I'm not that familiar with the dw_mmc host controller nor
> its driver implementation so I'll let Yuvaraj or Doug to answer that.

I haven't seen the issue that Yuvaraj is reporting (but I also haven't
picked up all of the relevant patches and tried to reproduce), so I'm
going to have to leave it to Yuvaraj to answer.

As far as I know the dw_mmc driver ought to be enabling vqmmc when it
needs it.  Perhaps there's a bug in your patch series that adds vqmmc
support to dw_mmc?

-Doug
