From: arve@android.com (=?ISO-8859-1?Q?Arve_Hj=F8nnev=E5g?=)
Date: Thu, 9 Dec 2010 14:01:49 -0800
Subject: [PATCH] msm: trout: add keypad support
In-Reply-To: <1291916733.18827.1.camel@c-dwalke-linux.qualcomm.com>
References: <1291854285-29566-1-git-send-email-dwalker@codeaurora.org>
	<4D00800E.7050004@codeaurora.org>
	<1291916733.18827.1.camel@c-dwalke-linux.qualcomm.com>
Message-ID: <AANLkTi=3LHHNJUh35AUkq--KtRCnRaBHx8Ky2bhxxzE4@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Dec 9, 2010 at 9:45 AM, Daniel Walker <dwalker@codeaurora.org> wrote:
> On Thu, 2010-12-09 at 12:36 +0530, Trilok Soni wrote:
>
>> > +static char *keycaps = "--qwerty";
>> > +#undef MODULE_PARAM_PREFIX
>> > +#define MODULE_PARAM_PREFIX "board_trout."
>> > +module_param_named(keycaps, keycaps, charp, 0);
>>
>> I would like to know what is the use of this param?
>
> No idea .. It was part of Google's implementation ..
>

You removed the code that uses it. If you look at the original file
you can see how it is used:
http://android.git.kernel.org/?p=kernel/msm.git;a=blob;f=arch/arm/mach-msm/board-trout-keypad.c;hb=refs/heads/android-msm-2.6.35
It is set by the bootloader according to the hardware version.

You can also see that the "/* userspace needs to know about these
changes as well */" comments refer to the code that changes the name
of the input device.

I don't think this change will work correctly with our existing
user-space code though since you are now reporting the power-key,
camera-key and slide-switch from a separate input device.

-- 
Arve Hj?nnev?g
