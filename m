From: martinez.javier@gmail.com (Javier Martinez Canillas)
Date: Fri, 14 Dec 2012 19:16:31 +0100
Subject: [PATCH 1/1] ARM: OMAP2+: enable devtmpfs and devtmpfs automount
In-Reply-To: <20121214181051.GY4989@atomide.com>
References: <1353504411-19811-1-git-send-email-javier.martinez@collabora.co.uk>
 <20121214181051.GY4989@atomide.com>
Message-ID: <CAAwP0s1d4xPfYyaU+Cu=fH6YL5gmyYF+6x0aHOmNVeHshZ1ZeA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Dec 14, 2012 at 7:10 PM, Tony Lindgren <tony@atomide.com> wrote:
> * Javier Martinez Canillas <javier.martinez@collabora.co.uk> [121121 05:29]:
>> Since udev-182, udev no longer creates device nodes under /dev
>> and this has to be managed by the kernel devtmpfs filesystem.
>>
>> This means that a kernel built with the current OMAP2+ config
>> will not boot on a system with a recent udev.
>>
>> Also, it is good to have /dev automatically mounted since some
>> non-initramfs based setups assumes this and don't manually mount it.
>
> Thanks applying into omap-for-v3.8/fixes-for-merge-window.
>
> Regards,
>
> Tony
>

Hi Tony,

I resend a v2 today: [PATCH v2 1/1] ARM: OMAP2+: omap2plus_defconfig:
enable devtmpfs and automount

That fixes an issue in the patch comments. Sekar Nori pointed out that
the first udev to make this a requirement was 176 not 182.
So probably is better if you can apply that one instead.

Thanks a lot and best regards,
Javier
