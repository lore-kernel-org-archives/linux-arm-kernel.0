From: georgi.djakov@linaro.org (Georgi Djakov)
Date: Tue, 16 May 2017 17:59:02 +0300
Subject: [RFC v1 2/3] interconnect: Add Qualcomm msm8916 interconnect
 provider driver
In-Reply-To: <CAMuHMdXM3f+P8ZyydxnO5z2g3F2n2c3KzfDFbC6jYgZJt+1ULw@mail.gmail.com>
References: <20170515153527.27649-1-georgi.djakov@linaro.org>
 <20170515153527.27649-3-georgi.djakov@linaro.org>
 <CAMuHMdXM3f+P8ZyydxnO5z2g3F2n2c3KzfDFbC6jYgZJt+1ULw@mail.gmail.com>
Message-ID: <5bd5fbd9-ee12-a414-88ce-32b286318616@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/15/2017 07:01 PM, Geert Uytterhoeven wrote:
> Hi Georgi,
> 
> On Mon, May 15, 2017 at 5:35 PM, Georgi Djakov <georgi.djakov@linaro.org> wrote:
>> --- /dev/null
>> +++ b/drivers/interconnect/qcom/interconnect_msm8916.c
> 
>> +struct qcom_interconnect_node {
>> +       struct interconnect_node node;
>> +       unsigned int id;
> 
> 4 byte gap due to alignment rules on 64-bit.
> 
>> +       unsigned char *name;
>> +       struct interconnect_node *links[8];
>> +       int num_links;
>> +       int port;
>> +       int buswidth;
> 
> 4 byte gap due to alignment rules.
> 
>> +       u64 ib;
>> +       u64 ab;
>> +       u64 rate;
>> +};
> 
> You can avoid the gaps by putting members of the same size and alignment
> together.

Thanks Geert, i will rearrange this to reduce the padding bytes!

BR,
Georgi
