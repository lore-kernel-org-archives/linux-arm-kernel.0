From: mmarek@suse.cz (Michal Marek)
Date: Wed, 14 Sep 2011 03:48:35 +0200
Subject: [RFC] Kbuild: allow code re-use across different directories
In-Reply-To: <CACqU3MUfJAeur_65i5vDegu1d1VqAdq15EedfX9A3w52J23MPg@mail.gmail.com>
References: <1313800642-32418-1-git-send-email-lacombar@gmail.com>
	<4E6A0700.9030401@suse.cz>
	<CACqU3MUfJAeur_65i5vDegu1d1VqAdq15EedfX9A3w52J23MPg@mail.gmail.com>
Message-ID: <4E7007F3.9080305@suse.cz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dne 13.9.2011 23:13, Arnaud Lacombe napsal(a):
> 2011/9/9 Michal Marek <mmarek@suse.cz>:
>> On 20.8.2011 02:37, Arnaud Lacombe wrote:
>>> With the attached patch, we would do:
>>>
>>> arch/foo/boot/Makefile:
>>> LDFLAGS_fancy.o := -DPANTS=30
>>> obj-y += fancy.o
>>> vpath-y += $(srctree)/arch/foo/lib
>>>
>>> and let GNU make do the job.
>>
>> I like this. The only issue I can think of right now, is that if you add
>> a large directory to vpath-y, then it would be easy to accidentally
>> reuse more files from that directory than intended. But that could be
>> easily prevented by isolating those reusable source files.
>>
> I do not think it is that dangerous. We enforce unique access to VPATH
> and we still prioritize $(src) over any other specified path.
> 
> That said, what would you want to pull the patch into -next, beside
> kernel.org being up ?

Just post it with a proper signoff. But there won't be any linux-next
until kernel.org is back again.

Michal
