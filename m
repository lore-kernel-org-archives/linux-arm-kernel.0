From: swarren@wwwdotorg.org (Stephen Warren)
Date: Tue, 22 Nov 2016 15:27:35 -0700
Subject: [RFC PATCH 04/11] PCI: tegra: limit to MMU build only
In-Reply-To: <4182371.efWsDqfOeS@wuerfel>
References: <1479806768-39911-1-git-send-email-vladimir.murzin@arm.com>
 <1479806768-39911-5-git-send-email-vladimir.murzin@arm.com>
 <65053923-c783-d8d9-d594-aa18cbed413e@wwwdotorg.org>
 <4182371.efWsDqfOeS@wuerfel>
Message-ID: <d9fd3fab-d648-0664-bd73-994bebf36bf4@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/22/2016 02:16 PM, Arnd Bergmann wrote:
> On Tuesday, November 22, 2016 9:15:13 AM CET Stephen Warren wrote:
>> On 11/22/2016 02:26 AM, Vladimir Murzin wrote:
>>> This driver uses functionality which available for MMU build only,
>>> thus add dependency on MMU.
>>
>> I'd expect ARCH_TEGRA to depend on MMU instead.
>>
>
> Any particular reason for why we'd single out Tegra?

 From the cover letter, it sounded like the point of the series was to 
all !MMU builds for a bunch of SoCs with M-class cores. Tegra doesn't 
have an M-class core so I wouldn't expect it to be included in such a 
build. I'd expect the same fix that I suggested to apply to all 
non-M-class SoCs, rather than fixing up individual drivers to depend on 
!MMU.
