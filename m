From: carlo@caione.org (Carlo Caione)
Date: Mon, 14 Dec 2015 10:13:55 +0100
Subject: [PATCH 1/2] mmc: core: enable CMD19 tuning for DDR50 mode
In-Reply-To: <edf24ca1a9614943b55b8d19745a3c45@aptaiexm02f.ap.qualcomm.com>
References: <1439282492-6274-1-git-send-email-21cnbao@gmail.com>
 <CAPDyKFpXZD28NwNAhKQyxmWasVhk_7AeyOW6oXaBPHKuSTmGUA@mail.gmail.com>
 <CAGsJ_4wvvQdyjFi=JmWfASm-LbJMybrhC=Wxxn7jHZEP5dUfEw@mail.gmail.com>
 <CAPDyKFpEwWvu3tnbMT9ZvM0TUvEHp0Qa8PADohyJoTaNZ9HS9g@mail.gmail.com>
 <CAGsJ_4x5Nd3Cts1BHsUyB_mCejxbHPPjznUVWUcFoZhxKy+Tcg@mail.gmail.com>
 <CAPDyKFpWfY9G4WG_GfCutJ2NkRbcAYZToYJXp3RvX=_25sgnWA@mail.gmail.com>
 <CAGsJ_4zaWcmGsc82=LSohK0UHxJir2OJOBSgoU3sPRXYvLdOZQ@mail.gmail.com>
 <CAPDyKFrj7mfxYPotHfpYPVf8M=Mvjcz+HfuB871EZNv9FWpPqw@mail.gmail.com>
 <CAOQ7t2YuSDwtK0R3R4++3LUPyEqW+ENLju63QisX6tO=-cvt6w@mail.gmail.com>
 <edf24ca1a9614943b55b8d19745a3c45@aptaiexm02f.ap.qualcomm.com>
Message-ID: <CAOQ7t2YOd9TtAHHUBhF4n_POQURhfaqC_9Tg-b8d1Bf2QCyoYA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Dec 14, 2015 at 9:46 AM, Yang, York <weijuny@qti.qualcomm.com> wrote:
> Hi, Carlo
>         In 9faac7b95, tuning for DDR50 is enabled in mmc_sd_init_uhs_card(), so only SD card is affected.
>         This is based on the SD spec version 3.01.
>         mmc_sdio_init_uhs_card() is untouched. I don't know who add the code into mmc_sdio_init_uhs_card() and you may have a check on your side.

Hi Yang,
sorry for not being clear. Modifying mmc_sdio_init_uhs_card() was only
a test I did to check whether that could fix the issue, but it didn't.

Right now the situation is:
- In the latest master with commit 9faac7b95 WiFi is broken on the
ASUS X205TA (bcm43341)
- Reverting 9faac7b95 makes it working fine again

My conclusion is that issuing the CMD19 is basically breaking WiFi on
this platform.

-- 
Carlo Caione
