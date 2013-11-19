From: bgamari.foss@gmail.com (Ben Gamari)
Date: Tue, 19 Nov 2013 12:18:14 -0500
Subject: cpufreq on PandaBoard
In-Reply-To: <528B7D61.5020206@ti.com>
References: <87eh6ca150.fsf@gmail.com> <528B7D61.5020206@ti.com>
Message-ID: <87hab8nwdl.fsf@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Nishanth Menon <nm@ti.com> writes:

> On 11/19/2013 08:59 AM, Ben Gamari wrote:
>> 
>> Booting a PandaBoard with a recent kernel and devicetree appears to be a
>> rather messy process. There are dozens of devicetree-related warnings
>> spewed on boot (many pertaining to missing regulators). At the moment,
>> however, I'm most interested in this,
>> 
>>     cpufreq-cpu0 cpufreq-cpu0.0: no of_node; not parsing pinctrl DT
>>     cpu cpu0: dummy supplies not allowed
>>     cpufreq_cpu0: failed to get cpu0 regulator: -19
>>     cpufreq_cpu0: failed to get cpu0 clock: -2
>>     cpufreq-cpu0: probe of cpufreq-cpu0.0 failed with error -2
>> 
>> What is the status of cpufreq on the PandaBoard? Is this expected to
>> work?
>> 
>> More generally, if one wants a fairly recent kernel supporting the
>> PandaBoard's hardware what kernel tree should be used? Is mainline not
>> yet appropriate? Is linux-next preferred? Perhaps a ti-maintained tree?
> 
> for upstream: Wait for the clock nodes to get merged.. we are at v9 of
> discussion thread here[1].
>
I take it that the clock node work does not itself fix cpufreq? I've
built the 3.12-dt-clks-v10-dev branch. On the bright side, it boots and
appears to run just fine. Unfortunately, there isn't even a mention of
cpufreq in the boot log.

I've seen your Google+ post[1] from May enumerating the steps to having
working DVFS. It would be useful to post an update showing what has been
merged, what is waiting for merge, and what is still in progress.

> for ti-maintained tree, you need to talk to TI support folks for
> appropriate kernel for your product line.
>
I wasn't asking for official support, just wondering where work is
currently happening.

Thanks for your help.

Cheers,

- Ben


[1] https://plus.google.com/112464029509057661457/posts/gvyZQcNieoq
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 489 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20131119/7e86274a/attachment.sig>
