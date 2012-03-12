From: myungjoo.ham@samsung.com (MyungJoo Ham)
Date: Mon, 12 Mar 2012 17:06:23 +0900
Subject: [PATCH v6 1/5] Extcon (external connector): import Android's
 switch class and modify.
In-Reply-To: <20120309124119.GV3273@opensource.wolfsonmicro.com>
References: <1328856038-21912-1-git-send-email-myungjoo.ham@samsung.com>
 <1330344939-18394-1-git-send-email-myungjoo.ham@samsung.com>
 <1330344939-18394-2-git-send-email-myungjoo.ham@samsung.com>
 <20120309124119.GV3273@opensource.wolfsonmicro.com>
Message-ID: <CAJ0PZbTnKf2VA-OCyVjEC7kf7mnqt04UDjDw-zqi8f7J6yJUiA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Mar 9, 2012 at 9:41 PM, Mark Brown
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

Yes, this was the itching part.

I'll first look into creating symlinks (either /sys/class/switch -->
/sys/class/extcon or /sys/class/switch/* --> /sys/class/extcon/*).
However, I think this symbolic links are better created selectively w/
CONFIG_ANDROID.

Thanks.


Cheers!
MyungJoo.

-- 
MyungJoo Ham, Ph.D.
Mobile Software Platform Lab, DMC Business, Samsung Electronics
