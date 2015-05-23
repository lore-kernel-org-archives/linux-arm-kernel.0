From: clabbe.montjoie@gmail.com (Corentin LABBE)
Date: Sat, 23 May 2015 14:18:06 +0200
Subject: [linux-sunxi] Re: [PATCH v9 4/4] crypto: Add Allwinner Security
 System crypto accelerator
In-Reply-To: <20150515064932.GB16704@gondor.apana.org.au>
References: <1431608341-10936-1-git-send-email-clabbe.montjoie@gmail.com>
 <1431608341-10936-5-git-send-email-clabbe.montjoie@gmail.com>
 <20150515064932.GB16704@gondor.apana.org.au>
Message-ID: <55606FFE.4000902@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Le 15/05/2015 08:49, Herbert Xu a ?crit :
> On Thu, May 14, 2015 at 02:59:01PM +0200, LABBE Corentin wrote:
>>
>> +	err = crypto_ablkcipher_setkey(op->fallback, kkey, op->keylen);
>> +	if (err != 0) {
>> +		dev_err(ss->dev, "Cannot set key on fallback\n");
>> +		return -EINVAL;
>> +	}
> 
> You cannot call setkey from an atomic context.  The easiest solution
> is to call setkey in your setkey function instead.
> 
> Cheers,
> 
Fixed

What do you think about adding a BUG_ON(in_atomic()) in crypto_ablkcipher_setkey() ?

Thanks
