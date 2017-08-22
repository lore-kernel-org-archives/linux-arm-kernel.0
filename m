From: marc_gonzalez@sigmadesigns.com (Marc Gonzalez)
Date: Tue, 22 Aug 2017 20:02:18 +0200
Subject: [PATCH v10] PCI: tango: Add MSI controller support
In-Reply-To: <8452c9ca-7131-cf43-d35c-afc4252844f0@arm.com>
References: <7b7278f4-7639-62b3-8a35-e6f7f9afa998@sigmadesigns.com>
 <8452c9ca-7131-cf43-d35c-afc4252844f0@arm.com>
Message-ID: <4b93964c-49eb-efbf-f6b2-956c67694182@sigmadesigns.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 22/08/2017 18:29, Marc Zyngier wrote:

> On 22/08/17 15:56, Marc Gonzalez wrote:
>
>>  #define SMP8759_MUX		0x48
>>  #define SMP8759_TEST_OUT	0x74
>> +#define SMP8759_STATUS		0x80
>> +#define SMP8759_ENABLE		0xa0
>> +#define SMP8759_DOORBELL	0xa002e07c
> 
> Why is this hardcoded and not coming from the device-tree, just like any
> other address property?

Since this bus address is software-configurable, I didn't think
it belonged in the DT. Also, I didn't see anything similar in
other binding docs, especially

Documentation/devicetree/bindings/interrupt-controller/msi.txt

Regards.
