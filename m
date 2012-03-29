From: konkers@google.com (Erik Gilling)
Date: Thu, 29 Mar 2012 15:27:01 -0700
Subject: [PATCH v6 1/5] Extcon (external connector): import Android's
 switch class and modify.
In-Reply-To: <20120309124119.GV3273@opensource.wolfsonmicro.com>
References: <1328856038-21912-1-git-send-email-myungjoo.ham@samsung.com>
 <1330344939-18394-1-git-send-email-myungjoo.ham@samsung.com>
 <1330344939-18394-2-git-send-email-myungjoo.ham@samsung.com>
 <20120309124119.GV3273@opensource.wolfsonmicro.com>
Message-ID: <CACSP8ShU5tu=9N53PtYMLyFVFMS9whNRhMvu7nu8rBoPuVCy+Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Mar 9, 2012 at 4:41 AM, Mark Brown
<broonie@opensource.wolfsonmicro.com> wrote:
> On Mon, Feb 27, 2012 at 09:15:35PM +0900, MyungJoo Ham wrote:
>
>> +#ifdef CONFIG_ANDROID
>> + ? ? ? ? ? ? extcon_class = class_create(THIS_MODULE, "switch");
>> +#else /* !CONFIG_ANDROID */
>> + ? ? ? ? ? ? extcon_class = class_create(THIS_MODULE, "extcon");
>> +#endif /* CONFIG_ANDROID */
>
> This seems somewhat sad - if ANDROID is turned on the standard ABI
> vanishes. ?It'd be much nicer to do this with a symlink (or with
> symlinks within the android directory if the driver core doesn't support
> that). ?That way userspace code can be written to the new ABI and will
> work on Android systems without ifdefery.

This won't work if userspace code is receiving uevents through netlink
and comparing based on the device name which it does in android.  Why
change the name at all?  Extcon is much more specific than "switch."
A switch can can be used for more than just external connections such
as availability of HMDI audio (which is only available once a HDMI
mode is chosen and the interface is enabled.)

-Erik
