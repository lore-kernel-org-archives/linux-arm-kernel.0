From: wens@csie.org (Chen-Yu Tsai)
Date: Wed, 14 Dec 2016 00:31:38 +0800
Subject: [PATCH 3/6] ARM: dts: sun8i: add a cpu0 label to cpu@0 node on
 A23/33
In-Reply-To: <139af71f-390a-4023-8f82-71dd80212518@arm.com>
References: <20161213152252.53749-1-icenowy@aosc.xyz>
 <20161213152252.53749-4-icenowy@aosc.xyz>
 <139af71f-390a-4023-8f82-71dd80212518@arm.com>
Message-ID: <CAGb2v65=Sh-WMEVk0Db48sgUcV6d7-wF_Yh0yJAHANMkGUzFwQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Dec 14, 2016 at 12:09 AM, Sudeep Holla <sudeep.holla@arm.com> wrote:
>
>
> On 13/12/16 15:22, Icenowy Zheng wrote:
>> A "cpu0" label is needed on cpu at 0 for cpufreq-dt to work.
>>
>
> IIUC any label should be fine and I don't see anything in the driver
> looking for such label name. All I see is it looks for cpu0 regulator
> for *legacy* DTs
>
>> Add such a label, in order to prepare for cpufreq support of A23/33.
>>
>
> You need this as you add the same label in the following patches. The
> commit message sounds like cpufreq-dt search for that label by name.

I think a more proper explanation would be:

The cpu's supply regulator is specified at the board level, hence we
need to add a label to it to reference it without replicating the whole
tree structure.

ChenYu
