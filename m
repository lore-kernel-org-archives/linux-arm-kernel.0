From: sebastian.hesselbarth@gmail.com (Sebastian Hesselbarth)
Date: Sat, 26 Jan 2013 19:51:55 +0100
Subject: [PATCH 2/2] ARM: Kirkwood: topkick: Enable i2c bus.
In-Reply-To: <20130126182454.GM17242@lunn.ch>
References: <f6d483f3fb83826bce16f956afa013f0bcf11f52.1359146831.git.jason@lakedaemon.net>
 <1359219326-5927-1-git-send-email-andrew@lunn.ch>
 <1359219326-5927-2-git-send-email-andrew@lunn.ch>
 <510414B3.6000207@gmail.com> <20130126182454.GM17242@lunn.ch>
Message-ID: <510425CB.8020307@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/26/2013 07:24 PM, Andrew Lunn wrote:
> # i2cdump 0 0x36
> No size specified (using byte-data access)
> WARNING! This program can confuse your I2C bus, cause data loss and worse!
> I will probe file /dev/i2c-0, address 0x36, mode byte
> Continue? [Y/n] y
>       0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f    0123456789abcdef
> 00: 3d 00 00 87 47 0c 00 08 00 13 00 00 10 00 00 00    =..?G?.?.?..?...
> 10: ff ff 00 6c 09 02 ff ff ff ff ff ff ff ff ff ff    ...l??..........
> 20: 88 ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ?...............
 >
 > ...
>
> Humm. A thought. 6282 has two i2c busses. I had noticed that uboot had
> configured the pin multiplexer such that they could be used for
> i2c. But maybe the NCT3012S is on the other i2c bus? Need to go look
> and see, but that will probably happen tomorrow....

0x36 (=0x6c >> 1) is the nuvoton pmic. Register values match what is
written in that very short datasheet.

Sebastian
