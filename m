From: ivan.khoronzhuk@ti.com (ivan.khoronzhuk)
Date: Mon, 25 Nov 2013 12:59:45 +0200
Subject: Fwd: [PATCH 7/8] watchdog: davinci: add "clocks" property
In-Reply-To: <201311231857.47104.arnd@arndb.de>
References: <1383680783-12114-8-git-send-email-ivan.khoronzhuk@ti.com>
 <527A28E8.4010204@ti.com> <201311231857.47104.arnd@arndb.de>
Message-ID: <52932DA1.8040204@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/23/2013 07:57 PM, Arnd Bergmann wrote:
> On Wednesday 06 November 2013, ivan.khoronzhuk wrote:
>> @@ -7,6 +7,10 @@ Required properties:
>>   
>>   - reg : Should contain WDT registers location and length
>>   
>> +- clocks: phandle reference to the controller clock.
>> +         Required only for Keystone arch.
>> +         See clock-bindings.txt
>> +
>>   Optional properties:
>>   
>>   - timeout-sec:         Contains the watchdog timeout in seconds
> 
> I think it should really be listed under "Optional properties" and the
> reference to Keystone removed. Note how the binding would need
> to change otherwise if another platform started to use the clock, which
> is a little silly.
> 
> 	Arnd
> 

Ok, I'll move clocks property under "Optional properties" and describe it
as following:

Optional properties:
- timeout-sec : Contains the watchdog timeout in seconds
- clocks: phandle reference to the controller clock.
	  Needed if platform uses clocks.
	  See clock-bindings.txt

FYI:
The new patch series had been already presented, where the patches
"watchdog: davinci: add "clocks" property" and
"watchdog: davinci: reuse driver for keystone arch" were combined.
http://www.spinics.net/lists/devicetree/msg12542.html

-- 
Regards,
Ivan Khoronzhuk
