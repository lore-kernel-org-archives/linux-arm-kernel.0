From: greguu@null.net (Greg)
Date: Tue, 6 Nov 2018 18:00:49 +1300
Subject: PCMCIA / PXA27X / CPUFREQ
In-Reply-To: <87efc0oatr.fsf@belgarion.home>
References: <CAJD+NwqUdDRFisnPtj9QCm=F2bHMSMfRkK1UWedJcS6_UmLhYg@mail.gmail.com>
 <87efc0oatr.fsf@belgarion.home>
Message-ID: <CAJD+NwpE+uS99fe2uXM0X6WwRyegTm3wXNHWPM_xM0r3+nrhBw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 5 Nov 2018 at 09:18, Robert Jarzmik <robert.jarzmik@free.fr> wrote:
>
> Greg <greguu@null.net> writes:
>
> > Hi Robert,
>
> Hi Greg,
>
> I will make some tests next week to confirm your status, I don't seem to
> remember any specific issue on PCMCIA lately, but that was before v4.19 so one
> might have sneaked it.
>
It sneaked in a some time ago, I think with 4.8 or so but it took us a
while to find out what is causing it and report it.

> I would advise to report this on the Linux ARM mailing list
> (linux-arm-kernel at lists.infradead.org), and put in the "To:" at least Pavel
> Machek <pavel@ucw.cz> and Andrea Adami <andrea.adami@gmail.com>, who happen to
> have the same devices as you AFAIR.
>
> > If you like me to carry out some further debugging or troubleshooting on the
> > platform please let me know.
> That will come :) As a first step, I'd like you to check /proc/interrupts,
> before and after inserting the PCMCIA card, to see if the interrupt is correctly
> triggered (in the case with cpufreq enabled of course).
>
The output is identical, without card in socket 0 after boot and with
card inserted after boot (card not detected in these cases), but also
with card inserted before boot (card detected) the output is the same.
Please note that socket 1 is always occupied with a CF card and
working.

This is with CPUFREQ enabled on 4.19

 cat /proc/interrupts
           CPU0
 19:       6556        SC   3 Edge      ohci_hcd:usb1
 22:          4        SC   6 Edge      pxa2xx-i2c.1
 24:          0        SC   8 Edge      gpio-0
 25:          0        SC   9 Edge      gpio-1
 26:        218        SC  10 Edge      gpio-mux
 27:          0        SC  11 Edge      pxa27x_udc
 28:          0        SC  12 Edge      arm-pmu
 32:        358        SC  16 Edge      pxa2xx-spi.2
 33:          2        SC  17 Edge      LCD
 34:         69        SC  18 Edge      pxa2xx-i2c.0
 39:      89110        SC  23 Edge      pxa2xx-mci
 41:      11812        SC  25 Edge      pxa-dma
 42:       6239        SC  26 Edge      ost0
121:          0      GPIO   9 Edge      pxa2xx-mci.0 cd
123:          1      GPIO  11 Edge      ads7846
124:          6      GPIO  12 Edge      matrix-keypad
129:         39      GPIO  17 Edge      matrix-keypad
133:          0      GPIO  21 Edge      Fatal Battery
146:         15      GPIO  34 Edge      matrix-keypad
148:         25      GPIO  36 Edge      matrix-keypad
150:         14      GPIO  38 Edge      matrix-keypad
151:          0      GPIO  39 Edge      matrix-keypad
202:          0      GPIO  90 Edge      Battery Cover
203:         13      GPIO  91 Edge      matrix-keypad
206:          2      GPIO  94 Edge      PCMCIA0 CD
207:          0      GPIO  95 Edge      On Off
208:          0      GPIO  96 Edge      Lid Closed
209:          0      GPIO  97 Edge      Display Down
213:          3      GPIO 101 Edge      CO
218:       8346      GPIO 106 Edge      pata_pcmcia[1.0]
227:          0      GPIO 115 Edge      AC Input Detect
Err:          0

Cheers,

Greg
