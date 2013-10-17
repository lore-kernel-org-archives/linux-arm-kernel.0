From: srinivas.kandagatla@st.com (srinivas kandagatla)
Date: Thu, 17 Oct 2013 15:30:48 +0100
Subject: [PATCH v5 1/4] i2c: busses: i2c-st: Add ST I2C controller
In-Reply-To: <20131017141957.GE14104@ns203013.ovh.net>
References: <1381754813-4679-1-git-send-email-maxime.coquelin@st.com>
 <1381754813-4679-2-git-send-email-maxime.coquelin@st.com>
 <20131016151419.GA14104@ns203013.ovh.net> <525F915D.9020501@st.com>
 <525FAEED.7030207@st.com> <20131017141957.GE14104@ns203013.ovh.net>
Message-ID: <525FF498.3060202@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 17/10/13 15:19, Jean-Christophe PLAGNIOL-VILLARD wrote:
> On 10:33 Thu 17 Oct     , srinivas kandagatla wrote:
>> On 17/10/13 08:27, Maxime COQUELIN wrote:
>>> ...
>>>>>>> +
>>>>>>> +static struct of_device_id st_i2c_match[] = {
>>>>>>> +     { .compatible = "st,comms-ssc-i2c", },
>>>>> the rules is to put the first soc that use the ip in the compatible
>>>>> as st,sti7100-scc-i2c
>>> Ok. There are no plans to upstream the SH4 platforms, it will only 
>>> remains in stlinux.com.
>>> Maybe I can set the first ARM platform (STiH415)?
>>> That would give st,stih415-ssc-i2c.
>> NAK, for st,stih415-ssc-i2c naming.
>>
>> IMO, this makes sense when the same IP integration done on different SOC
>> changes slightly/very differently.
>>
>> But in this case the "comms" IP remains unchanged across all the SOCs.
>>
>> I would still prefer "st,comms-ssc-i2c", allowing a single device driver
>> to match against several SoCs. ST "comms" IP it is integrated across all
>> the STi series of SoCs, so we don't want to add new entry in compatible
>> for every new SOC.
> 
> you never need this you always the first SoC that's all

Sorry to ask this but, Where is this requirement coming from?
I have not spotted any thing as such in ePAPR specs.


All the spec says is.
===
The compatible property value consists of one or more strings that
define the specific programming model for the device. This list of
strings should be used by a client program for device driver selection.
The property value consists of a concatenated list of null terminated
strings, *from most specific to most general.* They allow a device to
express its compatibility with a family of similar devices, potentially
allowing a single device driver to match against several devices.
The recommended format is ?manufacturer,model?, where manufacturer is a
string describing the name of the manufacturer (such as an OUI), and
model specifies the model number.

Example:
compatible = ?fsl,mpc8641-uart?, ?ns16550";
In this example, an operating system would first try to locate a device
driver that supported fsl,mpc8641-uart. If a driver was not found, it
would then try to locate a driver that supported the more general
ns16550 device type.
===

The more general compatible string in this case is "st,comms-ssc-i2c",
rather than the first soc name.
How can a first SOC name be more general?

As this driver is not very specific to StiH415, it is generic driver for
ST comms-ssc-i2c block.

Thanks,
srini




> 
> see other bindings on at91 as example sorry NACK
> 
> Best Regards,
> J.
>>
>>
>> Thanks,
>> srini
>>
>>>
>>> Thanks for the review,
>>> Maxime
>>>
>>>>>
>>
> 
> 
