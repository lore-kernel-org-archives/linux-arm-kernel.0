From: afaerber@suse.de (=?UTF-8?B?QW5kcmVhcyBGw6RyYmVy?=)
Date: Tue, 21 Oct 2014 22:52:05 +0200
Subject: [PATCH v2 00/11] ARM: dts: zynq: Prepare Parallella
In-Reply-To: <CAOesGMjAb5oXjauhbqjDhJXWct7qoXxy3XpA1=DioK7vPTwetA@mail.gmail.com>
References: <1406242820-20140-1-git-send-email-afaerber@suse.de>
 <CAOesGMjAb5oXjauhbqjDhJXWct7qoXxy3XpA1=DioK7vPTwetA@mail.gmail.com>
Message-ID: <5446C775.3030707@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Olof and S?ren,

Am 18.10.2014 um 06:28 schrieb Olof Johansson:
> On Thu, Jul 24, 2014 at 4:00 PM, Andreas F?rber <afaerber@suse.de> wrote:
>> Hello,
>>
>> This patch series adds an initial device tree for the Parallella board.
>> UART, SD card, Ethernet are enabled.
>> Not yet enabled are HDMI, QSPI flash and 2x USB.
> 
> Andreas (Olofsson) kindly sent me a board, and I added it to the boot
> farm today, it'll be included in boot reports from here on.

Good to hear.

> I did a test run with yesterday's -next It looks like networking isn't
> working there at the moment, clock related. Same happens with 3.17 and
> latest mainline, config multi_v7_defconfig:
> 
> [WARN] [    7.943648] macb e000b000.ethernet eth0: unable to generate
> target frequency: 125000000 Hz
> [WARN] [   10.948681] macb e000b000.ethernet eth0: unable to generate
> target frequency: 125000000 Hz

I am unable to reproduce this in my setup - at Linus' tip
c2661b806092d8ea2dccb7b02b65776555e0ee47 (v3.18-rc1-68-gc2661b8), make
oldconfig'ing my /proc/config.gz.

S?ren, in light of your explanations, should I be expecting problems
with 1GbE or with 100MbE? My board is connected to a 1GbE switch.

Regards,
Andreas

-- 
SUSE LINUX Products GmbH, Maxfeldstr. 5, 90409 N?rnberg, Germany
GF: Jeff Hawn, Jennifer Guild, Felix Imend?rffer; HRB 16746 AG N?rnberg

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: OpenPGP digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20141021/1697e8d0/attachment.sig>
