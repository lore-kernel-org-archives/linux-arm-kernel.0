From: sudeep.holla@arm.com (Sudeep Holla)
Date: Tue, 21 Feb 2017 12:37:31 +0000
Subject: [PATCH] arm64: dts: juno: update definition for programmable
 replicator.
In-Reply-To: <DB6PR0802MB219850A35C8DAD5CB2858C1C8C510@DB6PR0802MB2198.eurprd08.prod.outlook.com>
References: <1487358790-2618-1-git-send-email-mike.leach@linaro.org>
 <2ba59da5-fc79-ab53-2f2a-2ddc6e5e9c3d@arm.com>
 <DB6PR0802MB219850A35C8DAD5CB2858C1C8C510@DB6PR0802MB2198.eurprd08.prod.outlook.com>
Message-ID: <798053cd-ae5a-dc04-12c9-9df9e0d66b4d@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 21/02/17 12:34, Mike Leach wrote:
> Hi Sudeep
> 
>> -----Original Message-----
>> From: CoreSight [mailto:coresight-bounces at lists.linaro.org] On Behalf Of
>> Sudeep Holla
>> Sent: 21 February 2017 11:03
>> To: Mike Leach; linux-arm-kernel at lists.infradead.org
>> Cc: devicetree at vger.kernel.org; coresight at lists.linaro.org;
>> robh+dt at kernel.org; Sudeep Holla
>> Subject: Re: [PATCH] arm64: dts: juno: update definition for programmable
>> replicator.
>>
>> Hi Mike,
>>
>> On 17/02/17 19:13, Mike Leach wrote:
>>> Juno platforms have a programmable replicator splitting the trace
>>> output to TPIU and ETR. Currently this is not being programmed as it
>>> is being treated as a none-programmable replicator - which is the
>>> default operational mode for these devices. The TPIU in the system is
>>> enabled by default, and this combination is causing back-pressure in
>>> the trace system resulting in overflows at the source.
>>>
>>> Replaces the existing definition with one that defines the
>>> programmable replicator, using the "qcom,coresight-replicator1x"
>>> driver that provides the correct functionality for CoreSight programmable
>> replicators.
>>>
>>
>> I assume this is just enhancement and not a fix.
> 
> I guess it depends on your point of view - with this update the trace
> overflows I was seeing disappear, as the trace path to TPIU is
> blocked. So it affects the quality of collected trace using the ETR
> rather than a binary didn't work / works now change.
> 

OK, could you add the warning overflow messages if you get, so that it's
very clear from the change log. Then I can see if it can be pushed as fix.

-- 
Regards,
Sudeep
