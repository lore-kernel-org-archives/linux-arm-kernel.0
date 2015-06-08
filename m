From: gnurou@gmail.com (Alexandre Courbot)
Date: Mon, 8 Jun 2015 11:09:42 +0900
Subject: [PATCH/RFC 1/2] ARM: multi_v7_defconfig: Make drm support modular
In-Reply-To: <20150605113949.GA26607@ulmo.nvidia.com>
References: <1432905926-31606-1-git-send-email-geert@linux-m68k.org>
 <2568731.dqdEiMuDro@wuerfel> <20150605113949.GA26607@ulmo.nvidia.com>
Message-ID: <CAAVeFuJqcye_MRoJ7vLwnyB0B1ZhEnY2Y8ZV3N50LhBV3gc4Jg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jun 5, 2015 at 8:39 PM, Thierry Reding <thierry.reding@gmail.com> wrote:
> On Fri, May 29, 2015 at 05:41:34PM +0200, Arnd Bergmann wrote:
>> On Friday 29 May 2015 15:25:25 Geert Uytterhoeven wrote:
>> > From: Geert Uytterhoeven <geert+renesas@glider.be>
>> >
>> > Make drm support modular to reduce kernel size (-620 KiB):
>> >
>> >        text    data     bss     dec     hex   filename
>> >     12211122 1392076  338520 13941718  d4bbd6 vmlinux.before
>> >     11581470 1387196  338264 13306930  cb0c32 vmlinux.after
>> >
>> > Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
>> > ---
>> > Slightly controversial:
>> >   - Does anyone need drm for boot testing?
>>
>> Only the tegra driver is affected, so let's ask the tegra
>> maintainers.
>
> As a matter of fact I do most of the DRM testing on boot using the
> built-in driver. However I can do that easily using tegra_defconfig so
> I'm fine with this change.
>
> Acked-by: Thierry Reding <treding@nvidia.com>

Looks good to me to, Nouveau works better as a module anyway. :)

Acked-by: Alexandre Courbot <acourbot@nvidia.com>
