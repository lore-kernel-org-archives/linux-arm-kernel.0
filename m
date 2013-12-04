From: ldewangan@nvidia.com (Laxman Dewangan)
Date: Wed, 4 Dec 2013 11:19:48 +0530
Subject: [PATCH 1/2] ARM: dts: tegra: Header file for pinctrl constants
In-Reply-To: <529E3A34.4030206@wwwdotorg.org>
References: <1385992502-12771-1-git-send-email-ldewangan@nvidia.com>
 <20131202142522.GA17566@ulmo.nvidia.com> <529D745D.2070503@nvidia.com>
 <529E3A34.4030206@wwwdotorg.org>
Message-ID: <529EC27C.6030003@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 04 December 2013 01:38 AM, Stephen Warren wrote:
> On 12/02/2013 11:04 PM, Laxman Dewangan wrote:
>> On Monday 02 December 2013 07:55 PM, Thierry Reding wrote:
>>> * PGP Signed by an unknown key
>>>
>>> On Mon, Dec 02, 2013 at 07:25:01PM +0530, Laxman Dewangan wrote:
>>>
>>> +
>>> +/* Schmitt enable/disable */
>>> +#define TEGRA_PIN_DRIVE_SCHMITT_DISABLE            0
>>> +#define TEGRA_PIN_DRIVE_SCHMITT_ENABLE            1
>>> These are all boolean, so I wonder if perhaps we should be simply
>>> defining a single pair and reuse that in different contexts:
>>>
>>>      #define TEGRA_PIN_DISABLE    0
>>>      #define TEGRA_PIN_ENABLE    1
>>>
>>> The property names should provide enough context for them to be used
>>> unambiguously.
>>>
>>>
>> I can make generic ENABLE/DISABLE macro as you suggested but datasheet
>> says as 0=NORMAL, 1 = TRISTATE. and that's why I kept name very near to
>> the datasheet.
> That documentation is relative to a specific field, whereas the
> namespace for #defines is global. Hence, we may have to name #defines
> using stricter rules than the TRM's field values, in order to make them
> unambiguous.

I send the V2 patches on which I have taken care of this.
Request you to please review.

Thanks,
Laxman
