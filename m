From: javier@dowhile0.org (Javier Martinez Canillas)
Date: Mon, 16 Mar 2015 09:32:42 +0100
Subject: [PATCH] ARM: sunxi: DT: Add stdout-path property
In-Reply-To: <55068E7C.4060400@redhat.com>
References: <1426448851-32204-1-git-send-email-maxime.ripard@free-electrons.com>
 <55068E7C.4060400@redhat.com>
Message-ID: <CABxcv=kpGpZPUJ855eD5m033u4=t-8=fX6iLWkKudUTf2R7-tA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Hans,

On Mon, Mar 16, 2015 at 9:04 AM, Hans de Goede <hdegoede@redhat.com> wrote:
> Hi,
>
> On 15-03-15 20:47, Maxime Ripard wrote:
>>
>> Add UART aliases and stdout-path property for all the Allwinner boards so
>> that
>> we won't have to rely on the bootargs' console= value, while working with
>> legacy bootloaders.
>>
>> While we're at it, also remove the mentions of earlyprintk in the
>> bootargs,
>> that will remove our default bootargs entirely, and allow the kernel to
>> boot on
>> a system even if DEBUG_LL is configured for another system.
>>
>> Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
>
>
> Erm, AFAIK stdout-path does not support aliases so you must put full paths
> in there, see:
>
> http://git.denx.de/?p=u-boot.git;a=commitdiff;h=f3133962f469a8b6b9ba237ba670f0ca7c88a02e
>

I'm pretty sure it does now, at least I'm using it on an exynos5 board
and OF_STDOUT_PATH is not defined in u-boot.

I believe the issue you are referring too got fix by commit
7dbe5849fb50 ("of: make sure of_alias is initialized before accessing
it").

Best regards,
Javier
