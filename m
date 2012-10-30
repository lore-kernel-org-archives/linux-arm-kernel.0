From: tremyfr@yahoo.fr (Philippe Reynes)
Date: Tue, 30 Oct 2012 19:55:44 +0000 (GMT)
Subject: [PATCH] Add device tree file for the armadeus apf27
In-Reply-To: <20121029211015.GX1641@pengutronix.de>
References: <1351268980-25347-1-git-send-email-tremyfr@yahoo.fr>
 <20121029211015.GX1641@pengutronix.de>
Message-ID: <1351626944.55016.YahooMailNeo@web28804.mail.ir2.yahoo.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



Hi Sascha,
>> +??? ??? osc26m {

>> +??? ??? ??? compatible = "fsl,imx-osc26m", "fixed-clock";
>> +??? ??? ??? clock-frequency = <33554432>;

>Is this really correct? The Datasheet specificies 26MHz, some boards
>have 27Mhz, but 33?

The clock value on this board is? 32.768kHz, so 32768 * 1024.
I've tried others value, all others produce weird behaviour on the serial.

>> +??? soc {
>> +??? ??? aipi at 10000000 {
>> +??? ??? ??? wdog at 10002000 {
>> +??? ??? ??? ??? status = "okay";
>> +??? ??? ??? };

>This node is not necessary. The watchdog is enabled already in the dtsi
>file.

Yes, you're right, I'll send a v2 of this patch without the watchdog.

Regards,
Philippe
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20121030/02b8b831/attachment-0001.html>
