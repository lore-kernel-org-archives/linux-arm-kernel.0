From: tomeu@tomeuvizoso.net (Tomeu Vizoso)
Date: Tue, 9 Sep 2014 10:21:14 +0200
Subject: [PATCH v3 0/9] Tegra xHCI support
In-Reply-To: <CAL1qeaF7U9aoBp5gQPS=r+pe6krKmXdP1qak2gjhNqQMoHFB8A@mail.gmail.com>
References: <1409693701-16520-1-git-send-email-abrestic@chromium.org>
 <CAAObsKAYqpJMJnxSMxhkkRtnoEwLwgUa1y7ij5ZHvHf1jRok+Q@mail.gmail.com>
 <CAL1qeaF7U9aoBp5gQPS=r+pe6krKmXdP1qak2gjhNqQMoHFB8A@mail.gmail.com>
Message-ID: <CAAObsKAXO-pBtqd1jNj8faXqpE+5Wb0RFzPp+jn9FH0B=dHq8g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 8 September 2014 18:22, Andrew Bresticker <abrestic@chromium.org> wrote:
> On Mon, Sep 8, 2014 at 8:34 AM, Tomeu Vizoso <tomeu@tomeuvizoso.net> wrote:
>> On 2 September 2014 23:34, Andrew Bresticker <abrestic@chromium.org> wrote:
>>>
>>> Tested on Venice2, Jetson TK1, and Big with a variety of USB2.0 and
>>> USB3.0 memory sticks and ethernet dongles using controller firmware
>>> recently posted by Andrew Chew [2].
>>
>> I have had mixed results when testing this on a Jetson TK1 board. Of 8
>> USB devices I tested with, about half where probed correctly, but the
>> other half repeatedly fail in hub_port_init because in the GET_STATUS
>> right after the reset, the C_PORT_CONNECTION bit is set.
>>
>> I don't see any correlation between the failure and the kind of usb
>> device, but I don't have much experience with USB implementations
>> either.
>
> Hmm... I haven't seen that before.  Which particular devices were you using?

Here they are:

work:

Genius keyboard: 05d5:6782
Logitech mouse: 046d:c06a
Denver MP3 player: 10d6:1100
Atheros Bluetooth dongle: 0cf3:3005

don't work:

MCS7830 ethernet dongle: 9710:7830
Genesys Logic hub: 05e3:0608
Alcor flash drive: 058f:6387
JMicron SATA bridge: 152d:2329

HTH,

Tomeu
