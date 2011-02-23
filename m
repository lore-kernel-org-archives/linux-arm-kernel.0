From: grant.likely@secretlab.ca (Grant Likely)
Date: Tue, 22 Feb 2011 21:35:30 -0700
Subject: [PATCH v4 7/7] dt: add documentation of ARM dt boot interface
In-Reply-To: <alpine.LFD.2.00.1102222149370.22028@xanadu.home>
References: <20110223021524.18318.71902.stgit@localhost6.localdomain6>
	<20110223022239.18318.87333.stgit@localhost6.localdomain6>
	<alpine.LFD.2.00.1102222149370.22028@xanadu.home>
Message-ID: <AANLkTikoZDR2pCLT8RcS8S03QU1J8cTcDjZzc6ct+QUi@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Feb 22, 2011 at 7:55 PM, Nicolas Pitre <nicolas.pitre@linaro.org> wrote:
> On Tue, 22 Feb 2011, Grant Likely wrote:
>
>> +The boot loader must load a device tree image (dtb) into system ram
>> +at a 64bit aligned address and initialize it with the boot data.
> [...]
>> + ? ? ? ? ? ? ? ?r2 : physical pointer to the device-tree block
>> + ? ? ? ? ? ? ? ?(defined in chapter II) in RAM. ?Device tree can be located
>> + ? ? ? ? ? ? ? ?anywhere in system RAM, but it should be aligned on a 32 bit
>> + ? ? ? ? ? ? ? ?boundary.
>
> So... which one is true?

Oops, I thought I fixed that.  It should be 64 bit boundary (actually,
32 bit is probably just fine, but there are some header fields which
are u64 physical address values so it probably makes sense to keep it
aligned for 64 bits).

g.

>
>
> Nicolas
>



-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
