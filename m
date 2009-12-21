From: richardliu@ms1.techarea.org (Richard Liu)
Date: Mon, 21 Dec 2009 14:00:25 +0800
Subject: [PATCH] PCI Domains Support
In-Reply-To: <20091220012728.GD12578@verge.net.au>
References: <4B28EB0F.3070409@ms1.techarea.org>	<20091217000620.GC22449@verge.net.au>	<4B2A2B92.6020809@ms1.techarea.org>
	<20091220012728.GD12578@verge.net.au>
Message-ID: <4B2F0EF9.101@ms1.techarea.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Simon Horman wrote:
> On Thu, Dec 17, 2009 at 09:01:06PM +0800, Richard Liu wrote:
>   
>> Dear Simon:
>>
>> Simon Horman wrote:  
>>     
>> ARM is a highly custom platform, just reverse for other platform add
>> their code,
>> Some platforms might need PCI domains, but some platforms not.
>>     
>
> Understood. Do you have any platforms in mind that wouldn't want
> PCI domains? I was just thinking that perhaps PCI_DOMAINS could be added
> later as needed, reducing noise in the code until the need arises.
> But perhaps I'm reading the situation incorrectly.
>   
Actually, most ARM platforms didn't need PCI domains.

So, original patch is

+config PCI_DOMAINS
+        def_bool y
+        depends on PCI && ARCH_CXXXXXX
+

But I removed the "&& ARCH_CXXXXXXX" before I provided the patch.
Because ARCH_CXXXXXXX is not exist in ARM Linux kernel now (maybe it
would be committed at someday)

I traced other ARM platforms,
some platforms like Marvell Orion5x seems has both PCI and PCIe host
controller,
Maybe they can use PCI domain to control their PCI/PCIe host controller.


-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20091221/2622c2af/attachment-0001.htm>
