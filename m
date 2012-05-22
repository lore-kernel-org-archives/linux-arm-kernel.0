From: pdeschrijver@nvidia.com (Peter De Schrijver)
Date: Tue, 22 May 2012 15:08:52 +0300
Subject: Clock register in early init
In-Reply-To: <4FBB5A72.2080101@codethink.co.uk>
References: <1337227884.2066.9.camel@pgaikwad-dt2>
 <20120517062131.GA9305@gmail.com>
 <1337316517.22560.19.camel@pgaikwad-dt2>
 <20120518112104.GL20304@tbergstrom-lnx.Nvidia.com>
 <CAJOA=zM_o1Nqw55xxFvw6KssM50Q+7yyo41rUSH2Aoo1neTMjg@mail.gmail.com>
 <20120521084642.GV20304@tbergstrom-lnx.Nvidia.com>
 <4FBB5A72.2080101@codethink.co.uk>
Message-ID: <20120522120851.GI8730@tbergstrom-lnx.Nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> We had at-least that on the older Samsung parts and they where still
> growing. I would suggest that in a multi-kernel image situation the
> more data that can be discarded after init-time the better.
> 
> Also, __initdata gets gathered into one place so there's no possibility
> of page fragmentation there. If you mean fragmentation of the memory
> map, then allocate the size of all the clocks you know of at init time
> in one go.
> 

That would work, except that clocks are needed before kmalloc is available.

Cheers,

Peter.
