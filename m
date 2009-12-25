From: richardliu@ms1.techarea.org (Richard Liu)
Date: Sat, 26 Dec 2009 05:58:05 +0800
Subject: [PATCH] PCI Domains Support
In-Reply-To: <20091222045540.GB4411@verge.net.au>
References: <4B28EB0F.3070409@ms1.techarea.org>	<20091217000620.GC22449@verge.net.au>	<4B2A2B92.6020809@ms1.techarea.org>	<20091220012728.GD12578@verge.net.au>	<4B2F0EF9.101@ms1.techarea.org>
	<20091222045540.GB4411@verge.net.au>
Message-ID: <4B35356D.7090604@ms1.techarea.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Simon Horman wrote:
>> Actually, most ARM platforms didn't need PCI domains.
>>
>> So, original patch is
>>
>> +config PCI_DOMAINS
>> +        def_bool y
>> +        depends on PCI && ARCH_CXXXXXX
>> +
>>
>> But I removed the "&& ARCH_CXXXXXXX" before I provided the patch.
>> Because ARCH_CXXXXXXX is not exist in ARM Linux kernel now (maybe it
>> would be committed at someday)
>>     
>
> Ok, now I am completely confused. Nothing currently in-tree should
> use PCI_DOMAINS, but it defaults to y and nothing switches it to n?
>
> Perhaps the following would be more appropriate:
>
> config PCI_DOMAINS
>         bool
>
> And then platforms can "select PCI_DOMAINS" as needed.
>
>   
You are right,
Don't use def_bool is right choice.

I only maintain one arch, so I didn't think too much.

Should I regenerate a new patch, or you will handle it ?


-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20091226/b630705f/attachment-0001.htm>
