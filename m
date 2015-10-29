From: lars@metafoo.de (Lars-Peter Clausen)
Date: Thu, 29 Oct 2015 10:17:53 +0100
Subject: [PATCH v4 4/4] iio: humidity: si7020: added No Hold read mode
In-Reply-To: <ba63445a2f9af32bcbad698039041cbf@rainloop.corna.info>
References: <563117FB.5030506@metafoo.de> <5630977D.2020102@metafoo.de>
 <f113de76b2369d404909cfc5158feca4@rainloop.corna.info>
 <1446015506-21371-1-git-send-email-nicola@corna.info>
 <aa9c6c7ffdd5083c110cb35723081dbf@rainloop.corna.info>
 <ba63445a2f9af32bcbad698039041cbf@rainloop.corna.info>
Message-ID: <5631E441.6030600@metafoo.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

>> So maybe more like this:
>>
>> static inline bool i2c_check_quirks(struct i2c_adapter *adap, u64 quirks)
>> {
>> if (!adap->quirks)
>> return false;
>> return (adap->quirks->flags & quirks) == quirks;
>> }
> 
> Should I use bool (like in your snippet) or int (like i2c_check_functionality) as return type?

I'd use bool, given that the result is a boolean value. It's semantically
more clear this way.
