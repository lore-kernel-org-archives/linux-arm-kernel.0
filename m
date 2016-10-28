From: woogyom.kim@gmail.com (Milo Kim)
Date: Fri, 28 Oct 2016 13:04:33 +0900
Subject: [PATCH 7/7] mfd: tps65217: Fix mismatched interrupt number
In-Reply-To: <20161026135631.GC13127@dell>
References: <20161021140106.21531-1-woogyom.kim@gmail.com>
 <20161021140106.21531-8-woogyom.kim@gmail.com> <20161026135631.GC13127@dell>
Message-ID: <08151892-96b0-2a9b-5b5a-b91bec94e247@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/26/2016 10:56 PM, Lee Jones wrote:
>> diff --git a/include/linux/mfd/tps65217.h b/include/linux/mfd/tps65217.h
>> > index 4ccda89..75a3a5f 100644
>> > --- a/include/linux/mfd/tps65217.h
>> > +++ b/include/linux/mfd/tps65217.h
>> > @@ -235,9 +235,9 @@ struct tps65217_bl_pdata {
>> >  };
>> >
>> >  enum tps65217_irq_type {
>> > -	TPS65217_IRQ_PB,
>> > -	TPS65217_IRQ_AC,
>> >  	TPS65217_IRQ_USB,
>> > +	TPS65217_IRQ_AC,
>> > +	TPS65217_IRQ_PB,
>> >  	TPS65217_NUM_IRQ
>> >  };
> This is why using enum for these types of assignments is sometimes
> dangerous.  It's probably best to be explicit.

I agree with you. Let me fix in v2 - use #define instead of enum type.

Best regards,
Milo
