From: stanley.miao@windriver.com (stanley.miao)
Date: Mon, 17 Jan 2011 18:23:28 +0800
Subject: [PATCH 2/3] support ARM BE8 mode on a little endian machine
In-Reply-To: <AANLkTimXAtpRz=ZjmN8brHMQNqgGMKhpo=v_sFk_Aeuf@mail.gmail.com>
References: <1295253729-23153-1-git-send-email-stanley.miao@windriver.com>	<1295253729-23153-3-git-send-email-stanley.miao@windriver.com>
	<AANLkTimXAtpRz=ZjmN8brHMQNqgGMKhpo=v_sFk_Aeuf@mail.gmail.com>
Message-ID: <4D3418A0.7050504@windriver.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Catalin Marinas wrote:
> On 17 January 2011 08:42, Stanley.Miao <stanley.miao@windriver.com> wrote:
>   
>> When BE8 kernel is running on a little endian machine, the kernel endian
>> mode need to be converted at the begining of the startup procedure with
>> the instruction "setend be".
>>     
>
> Can we not let the boot loader do this? It could also prepare the tags
> as big endian.
>
>   
Yes, the bootloader can also do this. However, it is dangerous to modify 
the
bootloader. If the new boot loader can't work, it is difficult to update 
the
bootloader again. So, I choose to modify Linux kernel.

Stanley.
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20110117/ce66b171/attachment-0001.html>
