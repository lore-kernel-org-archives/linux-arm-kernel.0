From: ykk@rock-chips.com (Yakir Yang)
Date: Tue, 29 Mar 2016 19:45:16 +0800
Subject: [RFC PATCH v1 0/4] Add Rockchip RGA support
In-Reply-To: <56F11D46.8080208@suse.de>
References: <1458552518-25527-1-git-send-email-ykk@rock-chips.com>
 <1511371.I0NIYzh3kP@diego> <56EFE66A.8020404@rock-chips.com>
 <56F11D46.8080208@suse.de>
Message-ID: <56FA6ACC.5080202@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Andreas,

On 03/22/2016 06:24 PM, Andreas F?rber wrote:
> Hi Yakir,
>
> Am 21.03.2016 um 13:17 schrieb Yakir Yang:
>> On 03/21/2016 07:29 PM, Heiko St?bner wrote:
>>> Am Montag, 21. M?rz 2016, 17:28:38 schrieb Yakir Yang:
>>>> This patch set would add the RGA direct rendering based 2d graphics
>>>> acceleration module.
>>> very cool to see that.
>> ;)
>>>> This patch set is based on git repository below:
>>>> git://people.freedesktop.org/~airlied/linux drm-next
>>>> commit id: 568d7c764ae01f3706085ac8f0d8a8ac7e826bd7
>>>>
>>>> And the RGA driver is based on Exynos G2D driver, it only manages the
>>>> command lists received from user, so user should make the command list
>>>> to data and registers needed by operation to use.
>>>>
>>>> I have prepared an userspace demo application for testing:
>>>>      https://github.com/yakir-Yang/libdrm-rockchip
>>>> That is a rockchip libdrm library, and I have write a simple test case
>>>> "rockchip_rga_test" that would test the below RGA features:
>>>> - solid
>>>> - copy
>>>> - rotation
>>>> - flip
>>>> - window clip
>>>> - dithering
>>> Did you submit your libdrm changes as well?
>>>
>>> Userspace-interfaces need to be stable so the other side must also get
>>> accepted - even before the kernel change if I remember correctly.
>> Got it, and I just saw exynos_fimg2d already landed at mainline libdrm.
>> But I don't find the way to submit patches to libdrm, would you like
>> share some helps here ;)
> If you're using Exynos as an example, please keep in mind that the
> libdrm license is MIT/X11, not GPL as the kernel. For our Linux distro
> we had to disable some Exynos parts because they snuck some GPL code in
> there and redistributing libdrm under GPL would cause a big headache
> (review of all packages directly or indirectly linking against it).

Hmmm... I just saw exynos_drm.h still declared the GNU license,
is it convince for you to share some specific example here ;)

Thanks,
- Yakir
> Thanks,
> Andreas
>
