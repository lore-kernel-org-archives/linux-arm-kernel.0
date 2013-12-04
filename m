From: stefan@agner.ch (Stefan Agner)
Date: Wed, 04 Dec 2013 09:40:46 +0100
Subject: [PATCH v4 1/3] mfd: tps6586x: add version detection
In-Reply-To: <20131204081021.GB7469@lee--X1>
References: <cover.1386108712.git.stefan@agner.ch>
 <77384d24810d9a22fc04cad6f7468f54a9cbaafe.1386108712.git.stefan@agner.ch>
 <20131204081021.GB7469@lee--X1>
Message-ID: <e2ae7b9602d0c1e11f8e56ced17e9da0@agner.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am 2013-12-04 09:10, schrieb Lee Jones:
>> +int tps6586x_get_version(struct device *dev)
>> +{
>> +	struct tps6586x *tps6586x = dev_get_drvdata(dev);
>> +
>> +	return tps6586x->version;
>> +}
>> +EXPORT_SYMBOL_GPL(tps6586x_get_version);
> 
> I thought Mark suggested that this routine was converted to a 'static
> inline' and moved into the header? Did you not think this was a good
> idea?
As I pointed out in the comment above, the struct tps6586x is in the C
file, so I would need to move that too. That's why I did not made that
change in the end. What do you think, should I still move (and move the
struct too?) 
