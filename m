From: patrice.chotard@st.com (Patrice Chotard)
Date: Wed, 14 Sep 2016 16:04:25 +0200
Subject: [PATCH 00/19] [RESEND] Remove STiH415 and STiH416 SoC platform
 support
In-Reply-To: <7524458.uFhxDUCqEo@wuerfel>
References: <1473859677-9231-1-git-send-email-peter.griffin@linaro.org>
 <7524458.uFhxDUCqEo@wuerfel>
Message-ID: <e99dc16c-2622-e16b-cb6b-bce3fdb33e29@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Peter, Arnd

On 09/14/2016 03:38 PM, Arnd Bergmann wrote:
> On Wednesday, September 14, 2016 2:27:38 PM CEST Peter Griffin wrote:
>> Resending due to incorrect Cc tags.
>>
>> ST have sent patches which remove clock support for these SoCs [1]
>> which once applied mean the platform will no longer boot.
>>
>> This series cleans up various STi platform drivers which have
>> support for these SoC's, by removing code, and updating the DT
>> documentation accordingly. Some drivers such as miphy365 and
>> stih41x-usb can be removed completely because the IP is only
>> found on these legacy SoC's.
>>
>> Once this series is applied, drm display driver, and ALSA SoC
>> are the main two remaining references to the legacy SoCs, other
>> than clocks which already have patches on the ML.
> 
> It would be good to have a better explanation that "it's already
> broken by some other commit". Is this a platform that never shipped
> to end-users, or is it possible that someone out there actually
> has a machine with one of these SoCs?

This series is prematured as today STiH415/416 is not broken by any commit.

This series is depending on the merge of a ST's clock series not yet upstreamed.
(see https://patchwork.kernel.org/patch/9157571/)

STMicroelectronics expect to remove STiH415/416 in a near future from upstream kernel.

Patrice


> 
> 	Arnd
> 
