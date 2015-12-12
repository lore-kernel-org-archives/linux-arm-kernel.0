From: carlo@caione.org (Carlo Caione)
Date: Sun, 13 Dec 2015 00:51:38 +0100
Subject: [PATCH 1/2] mmc: core: enable CMD19 tuning for DDR50 mode
In-Reply-To: <CAPDyKFrj7mfxYPotHfpYPVf8M=Mvjcz+HfuB871EZNv9FWpPqw@mail.gmail.com>
References: <1439282492-6274-1-git-send-email-21cnbao@gmail.com>
 <CAPDyKFpXZD28NwNAhKQyxmWasVhk_7AeyOW6oXaBPHKuSTmGUA@mail.gmail.com>
 <CAGsJ_4wvvQdyjFi=JmWfASm-LbJMybrhC=Wxxn7jHZEP5dUfEw@mail.gmail.com>
 <CAPDyKFpEwWvu3tnbMT9ZvM0TUvEHp0Qa8PADohyJoTaNZ9HS9g@mail.gmail.com>
 <CAGsJ_4x5Nd3Cts1BHsUyB_mCejxbHPPjznUVWUcFoZhxKy+Tcg@mail.gmail.com>
 <CAPDyKFpWfY9G4WG_GfCutJ2NkRbcAYZToYJXp3RvX=_25sgnWA@mail.gmail.com>
 <CAGsJ_4zaWcmGsc82=LSohK0UHxJir2OJOBSgoU3sPRXYvLdOZQ@mail.gmail.com>
 <CAPDyKFrj7mfxYPotHfpYPVf8M=Mvjcz+HfuB871EZNv9FWpPqw@mail.gmail.com>
Message-ID: <CAOQ7t2YuSDwtK0R3R4++3LUPyEqW+ENLju63QisX6tO=-cvt6w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Sep 23, 2015 at 9:25 PM, Ulf Hansson <ulf.hansson@linaro.org> wrote:
> [...]
>
>>>
>>> Also, I was giving this a second thought...
>>>
>>> What happens with the SD 3.0 card when it *doesn't* support CMD19.
>>> Will it still be functional afterwards or will it move from "transfer
>>> state" to another not known state?
>>
>> uffe, i am not the expert of this issue but weijun is. weijun told that
>> for the cards who don't support cmd19, it will take it as illegal
>> command and not response it. and it also sets illegal command error in
>> registers.
>> but the card status is still functional and doesn't cause unknown state.
>>
>> so maybe we can just ignore the err of tuning, and use the second
>> patch with the refine you mentioned?
>
> Sure, let's do that. Please send a v2 of the patchset then.

Replying here since I'm not subscribed to linux-mmc.

Commit 9faac7b95 "mmc: sdhci: enable tuning for DDR50" actually breaks
WiFi on SDIO at least for the ASUS X205TA.

I tried to ignore the error from the tuning also for the SDIO card
patching mmc_sdio_init_uhs_card() in drivers/mmc/core/sdio.c but I end
up with the error "Controller never released inhibit bit(s)". At least
in my case CMD19 shouldn't be issued at all to have the SDIO card
working.

Any suggestion how to approach this problem?

-- 
Carlo Caione
