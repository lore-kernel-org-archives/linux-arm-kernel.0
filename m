From: hramrach@gmail.com (Michal Suchanek)
Date: Wed, 12 Aug 2015 14:53:42 +0200
Subject: [linux-sunxi] [PATCH 3/3] mmc: sunxi: use controller automatic
 clock gating.
In-Reply-To: <55CB3D92.6040403@redhat.com>
References: <cover.1439381423.git.hramrach@gmail.com>
 <c33b221f9b622e3bad9d855a7ad1887b82827244.1439381423.git.hramrach@gmail.com>
 <55CB3D92.6040403@redhat.com>
Message-ID: <CAOMqctSVN5y+Hs0_+aaZ=Gu_kr6_-1WONO585Y1bUEg79WJoAw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12 August 2015 at 14:35, Hans de Goede <hdegoede@redhat.com> wrote:
> Hi,
>
> On 12-08-15 14:23, Michal Suchanek wrote:
>>
>> When core does not set the MMC_QUIRK_BROKEN_CLK_GATING flag enable
>> automatic hardware controlled clock gating on the mmc interface.
>>
>> Signed-off-by: Michal Suchanek <hramrach@gmail.com>
>
>
> In general this looks good, but I wonder how intensively this has
> been tested ?

Unlike the wrong timeout it does not cause the boards to crash frequently ;-)

It would be nice if somebody actively using some board atm tested this.

> Also given the long latencies when using manual
> clock on/off support, have you done any testing to check what

I suspect the long latency is due to the controller flushing data to
the card or something like that since it happens only under load.

> sort of latencies this adds, e.g. Both with and without
> the patch, dump all the filesystem caches:
>
> echo 3 > /proc/sys/vm/drop_caches
>
> And then do:
>
> time cat /some/small/file/on/the/sdcard
>
> Do this at least 3 time both with and without the patch, and see
> if there are any noticable differences ?

Yes, it would be good idea to test.

Thanks

Michal
