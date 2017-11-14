From: marc_gonzalez@sigmadesigns.com (Marc Gonzalez)
Date: Tue, 14 Nov 2017 18:07:15 +0100
Subject: [PATCH v3 3/4] net: nb8800: Move HW init to ndo_open()
In-Reply-To: <yw1xbmk4241h.fsf@mansr.com>
References: <230165aa-eaf1-6e2b-7ff3-45b3ee4ffc62@sigmadesigns.com>
 <103bc878-9311-a727-1c21-2070e0a480e5@sigmadesigns.com>
 <yw1xwp2t11ap.fsf@mansr.com>
 <4e22ef54-d823-fc29-fedc-d447fa3d9c88@sigmadesigns.com>
 <yw1xfu9h0xv7.fsf@mansr.com>
 <30042004-4e13-b7e2-b49d-754db54cc5ce@sigmadesigns.com>
 <yw1xbmk4241h.fsf@mansr.com>
Message-ID: <3857a215-1ec0-e4d3-89a0-66c9f41af658@sigmadesigns.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 14/11/2017 17:55, M?ns Rullg?rd wrote:

> Marc Gonzalez wrote:
> 
>> On 14/11/2017 14:54, M?ns Rullg?rd wrote:
>>
>>> The hack originated from your company.
>>
>> So why are you so insistent that we keep using it?
> 
> Because it's the only way to support some chip variants.  Ones you'd
> apparently rather forget, but which nonetheless exist.

Which chip variants do you have in mind?
All tango3 board supports the reset method.

BTW, could you test my patch series on your board?
(I can't since the board is not supported upstream.)

>>> Also, I have repeated asked you what happens if the tango5 runs out of
>>> DMA buffers under normal operation.  Does that also cause it to lock up?
>>> If so, you have a much bigger problem on your hands.
>>
>> I will run iperf3 tests with RX_DESC_COUNT lowered to 2.
>> Would that produce conclusive results?
>> Do you have other suggestions?
> 
> Leave RX_DESC_COUNT alone but add a delay in the nb8800_poll() loop.
> That should ensure that queue is drained slowly enough for the buffers
> to run out.

OK. I will test this ASAP on tango4 and tango5.

I'll try finding a tango3 board, to check the nb8800_mdio_cmd()
quirk and the flow_control quirk. Again, the HW dev said they
are not needed, so if he's wrong, his credibility his shot.
