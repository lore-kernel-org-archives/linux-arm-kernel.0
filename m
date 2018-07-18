From: sebastien.szymanski@armadeus.com (=?UTF-8?Q?S=c3=a9bastien_Szymanski?=)
Date: Wed, 18 Jul 2018 10:19:15 +0200
Subject: [PATCH 1/2] drm/panel: Add support for Armadeus ST0700 Adapt
In-Reply-To: <CAOMZO5Dr0zqy4Sf3s=L4qoqePRhZAXWpDk1oTOUidy4_TUQ=QA@mail.gmail.com>
References: <20180717072318.18730-1-sebastien.szymanski@armadeus.com>
 <CAOMZO5Dr0zqy4Sf3s=L4qoqePRhZAXWpDk1oTOUidy4_TUQ=QA@mail.gmail.com>
Message-ID: <3bfd3bde-55e2-9b68-a8ab-c69dc98097da@armadeus.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Fabio,

On 07/17/2018 02:28 PM, Fabio Estevam wrote:
> Hi S?bastien,
> 
> On Tue, Jul 17, 2018 at 4:23 AM, S?bastien Szymanski
> <sebastien.szymanski@armadeus.com> wrote:
>> This patch adds support for the Armadeus ST0700 Adapt. It comes with a
>> Santek ST0700I5Y-RBSLW 7.0" WVGA (800x480) TFT and an adapter board so
>> that it can be connected on the TFT header of Armadeus Dev boards.
>>
>> Signed-off-by: S?bastien Szymanski <sebastien.szymanski@armadeus.com>
>> ---
>>  .../display/panel/armadeus,st0700-adapt.txt        |  9 +++++++
>>  drivers/gpu/drm/panel/panel-simple.c               | 29 ++++++++++++++++++++++
>>  2 files changed, 38 insertions(+)
>>  create mode 100644 Documentation/devicetree/bindings/display/panel/armadeus,st0700-adapt.txt
>>
>> diff --git a/Documentation/devicetree/bindings/display/panel/armadeus,st0700-adapt.txt b/Documentation/devicetree/bindings/display/panel/armadeus,st0700-adapt.txt
>> new file mode 100644
>> index 000000000000..a30d63db3c8f
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/display/panel/armadeus,st0700-adapt.txt
>> @@ -0,0 +1,9 @@
>> +Armadeus ST0700 Adapt. A Santek ST0700I5Y-RBSLW 7.0" WVGA (800x480) TFT with
>> +an adapter board.
>> +
>> +Required properties:
>> +- compatible: "armadeus,st0700-adapt"
> 
> Shouldn't this be named "santek,st0700i5y" instead?
> 
> Santek is the vendor of the panel and st0700i5y is the model.

You're right but Armadeus doesn't provide the panel as-is. Armadeus adds
an adapter board so it can be connected on the development boards. [1]
Even though the panel supports MEDIA_BUS_FMT_RGB888_1X24, with the
adapter board the bus format has to be MEDIA_BUS_FMT_RGB666_1X18.

[1] http://www.opossom.com/english/products-peripherals-st0700_adapt.html

Regards,

> 
> Then you could add a "santek" entry in
> Documentation/devicetree/bindings/vendor-prefixes.txt.
> 
> Regards,
> 
> Fabio Estevam
> 


-- 
S?bastien Szymanski
Software engineer, Armadeus Systems
Tel: +33 (0)9 72 29 41 44
Fax: +33 (0)9 72 28 79 26
