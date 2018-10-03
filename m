From: jae.hyun.yoo@linux.intel.com (Jae Hyun Yoo)
Date: Wed, 3 Oct 2018 10:10:23 -0700
Subject: [PATCH i2c-next v4 2/3] i2c: aspeed: Add 'timeout' DT property
 reading code
In-Reply-To: <CACPK8XeuFm_GYFhe-KimOHV7y7PBdFjhMGG+QAmfNrfOcb488A@mail.gmail.com>
References: <20181001202748.8030-1-jae.hyun.yoo@linux.intel.com>
 <20181001202748.8030-3-jae.hyun.yoo@linux.intel.com>
 <CACPK8XeuFm_GYFhe-KimOHV7y7PBdFjhMGG+QAmfNrfOcb488A@mail.gmail.com>
Message-ID: <9951c217-70c1-81cf-a43d-baf6bb02beb9@linux.intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Joel,

On 10/3/2018 12:49 AM, Joel Stanley wrote:
> Hello Jae,
> 
> On Mon, 1 Oct 2018 at 22:28, Jae Hyun Yoo <jae.hyun.yoo@linux.intel.com> wrote:
>> @@ -918,6 +919,11 @@ static int aspeed_i2c_probe_bus(struct platform_device *pdev)
>>                  bus->bus_frequency = 100000;
>>          }
>>
>> +       ret = of_property_read_u32(pdev->dev.of_node, "timeout",
>> +                                  &timeout_ms);
>> +       if (ret)
>> +               timeout_ms = 0; /* then adap.timeout will be set by i2c-core */
> 
> Is it possible to implement the parsing of this property in the i2c
> core instead?
> 

Yes, that's possible but I'm not sure that could be acceptable or not.
Let me try.

Thanks,
Jae
