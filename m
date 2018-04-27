From: rishabhb@codeaurora.org (rishabhb at codeaurora.org)
Date: Fri, 27 Apr 2018 15:57:02 -0700
Subject: [PATCH v5 1/2] dt-bindings: Documentation for qcom, llcc
In-Reply-To: <20180427142144.tvy5xamuwz6jnxk5@rob-hp-laptop>
References: <1524524972-12014-1-git-send-email-rishabhb@codeaurora.org>
 <1524524972-12014-2-git-send-email-rishabhb@codeaurora.org>
 <20180427142144.tvy5xamuwz6jnxk5@rob-hp-laptop>
Message-ID: <b458e2bf5b23a4af996e80d81ceabaa4@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2018-04-27 07:21, Rob Herring wrote:
> On Mon, Apr 23, 2018 at 04:09:31PM -0700, Rishabh Bhatnagar wrote:
>> Documentation for last level cache controller device tree bindings,
>> client bindings usage examples.
>> 
>> Signed-off-by: Channagoud Kadabi <ckadabi@codeaurora.org>
>> Signed-off-by: Rishabh Bhatnagar <rishabhb@codeaurora.org>
>> ---
>>  .../devicetree/bindings/arm/msm/qcom,llcc.txt      | 60 
>> ++++++++++++++++++++++
>>  1 file changed, 60 insertions(+)
>>  create mode 100644 
>> Documentation/devicetree/bindings/arm/msm/qcom,llcc.txt
> 
> My comments on v4 still apply.
> 
> Rob

Hi Rob,
Reposting our replies to your comments on v4:

This is partially true, a bunch of SoCs would support this design but
clients IDs are not expected to change. So Ideally client drivers could
hard code these IDs.

However I have other concerns of moving the client Ids in the driver.
The way the APIs implemented today are as follows:
#1. Client calls into system cache driver to get cache slice handle
with the usecase Id as input.
#2. System cache driver gets the phandle of system cache instance from
the client device to obtain the private data.
#3. Based on the usecase Id perform look up in the private data to get
cache slice handle.
#4. Return the cache slice handle to client

If we don't have the connection between client & system cache then the
  private data needs to declared as static global in the system cache 
driver,
that limits us to have just once instance of system cache block.

Please let us know what you think.
