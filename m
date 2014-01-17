From: tinamdar@apm.com (Tanmay Inamdar)
Date: Thu, 16 Jan 2014 17:17:26 -0800
Subject: [RFC PATCH V2 3/4] dt-bindings: pci: xgene pcie device tree
 bindings
In-Reply-To: <201401151057.43044.arnd@arndb.de>
References: <1389742458-7693-1-git-send-email-tinamdar@apm.com>
 <1389742458-7693-4-git-send-email-tinamdar@apm.com>
 <201401151057.43044.arnd@arndb.de>
Message-ID: <CACoXjcmQ5esXH+8OSuFN0r_qLRt1fqfu+oZ56OnfOt4J2pWLvw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 15, 2014 at 1:57 AM, Arnd Bergmann <arnd@arndb.de> wrote:
> On Wednesday 15 January 2014, Tanmay Inamdar wrote:
>> This patch adds the bindings for X-Gene PCIe driver. The driver resides
>> under 'drivers/pci/host/pci-xgene.c' file.
>>
>> Signed-off-by: Tanmay Inamdar <tinamdar@apm.com>
>> ---
>>  .../devicetree/bindings/pci/xgene-pcie.txt         |   45 ++++++++++++++++++++
>>  1 file changed, 45 insertions(+)
>>  create mode 100644 Documentation/devicetree/bindings/pci/xgene-pcie.txt
>>
>> diff --git a/Documentation/devicetree/bindings/pci/xgene-pcie.txt b/Documentation/devicetree/bindings/pci/xgene-pcie.txt
>> new file mode 100644
>> index 0000000..19b9c28
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/pci/xgene-pcie.txt
>> @@ -0,0 +1,45 @@
>> +* AppliedMicro X-Gene PCIe interface
>> +
>> +Required properties:
>> +- status: Either "ok" or "disabled".
>
> "status" isn't normally a required property. The default interpretation is
> that a node without a status property is active.

ok. I will move 'status' under optional properties.

>
>> +- device_type: set to "pci"
>> +- compatible: should contain "xgene,pcie" to identify the core.
>> +- reg: base addresses and lengths of the pcie controller configuration
>> +     space register.
>
> Doesn't match the code or example: You only list one area here, but
> you actually need to register sets.

ok. I will update

>
> Looks good otherwise now.
>
>         Arnd
