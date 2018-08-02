From: maxi.jourdan@wanadoo.fr (Maxime Jourdan)
Date: Thu, 2 Aug 2018 15:09:03 +0200
Subject: [PATCH 4/4] drm/meson: convert to the new canvas module
In-Reply-To: <843e41de9fa7d5f87309ff4e0db2ed84a1153a4c.camel@baylibre.com>
References: <20180801185128.23440-1-maxi.jourdan@wanadoo.fr>
 <20180801185128.23440-5-maxi.jourdan@wanadoo.fr>
 <744700e43aed3880807f86abde0caf3df1127e60.camel@baylibre.com>
 <CAHStOZ6B-R7=5utGqb49OsFBsUsMVsn=WMrzNK8Wk-zcgbnPuA@mail.gmail.com>
 <843e41de9fa7d5f87309ff4e0db2ed84a1153a4c.camel@baylibre.com>
Message-ID: <CAHStOZ6v1CAJ-7UVo6V3H0Eu3cYd8x7xSAx33EbO6Eptj0vgdw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2018-08-02 15:01 GMT+02:00 Jerome Brunet <jbrunet@baylibre.com>:
> What I don't like is precisely that you need to expose this 'struct ops' to the
> consumer. I would prefer an API for this (it can be a 1:1 mapping). The canvas
> should remain some abstract object you get from DT.
>
> IMO, this is the same as a reset, a syscon or whatever other phandle you get
> from DT. The consumer should not have to 'care' how it works (how data are
> organized), it should just use it.
>
> Whatever you need to do to deal with your canvas phandle should (IMO) reside in
> your soc/amlogic/meson-canvas.c, and not be spread in the consumers.
>
>>
>> I agree that the "fetch the node" boilerplate code could be put behind
>> a helper, but at the same time this code helps remind the developer
>> that there needs to be a canvas node in the dts, and that it has to be
>> linked in your own device node.
>
> This is why we have a DT documentation.
>
> And, as far as I understand amlogic's display and decoder stuff, you won't get
> very far w/o a canvas, so 'the developer' will be reminded fairly quickly ;)
>
>>
>> I would like to keep it that way if that is okay with you.
>
> It's just my opinion, I'm not the one merging it ... :P
>
>

Fair enough, I'll see to API-ize the module in v2 :).
