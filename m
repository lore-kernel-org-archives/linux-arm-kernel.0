From: sebastian.hesselbarth@gmail.com (Sebastian Hesselbarth)
Date: Tue, 25 Sep 2012 01:16:10 +0200
Subject: [PATCH] ARM: Orion5x: Fix too small coherent pool.
In-Reply-To: <20120924173739.GG14266@lunn.ch>
References: <1348466073-22726-1-git-send-email-andrew@lunn.ch>
 <20120924163716.GR5469@titan.lakedaemon.net> <20120924173739.GG14266@lunn.ch>
Message-ID: <5060E9BA.7010806@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/24/2012 07:37 PM, Andrew Lunn wrote:
> On Mon, Sep 24, 2012 at 12:37:16PM -0400, Jason Cooper wrote:
>> On Mon, Sep 24, 2012 at 07:54:33AM +0200, Andrew Lunn wrote:
>>> Some Orion5x devices allocate their coherent buffers from atomic
>>> context. Increase size of atomic coherent pool to make sure such the
>>> allocations won't fail during boot.
>>>
>>> Signed-off-by: Andrew Lunn<andrew@lunn.ch>
>>
>> Acked-by: Jason Cooper<jason@lakedaemon.net>
>>
>> btw - we should take this to it's logical conclusion and have Sebastian
>> check Dove.  Sebastian?
>
> I did think about that. It probably hits if you have two sata
> devices. However, all current Dove machines have just one.

Jason, Andrew,

I did boot arm-soc/for-next on Cubox and looks like 256k pool for atomic
coherent allocations is enough. I booted with sata, sdhci0, eth0, i2c0,
spi0, and both pcie ports forced on without any pcie devices attached.

Sebastian
