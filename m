From: festevam@gmail.com (Fabio Estevam)
Date: Mon, 9 Oct 2017 09:16:36 -0300
Subject: iMX6 PCIE IRQ not working with ath9k based Wifi
In-Reply-To: <CAK8P3a0bF7=bbWBS9+7uBYp+yGpDUfS_QCX6K4i3WJv9mbgvEA@mail.gmail.com>
References: <348346fa-1d70-1d08-9a32-18b660328e4f@tubby.org>
 <CAK8P3a0bF7=bbWBS9+7uBYp+yGpDUfS_QCX6K4i3WJv9mbgvEA@mail.gmail.com>
Message-ID: <CAOMZO5AR3GukHSaRvUfW9MR6XPqKxEP+6wQn26zJTPX+Tx7xHQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Mike,

On Mon, Oct 9, 2017 at 7:19 AM, Arnd Bergmann <arnd@arndb.de> wrote:
> On Sat, Oct 7, 2017 at 5:51 PM, Mike Tubby <mike@tubby.org> wrote:
>> Arnd, Tim
>>
>> I have an iMX6 based SMARC module and custom motherboard with an mPCIE slot
>> into which I have a SparkLAN WPEA-127N Atheros 93xx family based Wifi card
>> which needs to be an access point and it doesn't work - basically I can get
>> it all set up and hostapd says it has gone active but it hangs and never
>> transmits and I think I'm having a problem with IRQ handling from the PCI
>> bus and as far as I can tell I'm having the issue which you discussed here:
>>
>>     https://patchwork.kernel.org/patch/8687351/
>
> (adding linux-arm-kernel to Cc, to make sure the discussion is open and
> gets archived)
>
>>
>> My system:
>>
>> root at arm:~# uname -a
>> Linux arm 4.1.15-224155-g2da0623-dirty #1 SMP PREEMPT Wed Apr 20 03:10:57
>> CST 2016 armv7l armv7l armv7l GNU/Linux

Please test a mainline kernel 4.13.x instead and manually apply this
series from Lucas:
https://www.spinics.net/lists/arm-kernel/msg603669.html
