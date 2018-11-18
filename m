From: marek.vasut@gmail.com (Marek Vasut)
Date: Mon, 19 Nov 2018 00:45:16 +0100
Subject: [PATCH] arm64: dts: renesas: r8a77990: ebisu: Add and enable
 CAN,FD device nodes
In-Reply-To: <20181118230313.GB2553@kunai>
References: <20181118173424.4807-1-marek.vasut+renesas@gmail.com>
 <20181118230313.GB2553@kunai>
Message-ID: <63e27a31-d599-4672-87b9-48b0f542313d@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/19/2018 12:03 AM, Wolfram Sang wrote:
> On Sun, Nov 18, 2018 at 06:34:24PM +0100, Marek Vasut wrote:
>> This patch adds CAN0,1 and CANFD device nodes for the r8a77990 SoC
>> and enables CANFD connected to CN10 on the E3 Ebisu board using the
>> R8A77990 SoC.
>>
>> Signed-off-by: Marek Vasut <marek.vasut+renesas@gmail.com>
>> Cc: Geert Uytterhoeven <geert+renesas@glider.be>
>> Cc: Marc Kleine-Budde <mkl@pengutronix.de>
>> Cc: Rob Herring <robh@kernel.org>
>> Cc: Simon Horman <horms+renesas@verge.net.au>
>> Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>
>> Cc: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
>> Cc: linux-arm-kernel at lists.infradead.org
>> Cc: linux-renesas-soc at vger.kernel.org
> 
> Same here, what was tested?

I connected the CN10 to Peak CANFD, brought both interfaces up at
125kBd/250kBd for FD
$ ip link set canX up type can bitrate 125000 dbitrate 250000 fd on

And ran on either side:
$ cangen -m canX
and
$ candump -t d -dex canX
This should give a good mix of CAN messages.

-- 
Best regards,
Marek Vasut
