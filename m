From: prylowski@metasoft.pl (Rafal Prylowski)
Date: Thu, 05 Apr 2012 11:07:56 +0200
Subject: [PATCH v2 1/3] PATA host controller driver for ep93xx
In-Reply-To: <4F7D4F21.2060401@metasoft.pl>
References: <4F7B0C54.8010804@metasoft.pl> <4F7C64B8.5000909@metasoft.pl>
 <4F7C65CE.6000309@metasoft.pl> <201204041523.50872.arnd@arndb.de>
 <4F7D4F21.2060401@metasoft.pl>
Message-ID: <4F7D60EC.4050805@metasoft.pl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2012-04-05 09:52, Rafal Prylowski wrote:
> Jiffies seem to work. I was wrong with this interrupt handler. Actually
> IDE register read/write (and IORDY polling) is called from softirq,

Well, you were right... Jiffies doesn't work, I thought it work
because I wrongly selected time_is_before_jiffies instead of
time_is_after_jiffies... I will try to use ktime_get.

Thanks,
RP
