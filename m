From: horia.geanta@nxp.com (=?iso-8859-2?Q?Horia_Geant=E3?=)
Date: Tue, 28 Mar 2017 07:19:43 +0000
Subject: [PATCH] arm64: dts: ls1012a: add crypto node
References: <20170322122939.22117-1-horia.geanta@nxp.com>
 <20170324015606.GC30608@dragon>
 <DB4PR04MB0847D837CB2762D5094720CB983E0@DB4PR04MB0847.eurprd04.prod.outlook.com>
 <20170324073420.GM30608@dragon>
 <DB4PR04MB0847E3EE8F7FAC11DD85FAA8983E0@DB4PR04MB0847.eurprd04.prod.outlook.com>
 <20170324140320.GP30608@dragon>
Message-ID: <VI1PR0401MB259164F1B575677D65CB8F2E98320@VI1PR0401MB2591.eurprd04.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 3/24/2017 4:04 PM, Shawn Guo wrote:
> On Fri, Mar 24, 2017 at 08:29:17AM +0000, Horia Geant? wrote:
>> On 3/24/2017 9:35 AM, Shawn Guo wrote:
>>> On Fri, Mar 24, 2017 at 07:17:50AM +0000, Horia Geant? wrote:
>>>>>> +		sec_mon: sec_mon at 1e90000 {
>>>>>
>>>>> Hyphen is more preferred to be used in node name than underscore.
>>>>>
>>>> This would imply changing the
>>>> Documentation/devicetree/bindings/crypto/fsl-sec4.txt binding and
>>>> dealing with all the consequences, which IIUC is probably not worth.
>>>
>>> I do not care the bindings doc that much, since I'm not the maintainer
>>> of it.  What are the consequences specifically, if we use a better node
>>> name in dts than bindings example?
>>>
>> Users relying on finding the sec_mon node will obviously stop working.
>> I don't see any in-kernel users, however there could be others I am not
>> aware of and DT bindings should provide for backwards compatibility.
> 
> Okay, point taken.  You can keep the node name as it is.
> 
>> I could deprecate "sec_mon" in the bindings and suggest "sec-mon"
>> instead, while leaving all existing dts files as-is.
>> The risk is breaking LS1012A users relying on "sec_mon".
> 
> For existing bindings, I do not care that much.  But for new ones, I do
> hope that we recommend to use hyphen, as that's more idiomatic at least
> for Linux kernel.
> 
>> I see that ePAPR:
>> -allows both for hyphen and underline in case of node names
>> -allows only for hyphen (i.e. forbids underline) in case of alias nodes
>>
>> In the first case, I understand there's an (undocumented?) agreement to
>> prefer hyphen over underline.
> 
> Both are valid, but hyphen is more idiomatic for Linux kernel.
> 
>> For the 2nd one, does this mean I should change alias names?
> 
> This is something I see difference between specification and DTC.
> 
> 	aliases {
> 		alias-name = &label_name;
> 	};
> 
> 	label_name: node-name {
> 		...
> 	};
> 
> The spec says that only hyphen is valid for alias name, but DTC works
> happily with underscore too.  From my experience with DTC playing, both
> hyphen and underscore are valid for alias and node name.  But for label
> name, only underscore is valid.  Using hyphen in label name will cause
> DTC to report syntax error.
> 
Yes indeed, thanks for pointing it out.

For the sake of current patch, please clarify whether a v2 is needed.
IIUC:
-sec_mon node name could stay the same (existing binding)
-label names are ok, since underline is the only option allowed by DTC
-alias names are out-of-spec but accepted by DTC; if changing underline
to hyphen is requested, I will push out v2

Thanks,
Horia
