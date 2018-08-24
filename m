From: kvalo@codeaurora.org (Kalle Valo)
Date: Fri, 24 Aug 2018 11:20:35 +0300
Subject: [PATCH] mt76: Fix comparisons with invalid hardware key index
In-Reply-To: <20180824080817.GA6651@redhat.com> (Stanislaw Gruszka's message
 of "Fri, 24 Aug 2018 10:08:18 +0200")
References: <20180823212738.18431-1-geert@linux-m68k.org>
 <20180824080817.GA6651@redhat.com>
Message-ID: <87pny8jhv0.fsf@kamboji.qca.qualcomm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Stanislaw Gruszka <sgruszka@redhat.com> writes:

> On Thu, Aug 23, 2018 at 11:27:38PM +0200, Geert Uytterhoeven wrote:
>> With gcc 4.1.2:
>> 
>>     drivers/net/wireless/mediatek/mt76/mt76x0/tx.c: In function ?mt76x0_tx?:
>>     drivers/net/wireless/mediatek/mt76/mt76x0/tx.c:169: warning:
>> comparison is always true due to limited range of data type
>>     drivers/net/wireless/mediatek/mt76/mt76x2_tx_common.c: In function ?mt76x2_tx?:
>>     drivers/net/wireless/mediatek/mt76/mt76x2_tx_common.c:35:
>> warning: comparison is always true due to limited range of data type
>> 
>> While assigning -1 to a u8 works fine, comparing with -1 does not work
>> as expected.
>> 
>> Fix this by comparing with 0xff, like is already done in some other
>> places.
>> 
>> Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
>
> Ack for mt76x0. I think Lorenzo already posted patch for mt76x2.

Yeah, Lorenzo's patch is here:

https://patchwork.kernel.org/patch/10570555/

As Geert's patch seems to be more complete I'm planning to take Geert's
version.

-- 
Kalle Valo
