From: pantelis.antoniou@konsulko.com (Pantelis Antoniou)
Date: Mon, 25 May 2015 19:51:45 +0300
Subject: [PATCH v5 00/11] Add simple NVMEM Framework via regmap.
In-Reply-To: <1432226535-8640-1-git-send-email-srinivas.kandagatla@linaro.org>
References: <1427752492-17039-1-git-send-email-srinivas.kandagatla@linaro.org>
 <1432226535-8640-1-git-send-email-srinivas.kandagatla@linaro.org>
Message-ID: <E5772084-6CF5-41DE-B68B-073D9F75F0BC@konsulko.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Srinivas,

> On May 21, 2015, at 19:42 , Srinivas Kandagatla <srinivas.kandagatla@linaro.org> wrote:
> 
> Thankyou all for providing inputs and comments on previous versions of this patchset.
> Here is the v5 of the patchset addressing all the issues raised as
> part of previous versions review.
> 

> 

[snip]

I tried to use the updated patchset with my at24 & beaglebone capemanager patches.

I have a big problem with the removal of the raw of_* access APIs.

Take for instance the case where you have multiple slot accessing different EEPROMs.

> slots {
> 	slot at 0 {
> 		eeprom = <&cape0_data>;
> 	};
> 
> 	slot at 1 {
> 		eeprom = <&cape1_data>;
> 	};
> };

In that case there is no per-device node mapping; it?s a per-sub node.

For now I?m exporting the of_* accessors again, please consider exposing the of_* API again.

> -- 
> 1.9.1
> 

Regards

? Pantelis
