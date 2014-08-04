From: peter.ujfalusi@ti.com (Peter Ujfalusi)
Date: Mon, 4 Aug 2014 12:09:56 +0300
Subject: [PATCH 5/6] ARM: DTS: da850-evm: Add node for tlv320aic3106 codec
In-Reply-To: <53DB9751.6030508@ti.com>
References: <1406801934-23334-1-git-send-email-peter.ujfalusi@ti.com>	<1406801934-23334-6-git-send-email-peter.ujfalusi@ti.com>	<53DA519A.4090905@cogentembedded.com>
 <53DB240F.2030908@ti.com>	<53DB8CEA.9010902@cogentembedded.com>
 <53DB8FE1.5010207@ti.com>	<53DB9292.7080008@cogentembedded.com>
 <53DB9751.6030508@ti.com>
Message-ID: <53DF4DE4.3090305@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/01/2014 04:34 PM, Peter Ujfalusi wrote:
> Hi,
> 
> On 08/01/2014 04:13 PM, Sergei Shtylyov wrote:
>> Hello.
>>
>> On 08/01/2014 05:02 PM, Peter Ujfalusi wrote:
>>
>>>>     I do. We should follow the standard consistently. Why not call the node
>>>> "sound-codec"?
>>
>>> Well, there is _zero_ cases when the audio codec node is named as
>>> "sound-codec" in linux-next but we have wmXXXX, tlvXXXX, twlXXXX, maxXXXX etc.
>>
>>    Which only means people don't read the standard (which is referred to on
>> http://www.devicetree.org/Device_Tree_Usage, that says the same).
>>
>>> Yeah, there are few DTS files which have codec as node name.
>>> So, no, I'm not going to change the node name from tlv320aic3106.
>>
>>    So you prefer following the bad examples to following the standard?
> 
> those bad examples are in the tree and they did went through the review
> process (arch, DT and probably alsa). But it is interesting that we do not
> have a single correct node name for audio codecs (probably for other types also).

I have thought about this over the weekend and I would keep the node name for
the codec as it is in the patch.
It is the common practice for audio and it also helps when reading the DT file
to quickly see the audio support on the board. We all use the 'sound' node
name for audio cards and when we use the name of the codec as node name we do
not need to look further in the dts file to see what is the codec in used (and
what/which cpu dai we are using). All this can be seen in the main sound
support node.

>> Well, "the Moor has done his duty, the Moor can go"...
> 
> Let's ask the DT maintainers what should be the correct approach and someone
> should go through all the existing DT files and clean them up? People usually
> start reading the code for examples before the standard...
> 


-- 
P?ter
