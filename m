From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Sat, 23 May 2015 10:28:20 +0200
Subject: [PATCH v8 14/16] ARM: dts: Introduce STM32F429 MCU
In-Reply-To: <CALszF6BuvTf86k6S5UEYZs-DJSTehy=+Csb3c6jxMU90MN05zw@mail.gmail.com>
References: <1431158038-3813-1-git-send-email-mcoquelin.stm32@gmail.com>
 <2282066.NWoIT9ZyLc@wuerfel>
 <CALszF6CaO_yuNiSDuDV+4d2NRe_+32j=zcSE1HPhB1UH59cW9w@mail.gmail.com>
 <13641152.Yt4ZI3oT6L@wuerfel>
 <CALszF6CK5ezrO6D=4zr6zEPC7VanzbQjnZJwKOZekEZ5L4D-Dg@mail.gmail.com>
 <20150521185122.GD8557@lukather>
 <CALszF6BuvTf86k6S5UEYZs-DJSTehy=+Csb3c6jxMU90MN05zw@mail.gmail.com>
Message-ID: <20150523082820.GK8557@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Maxime,

On Thu, May 21, 2015 at 10:10:35PM +0200, Maxime Coquelin wrote:
> > The only thing we did that stands out a bit is that we actually need
> > the reset driver much earlier than the default probe, since some of
> > our timers are maintained in reset. We have some code to do just that
> > already, we just need have something similar to be on board.
> 
> We have the same problem on stm32, as just discussed with Andreas [0].
> I decided to patch the bootloader to deassert timers reset, after
> discussions with Rob Herring and Arnd.

That seems like the best solution, but we don't have control over the
bootloader in most cases. We have an alternative implementation (ie
mainline u-boot) that is required for a few things already, but I'd
really like to still be able to at least boot the kernel on a "legacy"
bootloader (that is the one flashed on the device).

Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150523/f4e4f7d0/attachment.sig>
