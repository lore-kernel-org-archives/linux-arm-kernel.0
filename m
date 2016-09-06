From: scott.wood@nxp.com (Scott Wood)
Date: Tue, 6 Sep 2016 17:05:35 +0000
Subject: [linux-devel] [PATCH v2 1/1] arm64: Add DTS support for FSL's
 LS1012A SoC
References: <1472207241-18461-1-git-send-email-Bhaskar.Upadhaya@nxp.com>
 <20160829095239.GM30790@tiger> <1472493061.13245.39.camel@buserror.net>
 <20160830120220.GC8363@tiger>
 <HE1PR0401MB2636B40376255680B6A58CFB8DE00@HE1PR0401MB2636.eurprd04.prod.outlook.com>
 <20160905014636.GB25778@tiger>
Message-ID: <DB5PR0401MB1928BE0E1C08DD2FAC582FE191F90@DB5PR0401MB1928.eurprd04.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/04/2016 08:47 PM, Shawn Guo wrote:
> On Tue, Aug 30, 2016 at 02:07:17PM +0000, Stuart Yoder wrote:
>>> On Mon, Aug 29, 2016 at 12:51:01PM -0500, Scott Wood wrote:
>>>> On Mon, 2016-08-29 at 17:52 +0800, Shawn Guo wrote:
>>>>> On Fri, Aug 26, 2016 at 03:57:21PM +0530, Bhaskar Upadhaya wrote:
>>>>>>
>>>>>> +		clockgen: clocking at 1ee1000 {
>>>>>> +			compatible = "fsl,ls1012a-clockgen";
>>>>> The compatible cannot be found in binding docs.
>>>>
>>>> From Documentation/devicetree/bindings/clock/qoriq-clock.txt:
>>>>
>>>> - compatible: Should contain a chip-specific clock block compatible
>>>>         string and (if applicable) may contain a chassis-version clock
>>>>         compatible string.
>>>>
>>>>         Chip-specific strings are of the form "fsl,<chip>-clockgen", such as:
>>>>         * "fsl,p2041-clockgen"
>>>>         * "fsl,p3041-clockgen"
>>>>         * "fsl,p4080-clockgen"
>>>>         * "fsl,p5020-clockgen"
>>>>         * "fsl,p5040-clockgen"
>>>>         * "fsl,t4240-clockgen"
>>>>         * "fsl,b4420-clockgen"
>>>>         * "fsl,b4860-clockgen"
>>>>         * "fsl,ls1021a-clockgen"
>>>>         Chassis-version clock strings include:
>>>>         * "fsl,qoriq-clockgen-1.0": for chassis 1.0 clocks
>>>>         * "fsl,qoriq-clockgen-2.0": for chassis 2.0 clocks
>>>>
>>>> I really hope we don't have to update every single fsl,<chip>-whatever binding
>>>> every time a new chip comes out.  There are already other chips not listed,
>>>> FWIW (e.g. t1040, t2080, ls1043a, and ls2080a).  That's why it says "such as".
>>>
>>> If I remember correctly, DT maintainers want every supported compatible
>>> string explicitly listed in bindings doc.  And they even added a check
>>> into checkpatch.pl with commit bff5da433525 ("checkpatch: add DT
>>> compatible string documentation checks").
>>
>> See Documentation/devicetree/bindings/submitting-patches.txt:
>>
>>   5) The wildcard "<chip>" may be used in compatible strings, as in
>>      the following example:
>>
>>          - compatible: Must contain '"nvidia,<chip>-pcie",
>>            "nvidia,tegra20-pcie"' where <chip> is tegra30, tegra132, ...
>>
>>      As in the above example, the known values of "<chip>" should be
>>      documented if it is used.
>>
>> It _is_ allowed to use the <chip> wildcard, and so you will not find all
>> full compatible strings explicitly listed in bindings.  However, the
>> chips themselves "should" be listed.
> 
> + Rob and Mark
> 
> Oops, I'm not aware of this DT document.  In that case, the DT document
> and checkpatch is basically asking for conflicting thing.  Rob, Mark,
> can you guys please clarify?

Checkpatch is a useful tool but it can't get everything right all the time.

-Scott
