From: georgi.djakov@linaro.org (Georgi Djakov)
Date: Wed, 6 Jun 2018 18:23:00 +0300
Subject: [PATCH v4 2/7] dt-bindings: Introduce interconnect provider
 bindings
In-Reply-To: <7723f351-2460-7378-411a-cfcdf4138d8f@baylibre.com>
References: <20180309210958.16672-1-georgi.djakov@linaro.org>
 <20180309210958.16672-3-georgi.djakov@linaro.org>
 <7723f351-2460-7378-411a-cfcdf4138d8f@baylibre.com>
Message-ID: <8fd1092a-40cd-b2a4-b153-df67e16bb4b3@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Neil,

Apologies for the delayed response.

On 12.04.18 ?. 16:15, Neil Armstrong wrote:
> On 09/03/2018 22:09, Georgi Djakov wrote:
>> This binding is intended to represent the interconnect hardware present
>> in some of the modern SoCs. Currently it consists only of a binding for
>> the interconnect hardware devices (provider).
>>
>> Signed-off-by: Georgi Djakov <georgi.djakov@linaro.org>
>> ---
>>  .../bindings/interconnect/interconnect.txt         | 47 ++++++++++++++++++++++
>>  1 file changed, 47 insertions(+)
>>  create mode 100644 Documentation/devicetree/bindings/interconnect/interconnect.txt
>>
>> diff --git a/Documentation/devicetree/bindings/interconnect/interconnect.txt b/Documentation/devicetree/bindings/interconnect/interconnect.txt
>> new file mode 100644
>> index 000000000000..70612bb201e4
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/interconnect/interconnect.txt
>> @@ -0,0 +1,47 @@
>> +Interconnect Provider Device Tree Bindings
>> +=========================================
>> +
>> +The purpose of this document is to define a common set of generic interconnect
>> +providers/consumers properties.
>> +
>> +
>> += interconnect providers =
>> +
>> +The interconnect provider binding is intended to represent the interconnect
>> +controllers in the system. Each provider registers a set of interconnect
>> +nodes, which expose the interconnect related capabilities of the interconnect
>> +to consumer drivers. These capabilities can be throughput, latency, priority
>> +etc. The consumer drivers set constraints on interconnect path (or endpoints)
>> +depending on the usecase. Interconnect providers can also be interconnect
>> +consumers, such as in the case where two network-on-chip fabrics interface
>> +directly
> 
> Hi,
> 
> Can't we specify the number of cells for the phandle ? It should be aligned with other consumer/provider bindings.

Yes, that's the plan. Will align it!

Thanks,
Georgi
