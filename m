From: peda@axentia.se (Peter Rosin)
Date: Mon, 27 Aug 2018 22:48:11 +0200
Subject: [PATCH v9 0/4] drm/atmel-hlcdc: bus-width override support
In-Reply-To: <20180827224055.3ab63c43@bbrezillon>
References: <20180825085620.10566-1-peda@axentia.se>
 <20180827212449.723bdc99@bbrezillon>
 <ca38bd82-09d2-8e55-a3a2-e0e559abdf7f@axentia.se>
 <20180827223505.7e2fe6f6@bbrezillon> <20180827224055.3ab63c43@bbrezillon>
Message-ID: <26d4d0c2-b59a-40ad-57d1-ab2677253b71@axentia.se>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2018-08-27 22:40, Boris Brezillon wrote:
> On Mon, 27 Aug 2018 22:35:05 +0200
> Boris Brezillon <boris.brezillon@bootlin.com> wrote:
> 
>> On Mon, 27 Aug 2018 22:31:22 +0200
>> Peter Rosin <peda@axentia.se> wrote:
>>
>>> On 2018-08-27 21:24, Boris Brezillon wrote:  
>>>> On Sat, 25 Aug 2018 10:56:16 +0200
>>>> Peter Rosin <peda@axentia.se> wrote:
>>>>     
>>>>> Hi!
>>>>>
>>>>> The background for these patches is that our PCB interface between
>>>>> the SAMA5D3 and the ds90c185 lvds encoder is only using 16 bits, and
>>>>> this has to be described somewhere, or the atmel-hlcdc driver have no
>>>>> chance of selecting the correct output mode. Since we have similar
>>>>> problems with a tda19988 HDMI encoder I added patches to override
>>>>> the atmel-hlcdc output format via DT properties compatible with the
>>>>> media video-interface binding and things start to play together.    
>>>>
>>>> Queued to drm-misc-next.    
>>>
>>> Thanks!
>>>
>>> Minute issue, you seem to have some spell-check going on or something,
>>> because the subject of patch 1/4 has been "corrected" from
>>> "...add ti,ds90c185" to "...add ti, ds90c185"
>>>
>>> You might want to evaluate if that auto-correction "feature" should be
>>> disabled/tweaked/whatever...  
>>
>> Hm, weird. I just downloaded the mbox from dri-devel's patchwork and
>> passed it to dim apply. dim tends to do a lot of things behind the
>> scene, so maybe it's also trying to fix typos :-).
> 
> Nope, looks like it was already wrong on patchwork [1], don't know what
> happened, because the version I have in my mailbox is correct.
> 
> [1]https://patchwork.freedesktop.org/patch/246039/

Apparently a known issue: https://github.com/getpatchwork/patchwork/issues/197

Cheers,
Peter
