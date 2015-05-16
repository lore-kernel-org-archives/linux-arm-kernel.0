From: clabbe.montjoie@gmail.com (Corentin LABBE)
Date: Sat, 16 May 2015 20:09:27 +0200
Subject: [linux-sunxi] Re: [PATCH v9 4/4] crypto: Add Allwinner Security
 System crypto accelerator
In-Reply-To: <20150515065222.GA16808@gondor.apana.org.au>
References: <1431608341-10936-1-git-send-email-clabbe.montjoie@gmail.com>
 <1431608341-10936-5-git-send-email-clabbe.montjoie@gmail.com>
 <20150515065222.GA16808@gondor.apana.org.au>
Message-ID: <555787D7.80708@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Le 15/05/2015 08:52, Herbert Xu a ?crit :
> On Thu, May 14, 2015 at 02:59:01PM +0200, LABBE Corentin wrote:
>>
>> +int sun4i_hash_export(struct ahash_request *areq, void *out)
>> +{
>> +	struct sun4i_req_ctx *op = ahash_request_ctx(areq);
>> +
>> +	memcpy(out, op, sizeof(struct sun4i_req_ctx));
>> +	return 0;
>> +}
>> +
>> +int sun4i_hash_import(struct ahash_request *areq, const void *in)
>> +{
>> +	struct sun4i_req_ctx *op = ahash_request_ctx(areq);
>> +
>> +	memcpy(op, in, sizeof(struct sun4i_req_ctx));
> 
> This is very wrong.  You're importing an arbitrary ss pointer.  The
> whole point of having an import function instead of just a simple
> memcpy is to deal with such problems.
> 
> Cheers,
> 

Hello

You are right, I have totally mis-understood the export/import functions by just reading them from crypto/md5.c.
Reading them from drivers/crypto/* is better.

Incidental question, I need to use the MD5 IV for export_md5 function, but they are not defined anywhere (unlike SHAxx ones), does this is voluntary or do you will accept a patch for adding them.

Regards
