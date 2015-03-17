From: hns@goldelico.com (Dr. H. Nikolaus Schaller)
Date: Tue, 17 Mar 2015 09:59:34 +0100
Subject: [PATCH v3 3/6] Documentation: DT: Document twl4030-madc-battery
 bindings
In-Reply-To: <20150317084849.GB9761@amd>
References: <1423088075-10025-1-git-send-email-marek@goldelico.com>
 <1423088075-10025-4-git-send-email-marek@goldelico.com>
 <20150316210532.GA11441@amd>
 <CAAfyv34vnRY=TAyx4+7s1SW7rVE7CFh9z+OOcCsbCx63y9aVog@mail.gmail.com>
 <B8616E57-51B5-446E-87D5-9C3EC9B5F1C9@goldelico.com>
 <20150317084849.GB9761@amd>
Message-ID: <86E29CFB-0345-400E-8085-CC2DA549B79A@goldelico.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Am 17.03.2015 um 09:48 schrieb Pavel Machek <pavel@ucw.cz>:

>> 
>> Temperature calibration should have already been done in the underlaying twl4030 iio driver.
>> 
>> Discharge rate is the real current flow reported in uA. Also
>> reported by iio.
> 
> Ack, but there's rather severe temperature dependency of the lithium
> battery, which you should take into account if you want to compute
> ?percentage charged".

We just want to estimate it as good as possible. 5-10% is sufficient
and better than no value at all (which is what you get without this
driver).

And, we just convert the (existing) driver from non-DT to DT and to use
iio, so we do not want to change the inner logic what it does and how it
works.

BR,
Nikolaus
