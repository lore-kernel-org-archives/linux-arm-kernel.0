From: t.figa@samsung.com (Tomasz Figa)
Date: Fri, 13 Jun 2014 16:59:55 +0200
Subject: [PATCH 0/5] Handle non-secure L2C initialization on Exynos4
In-Reply-To: <CAD8Lp46MbKZrCAMp+9T9LbWTB4uHRDdivhtjoQbkTyBbK48EgQ@mail.gmail.com>
References: <CAD8Lp46MbKZrCAMp+9T9LbWTB4uHRDdivhtjoQbkTyBbK48EgQ@mail.gmail.com>
Message-ID: <539B11EB.6010304@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Daniel,

I have attached, three patches which make the kernel boot fine with L2
cache enabled on ODROID-U3. Could you test them on your setup to verify
that they indeed fix the issue?

Best regards,
Tomasz

On 12.06.2014 15:38, Daniel Drake wrote:
> Hi Tomasz,
> 
> Thanks for working on this!
> 
> I have just tried this, against Linus master
> 64b2d1fbbfda07765dae3f601862796a61b2c451.
> Added patch "ARM: dts: Initial ODROID U2 support" and booted on
> ODROID-U2. I believe this board has the security enabled.
> 
> Unfortunately, it hangs during early boot. With earlyprintk the last
> messages seen are:
> 
> L2C: platform modifies aux control register: 0x02070000 -> 0x3e470001
> L2C: platform provided aux values permit register corruption.
> L2C: DT/platform modifies aux control register: 0x02070000 -> 0x3e470001
> L2C-310 enabling early BRESP for Cortex-A9
> L2C-310: enabling full line of zeros but not enabled in Cortex-A9
> L2C-310 ID prefetch enabled, offset 1 lines
> L2C-310 dynamic clock gating enabled, standby mode enabled
> L2C-310 cache controller enabled, 16 ways, 1024 kB
> L2C-310: CACHE_ID 0x4100c4c8, AUX_CTRL 0x7e470001
> 
> I then tried to go back to the earlier patch "ARM: EXYNOS: Add secure
> firmware support for l2x0 init" (attached, needed a rebase) but that
> one also now hangs at:
> 
> L2C: platform modifies aux control register: 0x02070000 -> 0x3e470001
> 
> It did work on 3.14 though. Looking at the changelogs, many changes
> have been made to l2x0 recently. Can you confirm that you have tested
> your patches against a kernel with all of Russell King's recent
> changes?
> 
> Thanks
> Daniel
> 
-------------- next part --------------
A non-text attachment was scrubbed...
Name: 0001-ARM-EXYNOS-Invalidate-L2-cache-with-SMC-command-befo.patch
Type: text/x-patch
Size: 818 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140613/1b789d7b/attachment.bin>
-------------- next part --------------
A non-text attachment was scrubbed...
Name: 0002-ARM-mm-l2x0-Add-support-for-overriding-prefetch-sett.patch
Type: text/x-patch
Size: 3544 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140613/1b789d7b/attachment-0001.bin>
-------------- next part --------------
A non-text attachment was scrubbed...
Name: 0003-ARM-dts-exynos4x12-Override-prefetch-settings.patch
Type: text/x-patch
Size: 860 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140613/1b789d7b/attachment-0002.bin>
