From: peter.ujfalusi@ti.com (Peter Ujfalusi)
Date: Tue, 21 Nov 2017 13:42:27 +0200
Subject: [PATCH 05/10] dmaengine: bcm2835-dma: Use vchan_terminate_vdesc()
 instead of desc_free
In-Reply-To: <87k1yr4blm.fsf@anholt.net>
References: <20171114143212.8311-1-peter.ujfalusi@ti.com>
 <20171114143212.8311-6-peter.ujfalusi@ti.com> <87k1yr4blm.fsf@anholt.net>
Message-ID: <2f3d48dd-f6a8-a3ff-635e-296f3e0f75f1@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Eric,

On 11/15/2017 08:53 PM, Eric Anholt wrote:
> Peter Ujfalusi <peter.ujfalusi@ti.com> writes:
> 
>> To avoid race with vchan_complete, use the race free way to terminate
>> running transfer.
>>
>> Implement the device_synchronize callback to make sure that the terminated
>> descriptor is freed.
>>
>> CC: Martin Sperl <kernel@martin.sperl.org>
>> CC: Eric Anholt <eric@anholt.net>
>> Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
> 
> I haven't fully followed the series, but thanks for porting your fix to
> other platforms!
I have seen similar patterns in these drivers and it was the right thing to do
imho.
Unfortunately I can not test on other platforms than eDMA and sDMA, but I
firmly believe that based on the usage it should be fine as it survives my
torture tests.

It would be great to see some Tested-by from others to have more coverage.

> Acked-by: Eric Anholt <eric@anholt.net>

Thank you!


-- 
P?ter

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
