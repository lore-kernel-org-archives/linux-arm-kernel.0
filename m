From: nm@ti.com (Nishanth Menon)
Date: Wed, 25 Feb 2015 09:16:11 -0600
Subject: [PATCH v5 0/7] irqchip: Move OMAP{4,
 5}/DRA7 to use stacked domains
In-Reply-To: <54EC555A.9050903@arm.com>
References: <1424713459-6824-1-git-send-email-marc.zyngier@arm.com>
 <20150223203237.GA30588@kahuna> <54EB9006.70000@ti.com>
 <54EC555A.9050903@arm.com>
Message-ID: <54EDE73B.7020503@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 02/24/2015 04:41 AM, Marc Zyngier wrote:
> On 23/02/15 20:39, Nishanth Menon wrote:
>> On 02/23/2015 02:32 PM, Nishanth Menon wrote:
>>> On 17:44-20150223, Marc Zyngier wrote:
[...]
>>>>  create mode 100644 Documentation/devicetree/bindings/interrupt-controller/ti,omap4-wugen-mpu
>>>>  delete mode 100644 include/linux/irqchip/irq-crossbar.h
>>>
>>> marc-test-irq (Applied the series to v4.0-rc1) - boot logs:
>>>  1:                     am335x-evm: BOOT: PASS: http://paste.ubuntu.org.cn/2469913
>>>  2:                      am335x-sk: BOOT: PASS: http://paste.ubuntu.org.cn/2469914
>>>  3:                     am3517-evm: BOOT: PASS: http://paste.ubuntu.org.cn/2469915
>>>  4:                      am37x-evm: BOOT: PASS: http://paste.ubuntu.org.cn/2469916
>>>  5:                      am437x-sk: BOOT: PASS: http://paste.ubuntu.org.cn/2469917
>>>  6:                    am43xx-epos: BOOT: PASS: http://paste.ubuntu.org.cn/2469918
>>>  7:                   am43xx-gpevm: BOOT: PASS: http://paste.ubuntu.org.cn/2469919
>>>  8:                 BeagleBoard-XM: BOOT: PASS: http://paste.ubuntu.org.cn/2469920
>>>  9:            beagleboard-vanilla: BOOT: PASS: http://paste.ubuntu.org.cn/2469928
>>> 10:               beaglebone-black: BOOT: PASS: http://paste.ubuntu.org.cn/2469932
>>> 11:                     beaglebone: BOOT: PASS: http://paste.ubuntu.org.cn/2469936
>>> 12:                     craneboard: BOOT: PASS: http://paste.ubuntu.org.cn/2469941
>>> 13:                     dra72x-evm: BOOT: PASS: http://paste.ubuntu.org.cn/2469945
>>> 14:                     dra7xx-evm: BOOT: PASS: http://paste.ubuntu.org.cn/2469946
>>> 15:         OMAP3430-Labrador(LDP): BOOT: PASS: http://paste.ubuntu.org.cn/2469947
>>> 16:                           n900: BOOT: PASS: http://paste.ubuntu.org.cn/2469948
>>> 17:                      omap5-evm: BOOT: PASS: http://paste.ubuntu.org.cn/2469949
>>> 18:                  pandaboard-es: BOOT: PASS: http://paste.ubuntu.org.cn/2469950
>>> 19:             pandaboard-vanilla: BOOT: PASS: http://paste.ubuntu.org.cn/2469951
>>> 20:                        sdp2430: BOOT: PASS: http://paste.ubuntu.org.cn/2469952
>>> 21:                        sdp3430: BOOT: PASS: http://paste.ubuntu.org.cn/2469953
>>> 22:                        sdp4430: BOOT: PASS: http://paste.ubuntu.org.cn/2469954
>>> TOTAL = 22 boards, Booted Boards = 22, No Boot boards = 0
>>>
>>> (also tested beagleboard-x15 which was not on farm: http://paste.ubuntu.org.cn/2470017  - looks good as well).
>> Noticed that I missed proper info about x15 here.. anyways..
>>
>> http://paste.ubuntu.org.cn/2470017 was vanilla v4.0-rc1
>> http://pastebin.ubuntu.com/10377375/ is with this series applied on top.
>>
>>>
>>> Comparative boot logs for v4.0-rc1:
>>> https://github.com/nmenon/kernel-test-logs/tree/v4.0-rc1
>>>
>>> Will dig in detail a little later.. but nothing major stuck out to me.
> 
> Excellent. Let me know if you spot anything. Can I otherwise add your
> "Tested-by:"?

Yes please. Sorry that I did not respond earlier.

-- 
Regards,
Nishanth Menon
