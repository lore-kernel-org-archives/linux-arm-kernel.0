From: leoli@freescale.com (Li Yang)
Date: Tue, 8 Sep 2015 15:06:16 -0500
Subject: [PATCH v2 04/10] doc/bindings: Update PCIe devicetree binding
 documentation for LS2080A
In-Reply-To: <80094129.LHZFOe1ZPU@wuerfel>
References: <1441349872-4560-1-git-send-email-bhupesh.sharma@freescale.com>
 <1441349872-4560-5-git-send-email-bhupesh.sharma@freescale.com>
 <80094129.LHZFOe1ZPU@wuerfel>
Message-ID: <CADRPPNR-cSSQC5sLMmoqcxX46J6hdULa_V4v2BK7T8s8pcX0cg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Sep 7, 2015 at 6:32 AM, Arnd Bergmann <arnd@arndb.de> wrote:
> On Friday 04 September 2015 12:27:46 Bhupesh Sharma wrote:
>> @@ -4,7 +4,8 @@ This PCIe host controller is based on the Synopsis Designware PCIe IP
>>  and thus inherits all the common properties defined in designware-pcie.txt.
>>
>>  Required properties:
>> -- compatible: should contain the platform identifier such as "fsl,ls1021a-pcie"
>> +- compatible: should contain the platform identifier such as "fsl,ls1021a-pcie",
>> +  "fsl,ls2080a-pcie".
>>  - reg: base addresses and lengths of the PCIe controller
>>  - interrupts: A list of interrupt outputs of the controller. Must contain an
>>    entry for each entry in the interrupt-names property.
>>
>
> Are the two PCIe hosts mutually compatible? If they are, you should mandate
> one of the strings as the base model for identification, with the additional
> model being optional for identification of the specific SoC.

It seems that controllers on these chips are not exactly the same.
They will get different driver data by matching the compatible
strings.  Probably we could define a more generic compatible string,
such as "fsl,layerscape-pcie" or "fsl,ls-pcie".

>
> It would also be good to add a string with the specific version number of the
> designware PCIe block that is being used there.

The binding has mentioned to reference the designware-pcie.txt.  But
it might be more clear to mention the designware compatible string
"snps,dw-pcie" again in the compatible part.  Currently there is no
version number defined in the designware-pcie binding.  It might be
hard to get this information for some SoCs.

Regards,
Leo
