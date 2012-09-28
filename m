From: swarren@wwwdotorg.org (Stephen Warren)
Date: Fri, 28 Sep 2012 08:57:20 -0600
Subject: [PATCH] ARM: bcm2835: implement machine restart hook
In-Reply-To: <20120928103140.GZ17667@game.jcrosoft.org>
References: <1348805280-7647-1-git-send-email-swarren@wwwdotorg.org>
 <20120928103140.GZ17667@game.jcrosoft.org>
Message-ID: <5065BAD0.1030105@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/28/2012 04:31 AM, Jean-Christophe PLAGNIOL-VILLARD wrote:
> On 22:08 Thu 27 Sep     , Stephen Warren wrote:
>> Implement the machine restart hook using the SoC's watchdog timer module.
>> To support this, define a DT binding for the watchdog module, and add it
>> to the device tree.
>>
>> The downstream rpi-split branch contains a full watchdog timer driver
>> implementation, which also implements the restart hook. However, the
>> restart function is largely separate from the watchdog driver, so for
>> simplicity, the restart hook is implemented here directly in the main
>> machine source file.

>> +++ b/Documentation/devicetree/bindings/watchdog/brcm,bcm2835-pm-wdog.txt

>> +Example:
>> +
>> +intc: interrupt-controller {
>> +	compatible = "brcm,bcm2835-pm-wdog";
>
> it's seems everyone use -wdt

That is true. "-wdog" is what was in the downstream patch, but I guess
it makes sense to fix it up to be consistent with everything already in
the kernel.
