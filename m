From: abrestic@chromium.org (Andrew Bresticker)
Date: Mon, 9 Jun 2014 13:05:17 -0700
Subject: [PATCH v2] ARM: EXYNOS: mcpm: Don't rely on firmware's
 secondary_cpu_start
In-Reply-To: <7htx7uq7k1.fsf@paris.lan>
References: <1402090985-8061-1-git-send-email-dianders@chromium.org>
 <1402096465-13218-1-git-send-email-dianders@chromium.org>
 <7htx7uq7k1.fsf@paris.lan>
Message-ID: <CAL1qeaGv+hBCr8oqs-E2j_Qh0Z=ZTVEaM-gdyu286Snu4otbMA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> [1] While waiting for the forth-coming patch from Andrew to enable the
>     CCI port for the boot cluster), I do this from u-boot before starting
>     the kernel (based on earlier email from Doug):
>
>     mw.l 10d25000 3  # Enable CCI from U-Boot

>From the other thread, it sounds like Nicolas wants enabling of the
boot cluster's CCI port to be done unconditionally for all MCPM
platforms.  Nicolas, are you preparing a patch for this or should I?
The only issue I see with making the MCPM loopback generic is that
although all current mainline MCPM platforms have the same cache flush
procedure, a future platform could be different.

Thanks,
Andrew
