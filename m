From: pali.rohar@gmail.com (Pali =?utf-8?q?Roh=C3=A1r?=)
Date: Wed, 28 Jan 2015 18:18:12 +0100
Subject: [PATCH] ARM: /proc/atags: Export also for DT
In-Reply-To: <CAL_Jsq+rESm8q44ABRbh9hqMsfcMNx0kcXJ5ONbn1=ue-RvHFg@mail.gmail.com>
References: <1403110464-29646-1-git-send-email-pali.rohar@gmail.com>
 <alpine.LFD.2.11.1501280925400.1322@knanqh.ubzr>
 <CAL_Jsq+rESm8q44ABRbh9hqMsfcMNx0kcXJ5ONbn1=ue-RvHFg@mail.gmail.com>
Message-ID: <201501281818.12121@pali>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 28 January 2015 16:57:18 Rob Herring wrote:
> On Wed, Jan 28, 2015 at 8:33 AM, Nicolas Pitre 
<nico@fluxnic.net> wrote:
> > On Wed, 28 Jan 2015, Pali Roh?r wrote:
> >> On Wednesday 28 January 2015 01:50:33 Tony Lindgren wrote:
> >> > On omaps, the bootrom passes the bootreason in r1 to the
> >> > bootloader that can do whatever it wants with it. We
> >> > could maybe pass it in the kernel cmdline to the
> >> > watchdog driver for user space?
> >> 
> >> Not truth for N900. Bootreason depends on PRM_RSTST omap
> >> register, state of vbat charger pins, time how long was
> >> power key pressed, R&D data stored in CAL partition and
> >> other undocumented registers for omap HS devices. I
> >> already tried to implement at least some subset of it in
> >> userspace (or kernel), but it is impossible because NOLO
> >> bootloader clear status of PRM_RSTST register.
> >> 
> >> There is also copy of PRM_RSTST register stored at address
> >> 0x4020FFB8 (tracing data) but that address is rewritten
> >> (probably by kernel), so we really cannot implement
> >> reading bootreason in kernel.
> >> 
> >> But in early stage in uboot it is possible to read
> >> 0x4020FFB8 address and get some part of bootreason. But
> >> still PRM_RSTST is not enough!
> >> 
> >> I would be happy if DT kernel can export /proc/atags file
> >> with ATAGs passed by bootloader. It would be enough for
> >> me. In userspace I can parse content and do what is
> >> needed.
> > 
> > What about defining a DT boot reason property instead?
> > Maybe it already exists?  If not, it's something that could
> > certainly be generically used on other platforms too.
> 
> I'm fine with that, but we just need to have a standard kernel
> userspace interface in addition to something like
> /proc/device-tree/bootreason. Perhaps this can be the default
> implementation for the watchdog dev. Someday when we decide DT
> is crap and have a new boot interface, we'll have people
> relying on /proc/device-tree. I hope to be retired when that
> happens...
> 
> Rob

Then what about exporting bootreason as /proc/bootreason?

-- 
Pali Roh?r
pali.rohar at gmail.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 198 bytes
Desc: This is a digitally signed message part.
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150128/410e6031/attachment.sig>
