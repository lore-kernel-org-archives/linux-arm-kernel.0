From: quentin.schulz@free-electrons.com (Quentin Schulz)
Date: Mon, 19 Dec 2016 15:18:03 +0100
Subject: [PATCH v2] ARM: dts: sun8i: add opp-v2 table for A33
In-Reply-To: <11975791482156406@web2g.yandex.ru>
References: <20161215182754.33921-1-icenowy@aosc.xyz>
 <20161219084652.kiqdkiewu5tujlyd@lukather>
 <CAGb2v65YWntCrFHtSbxhtTWkt+UwkW3xoY-ae26MpH+-ULLXSQ@mail.gmail.com>
 <11975791482156406@web2g.yandex.ru>
Message-ID: <8af4327f-b779-9d97-347f-bfe4b8303a60@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On 19/12/2016 15:06, Icenowy Zheng wrote:
> 
> After proper testing of A23 ccu, the operating points can also apply to A23.
> (According to A23 devices' fex)
> 

I disagree. I've looked into using the same operating points for A23 and
A33 for CPUfreq and I came to the conclusion that not all A23-based
boards share the same operating points. You can find the fex files for
the different boards here:
https://github.com/linux-sunxi/sunxi-boards/tree/master/sys_config/a23

After gathering all supported frequencies/voltages for each A23-based
boards, I found that only the following frequencies and voltages are
supported by all A23-based boards:

 - 1008 MHz, 1220 mV
 - 816 MHz, 1120 mV
 - 600 MHz, 1040 mV

Quentin

-- 
Quentin Schulz, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
