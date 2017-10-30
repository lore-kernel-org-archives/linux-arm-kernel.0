From: pavel@ucw.cz (Pavel Machek)
Date: Mon, 30 Oct 2017 21:02:59 +0100
Subject: n950: mmc fails to work, omap_hsmmc 480b4000.mmc: RX DMA channel
 request failed ? was Re: 4.13 (and probably all recent) kernels
 refuse to boot on one Nokia N950, work or another
In-Reply-To: <20171030194340.GA9133@amd>
References: <20171025203459.GA22035@amd> <20171025212806.GA21504@atomide.com>
 <20171026091325.GA26929@amd>
 <20171026093115.4bc6ctxjx72ng7ld@earth>
 <20171026095734.GA10141@amd>
 <20171026120130.dicanunwcdmjntnb@earth> <20171027101905.GA4287@amd>
 <65ad0b63-cfae-f7ac-f916-32fd0c7c540a@gmail.com>
 <20171030194340.GA9133@amd>
Message-ID: <20171030200259.GA13560@amd>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi!

> Then I was (finally!) able to run dmesg, and that tells me:
> 
> [    0.816040] mousedev: PS/2 mouse device common for all mice
> [    0.817657] input: TWL4030 Keypad as
> /devices/platform/68000000.ocp/48070000.i2c/i2c-0/0-0048/48070000.i2c:twl at 48:keypad/input/input0
> [    0.820800] i2c /dev entries driver
> [    0.830261] omap_wdt: OMAP Watchdog Timer Rev 0x31: initial timeout
> 60 sec
> [    0.836212] omap_hsmmc 480b4000.mmc: RX DMA channel request failed
> [    0.840026] ledtrig-cpu: registered to indicate activity on CPUs
> [    0.840789] omap-aes 480c5000.aes: OMAP AES hw accel rev: 2.6
> [    0.840942] omap-aes 480c5000.aes: Unable to request in DMA channel
> [    0.841644] omap-aes 480c5000.aes: will run requests pump with
> realtime priority
> 
> Kernel 4.13-rc2.

Aha. DMADEVICES=y, then DMA_OMAP can be selected. Then mmc
works. Debugging is much easier with dmesg :-).

									Pavel

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 181 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20171030/aa6636c3/attachment.sig>
