From: subhasish@mistralsolutions.com (Subhasish Ghosh)
Date: Fri, 18 Feb 2011 13:45:57 +0530
Subject: [PATCH v2 09/13] can: pruss CAN driver.
In-Reply-To: <4D5E2570.10108@grandegger.com>
References: <1297435892-28278-1-git-send-email-subhasish@mistralsolutions.com>	<1297435892-28278-10-git-send-email-subhasish@mistralsolutions.com>	<20110211152026.GC373@e-circ.dyndns.org>
	<32A5399EB727427C98185089E5DBFA65@subhasishg>
	<4D5E2570.10108@grandegger.com>
Message-ID: <184FA07B783D4F5FAAC09D5C11737A3F@subhasishg>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> On 02/18/2011 08:07 AM, Subhasish Ghosh wrote:
>> --------------------------------------------------
>> From: "Kurt Van Dijck" <kurt.van.dijck@eia.be>
>
> ...
>>>> + /* register interrupt handler */
>>>> + err = request_irq(priv->trx_irq, &omapl_rx_can_intr, IRQF_SHARED,
>>>> +   "pru_can_irq", ndev);
>>> you're doing a lot of work _in_ the irq handler. Maybe threaded irq?
>>>
>> SG -Ok, will do
>
> No, please use NAPI instead.

We are using h/w filters, so the number of interrupts coming into the 
processor are not hogging it.
I feel that we may not require an interrupt mitigation.

-Subhasish 
