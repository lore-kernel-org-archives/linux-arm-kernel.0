From: javier.martinez@collabora.co.uk (Javier Martinez Canillas)
Date: Sat, 23 Aug 2014 00:02:00 +0200
Subject: [PATCH v9 1/2] regulator: Add driver for max77802 PMIC PMIC
 regulators
In-Reply-To: <20140822183054.GY24407@sirena.org.uk>
References: <1408350762-15520-1-git-send-email-javier.martinez@collabora.co.uk>
 <1408350762-15520-2-git-send-email-javier.martinez@collabora.co.uk>
 <CA+NduCDL65=Y=PyU3FfXsTz0FfbmYzicGrY4U7ji3_V+nXhtCQ@mail.gmail.com>
 <53F73472.8010609@collabora.co.uk> <20140822144531.GV24407@sirena.org.uk>
 <53F7838F.8060906@collabora.co.uk> <20140822183054.GY24407@sirena.org.uk>
Message-ID: <53F7BDD8.7060500@collabora.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Mark,

On 08/22/2014 08:30 PM, Mark Brown wrote:
> 
>> The problem is that one of these regulators is used as the vqmmc-supply
>> (VCCQ/VDD_IO) so the mmc host controller driver disables it on
>> MMC_POWER_OFF. Now AFAIK (Yuvaraj can correct me what I got wrong) this
>> shouldn't be an issue since on card detection, the vqmmc supply should be
>> enabled again but on Exynos the built-in card detect line is on the same
>> power rail as vqmmc. That means that disabling the regulator prevents card
>> insertions to be detected.
> 
> If the MMC host controller needs a supply enabling in order to do card
> detection and it's supposed to be doing card detection I'd expect it to
> be enabling that supply.  Why is it not doing that?
> 

Good question. I'm not that familiar with the dw_mmc host controller nor
its driver implementation so I'll let Yuvaraj or Doug to answer that.

Best regards,
Javier
