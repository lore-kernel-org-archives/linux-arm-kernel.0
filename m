From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Mon, 28 Aug 2017 21:01:13 +0100
Subject: ARM64 kernel Image size limitations?
In-Reply-To: <02d56481-bba0-fd32-17d8-9f3760d09148@gmail.com>
References: <02d56481-bba0-fd32-17d8-9f3760d09148@gmail.com>
Message-ID: <CAKv+Gu-b1+dZaw=Sbnqd3NnpZ4G7Q5Gog7o=3Wucn69neChyNA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On 28 August 2017 at 20:55, Florian Fainelli <f.fainelli@gmail.com> wrote:
> Hi,
>
> I have been fighting with a reasonably large kernel Image: 46MB and
> found unable to boot it. This is on v4.13-rc6, but I could go back as
> far as v4.9~ish. It is so big, because it's got some debugging enabled,
> and the initramfs compression is disabled, but still that ought to be
> possible.
>
> After some experimentation I found that the breaking size is somewhere
> around 33MB total for arch/arm64/boot/Image and when that happens, I get
> the following backtrace which suggests that there is some memory
> corruption of some kind (or so it seems to me), other experiments
> indicated that the backtrace may point back to where the bootloader had
> set up its exception vector. I am fairly confident that the bootloader
> is not responsible for corrupting the Image that is loaded.
>
> Is there such a size limitation or am I possibly tripping over something
> else?
>

What boot environment are you using? Is it possible the DTB is copied
on top of the kernel by the boot loader?
