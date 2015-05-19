From: prabhakar.csengg@gmail.com (Lad, Prabhakar)
Date: Tue, 19 May 2015 17:46:55 +0100
Subject: [PATCH] [media] ov2659: add v4l2_subdev dependency
In-Reply-To: <6092911.yr0lA5IaG4@wuerfel>
References: <6092911.yr0lA5IaG4@wuerfel>
Message-ID: <CA+V-a8tPSmRgNphN_CRjcsuL0xssDQ+3Oxne_mb=DQgs60ab8g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd,

Thanks for the patch.

On Tue, May 19, 2015 at 1:39 PM, Arnd Bergmann <arnd@arndb.de> wrote:
> The newly added ov2659 driver uses the v4l2 subdev API, but
> can be enabled even when that API is not part of the kernel,
> resulting in this build error:
>
> media/i2c/ov2659.c: In function 'ov2659_get_fmt':
> media/i2c/ov2659.c:1054:8: error: implicit declaration of function 'v4l2_subdev_get_try_format' [-Werror=implicit-function-declaration]
> media/i2c/ov2659.c:1054:6: warning: assignment makes pointer from integer without a cast [-Wint-conversion]
> media/i2c/ov2659.c: In function 'ov2659_set_fmt':
> media/i2c/ov2659.c:1129:6: warning: assignment makes pointer from integer without a cast [-Wint-conversion]
> media/i2c/ov2659.c: In function 'ov2659_open':
> media/i2c/ov2659.c:1264:38: error: 'struct v4l2_subdev_fh' has no member named 'pad'
>
> This adds an explicit dependency, like all the other drivers have.
>
Patch fixing the above issue is already posted in the ML [1].

[1] https://patchwork.linuxtv.org/patch/29665/

Cheers,
--Prabhakar Lad
