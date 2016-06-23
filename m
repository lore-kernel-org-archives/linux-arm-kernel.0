From: robh@kernel.org (Rob Herring)
Date: Wed, 22 Jun 2016 22:20:48 -0500
Subject: [PATCH] config: Add android config fragments
In-Reply-To: <CAMi1Hd3VDnK+yA6tXLFELCqnnrsPtPHnmov9O9MpJuBpfkcC=w@mail.gmail.com>
References: <1465403951-32454-1-git-send-email-robh@kernel.org>
 <CAMi1Hd3VDnK+yA6tXLFELCqnnrsPtPHnmov9O9MpJuBpfkcC=w@mail.gmail.com>
Message-ID: <CAL_JsqJQsTX8SJY_inC9dFhNsujbzV+5kNdvHEvn-8+7u3XfyA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 22, 2016 at 2:53 AM, Amit Pundir <amit.pundir@linaro.org> wrote:
> On 8 June 2016 at 22:09, Rob Herring <robh@kernel.org> wrote:
>> Copy the config fragments from the AOSP common kernel tree. It is
>> becoming possible to run mainline kernels with Android, but the kernel
>> defconfigs don't work as-is and debugging missing config options is a
>> pain. Adding the config fragments into the kernel tree, makes
>> configuring a mainline kernel as simple as:
>>
>> make ARCH=arm multi_v7_defconfig android-base.config android-recommended.config
>>
>> Cc: Amit Pundir <amit.pundir@linaro.org>
>> Cc: John Stultz <john.stultz@linaro.org>
>> Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>
>> Cc: Rom Lemarchand <romlem@android.com>
>> Signed-off-by: Rob Herring <robh@kernel.org>
>> ---
>>  kernel/configs/android-base.config        | 161 ++++++++++++++++++++++++++++++
>>  kernel/configs/android-recommended.config | 121 ++++++++++++++++++++++

[...]

>> +CONFIG_STAGING=y
>> +CONFIG_SWITCH=y
>
> Switch Class support is dropped from kernel/common/android-4.4 sometime back.

Okay. I'm also removing these options in v2 which don't exist in
upstream. Any comments on them?

IP6_NF_TARGET_REJECT_SKERR
IP_NF_TARGET_REJECT_SKERR
NETFILTER_XT_MATCH_QTAGUID
NETFILTER_XT_MATCH_QUOTA2
NETFILTER_XT_MATCH_QUOTA2_LOG
PPPOLAC
PPPOPNS
RESOURCE_COUNTERS
SECURITY_PERF_EVENTS_RESTRICT
USB_CONFIGFS_F_MTP
USB_CONFIGFS_F_PTP
USB_CONFIGFS_F_ACC
USB_CONFIGFS_F_AUDIO_SRC
USB_CONFIGFS_UEVENT
USB_OTG_WAKELOCK
ANDROID_TIMED_GPIO
ARM_KERNMEM_PERMS
INPUT_KEYCHORD
INPUT_KEYRESET
TABLET_USB_WACOM

Rob
